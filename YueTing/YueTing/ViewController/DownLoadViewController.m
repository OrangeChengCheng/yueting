//
//  DownLoadViewController.m
//  YueTing
//
//  Created by lanouhn on 16/3/22.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import "DownLoadViewController.h"
#import "JokeModel.h"
#import "DownLoadView.h"
#import "FMDatabase.h"
@interface DownLoadViewController ()<DownLoadViewDelegate>
@property (nonatomic, strong) IBOutlet UIScrollView *contentScrollView;
@property (nonatomic) NSInteger index;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSMutableArray *downLoadViews;
@property (nonatomic, strong) FMDatabase *db;

@end

@implementation DownLoadViewController
+ (DownLoadViewController *)shareWithDownLoadViewController {
    static DownLoadViewController *downV = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        downV = [[DownLoadViewController alloc]initWithNibName:@"DownLoadViewController" bundle:nil];
    });
    return downV;
}
- (NSMutableArray *)dataSource {
    if (_dataSource == nil) {
        self.dataSource = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataSource;
}
- (NSMutableArray *)downLoadViews {
    if (_downLoadViews == nil) {
        self.downLoadViews = [NSMutableArray arrayWithCapacity:0];
    }
    return _downLoadViews;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addObserverOfNotfication];
    [self handleUnFinishedWork];
    
}
- (void)addObserverOfNotfication {
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(handleDownLoadAction:)  name:@"downLoad" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(handleDataBase:) name:@"insert" object:nil];
}
- (void)removeObserverOfNotification {
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"downLoad" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"insert" object:nil];
}
- (void)handleUnFinishedWork {
    [self selectDataBase];
    if (self.dataSource.count > 0) {
        self.index++;
        CGFloat height = 0;
        while (self.index <= self.dataSource.count) {
            JokeModel  *joke = self.dataSource[self.index  - 1];
            DownLoadView *downV = [self startLayoutOfDownLoadViewWithJoke:joke];
            height = downV.frame.size.height;
            self.index++;
        }
        self.contentScrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, height * self.dataSource.count + 10 * (self.dataSource.count + 1));
        self.index--;
    }
}
- (void)handleDownLoadAction:(NSNotification *)notify {
    JokeModel *joke = notify.object;
    if (![self.dataSource containsObject:joke]) {
        self.index++;
        [self.dataSource addObject:joke];
        //布局DownLoadView界面
        DownLoadView *downV = [self startLayoutOfDownLoadViewWithJoke:joke];
        self.contentScrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, (self.index + 1) * 10 + self.index * downV.frame.size.height);
        //判断当前有多少个任务正在执行
        NSInteger playing_num = [[[NSUserDefaults standardUserDefaults] valueForKey:@"Playing_num"] integerValue];
        if (playing_num <= 3) {
            [downV startDownLoadWithData:nil];
        }
    }
}
- (DownLoadView *)startLayoutOfDownLoadViewWithJoke:(JokeModel *)joke {
    DownLoadView *downV = [[[NSBundle mainBundle]loadNibNamed:@"DownLoadView" owner:self options:nil] firstObject];
    downV.frame = CGRectMake(10, 10*self.index + downV.frame.size.height*(self.index - 1), [UIScreen mainScreen].bounds.size.width - 20, downV.frame.size.height);
    [downV addObserverForApplicationState];
    if (joke.totalLength > 0) {
        NSMutableData *mutableData = [self getReceivedDataLength:joke.audio_64_url];
        downV.progressV.progress = mutableData.length * 1.0 / joke.totalLength;
        downV.mutableData = mutableData;
        downV.totalLength = joke.totalLength;
    }
    downV.titleLabel.text = joke.title;
    downV.joke = joke;
    downV.delegate = self;
    [self.contentScrollView addSubview:downV];
    [self.downLoadViews addObject:downV];
    return downV;
}
- (NSMutableData *)getReceivedDataLength:(NSString *)url {
    NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSString *detailPath = [NSString stringWithFormat:@"%@/mp3/%@", filePath, url];
    return [NSMutableData dataWithContentsOfFile:detailPath];
}
- (void)removeDownLoad:(DownLoadView *)downLoadV {
    NSInteger index = [self.downLoadViews indexOfObject:downLoadV];
    JokeModel *joke = self.dataSource[index];
    [self deleteDataFromDataBase:joke.title];
    [self.dataSource removeObjectAtIndex:index];
    [self.downLoadViews removeObjectAtIndex:index];
    [downLoadV removeFromSuperview];
    if (self.dataSource.count > 3) {
        DownLoadView *downLoad = self.downLoadViews[2];
        downLoadV.joke = self.dataSource[2];
        [downLoad startDownLoadWithData:nil];
    }
    self.index = index + 1;
    while (self.index <= self.downLoadViews.count) {
        DownLoadView *downLoadV = self.downLoadViews[self.index - 1];
        downLoadV.frame = CGRectMake(10, 10*self.index + downLoadV.frame.size.height * (self.index - 1), [UIScreen mainScreen].bounds.size.width - 20, downLoadV.frame.size.height);
        self.index++;
    }
    self.index--;
}
- (void)handleDataBase:(NSNotification *)notify {
    JokeModel *joke = notify.object;
    [self insertJokeMadel:joke];
}

#pragma mark FMDB
- (FMDatabase *)db {
    if (_db == nil) {
        self.db = [FMDatabase databaseWithPath:[self getDocumentsPath]];
    }
    return _db;
}
- (NSString *)getDocumentsPath {
    NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    return [filePath stringByAppendingPathComponent:@"Joke.sqlite"];
}
- (void)creatTable {
    [self.db open];
    BOOL result = [self.db executeUpdate:@"create table if not exists  JokeList(title text primary key, duration text, play_num text, audio_url text, totalLength integer)"];
    if (result == YES) {
        NSLog(@"表创建成功");
    }
    [self.db close];
}
- (void)insertJokeMadel:(JokeModel *)joke {
    [self.db open];
    BOOL result = [self.db executeUpdate:@"insert into JokeList(title, duration, play_num, audio_url, totalLength)values(?, ?, ?, ?, ?)", joke.title, joke.duration, joke.play_num, joke.audio_64_url, @(joke.totalLength)];
    if (result == YES) {
        NSLog(@"数据插入成功");
    }
    [self.db close];
}
- (void)deleteDataFromDataBase:(NSString *)title {
    [self.db open];
    BOOL result = [self.db executeUpdate:@"delete from JokeList where title = ?", title];
    if (result == YES) {
        NSLog(@"删除成功");
    }
    [self.db close];
}
- (void)selectDataBase {
    [self.db open];
    FMResultSet *resultSet = [self.db executeQuery:@"select * from JokeList"];
    if ([resultSet next]) {
        JokeModel *joke = [[JokeModel alloc]init];
        joke.title = [resultSet stringForColumn:@"title"];
        joke.duration = [resultSet stringForColumn:@"duration"];
        joke.play_num = [resultSet stringForColumn:@"play_num"];
        joke.audio_64_url = [resultSet stringForColumn:@"audio_url"];
        joke.totalLength = [resultSet intForColumn:@"totalLength"];
        [self.dataSource addObject:joke];
        NSLog(@"%@", joke.title);
    }
    [self.db close];
}
- (void)updateDataBaseWithJokeModal:(JokeModel *)joke {
    [self.db open];
    [self.db close];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
