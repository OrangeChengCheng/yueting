//
//  BDDetailViewController.m
//  YueTing
//
//  Created by lanouhn on 16/3/15.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import "BDDetailViewController.h"
#import "DetailTableViewCell.h"
#import "ListTableViewCell.h"
#import "AFNetworking.h"
#import "Detail.h"
#import "JokeModel.h"
#import "PlayMusicViewController.h"
#import "AppDelegate.h"
#import "Login.h"
#import "UMSocial.h"
#import "DownLoadViewController.h"
#define Detail(A) [NSString stringWithFormat:@"http://117.25.143.73/yyting/bookclient/ClientGetBookDetail.action?id=%ld&token=aIFEKzXA5K5fcVc9WLp_I6FRifS7RJpOQb63ToXOFc8*&imei=ODY0Mzg3MDIwMDMxNTg1", A]
#define List(B) [NSString stringWithFormat:@"http://117.25.143.73/yyting/bookclient/ClientGetBookResource.action?bookId=%ld&pageNum=1&pageSize=50&sortType=0&token=aIFEKzXA5K5fcVc9WLp_I6FRifS7RJpOQb63ToXOFc8*&imei=ODY0Mzg3MDIwMDMxNTg1", B]
@interface BDDetailViewController ()<UMSocialUIDelegate>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *collectB;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentD;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSMutableArray *dataSourceL;
@property (nonatomic, strong)  NSManagedObjectContext *managedObjectContext;
@property (nonatomic) NSInteger have;
@end

@implementation BDDetailViewController
- (NSMutableArray *)dataSource {
    if (_dataSource == nil) {
        self.dataSource = [NSMutableArray array];
    }
    return _dataSource;
}
- (NSMutableArray *)dataSourceL {
    if (_dataSourceL == nil) {
        self.dataSourceL = [NSMutableArray array];
    }
    return _dataSourceL;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.navigationItem.title = self.nameB;
    [self handleNetWorkWithID:self.idB];
    [self handleNetWorkWithListID:self.idB];
    
    AppDelegate *delega = [UIApplication sharedApplication].delegate;
    self.managedObjectContext = delega.managedObjectContext;
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Collect"];
    NSArray *array = [self.managedObjectContext executeFetchRequest:request error:nil];
    NSMutableArray *temp = [NSMutableArray array];
    [temp addObjectsFromArray:array];
    for (Login *log in temp) {
        if ([log.name isEqualToString:self.nameB]) {
            self.have+=1;
        }
    }
    if (self.have > 0) {
        self.collectB.tintColor = [UIColor redColor];
    }
}
- (void)handleNetWorkWithID:(NSInteger)idDt {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    [manager GET:Detail(idDt) parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        Detail *detail = [[Detail alloc]init];
        detail.imageDt = responseObject[@"cover"];
        detail.nameDt = responseObject[@"name"];
        detail.zhuboDt = responseObject[@"announcer"];
        detail.timeDt = responseObject[@"update"];
        detail.descDt = responseObject[@"desc"];
        detail.renqiDt = [responseObject[@"play"] integerValue];
        detail.stateDt = [responseObject[@"state"] integerValue];
        detail.jiShuDt = [responseObject[@"sections"] integerValue];
        [self.dataSource addObject:detail];
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
}
- (void)handleNetWorkWithListID:(NSInteger)idList {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    [manager GET:List(idList) parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableArray *array = responseObject[@"list"];
        for (NSMutableDictionary *dic in array) {
            JokeModel *jokeM = [[JokeModel alloc]init];
            jokeM.title= dic[@"name"];
            jokeM.audio_64_url = dic[@"path"];
            jokeM.duration = dic[@"length"];
            jokeM.totalLength = [dic[@"size"] integerValue];
            [self.dataSourceL addObject:jokeM];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
}
- (IBAction)handelSegment:(UISegmentedControl *)sender {
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.segmentD.selectedSegmentIndex == 0) {
        return 1;
    }else {
        return self.dataSourceL.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.segmentD.selectedSegmentIndex == 0 && self.dataSource.count > 0) {
        DetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"detailCell" forIndexPath:indexPath];
        Detail *det = self.dataSource[indexPath.row];
        [cell getDetail:det];
        NSDictionary *attributes = @{NSFontAttributeName : [UIFont systemFontOfSize:15]};
        CGFloat height = [cell.detailLabel.text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 30, 0) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributes context:nil].size.height;
        cell.detailH.constant = height + 5;
        self.tableView.rowHeight = 220 + height + 67;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (self.segmentD.selectedSegmentIndex != 0 && self.dataSourceL.count > 0) {
        ListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"listCell" forIndexPath:indexPath];
        JokeModel *down = self.dataSourceL[indexPath.row];
        cell.nameList.text = down.title;
        cell.countList.text = [NSString stringWithFormat:@"大小：%.2fM", (down.totalLength / 1024.0) / 1024];
        if ([down.duration integerValue] % 60 > 9) {
            cell.timeLabel.text = [NSString stringWithFormat:@"时长：%ld:%ld", [down.duration integerValue]/ 60, [down.duration integerValue] % 60];
        }else {
        cell.timeLabel.text = [NSString stringWithFormat:@"时长：%ld:0%ld", [down.duration integerValue]/ 60, [down.duration integerValue] % 60];
        }
        cell.downLoad.tag = indexPath.row;
        self.tableView.rowHeight = 86;
        return cell;
    }
    DetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"detailCell" forIndexPath:indexPath];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.segmentD.selectedSegmentIndex != 0) {
        //1:获取音乐播放器对象
        PlayMusicViewController *playMusicv = [PlayMusicViewController shareWithPlayMusicViewController];
        //2:完成界面跳转
        [self.navigationController pushViewController:playMusicv animated:YES];
        
        //传递需要播放的数据源和对应的下标
        playMusicv.dataSource = self.dataSourceL;
        playMusicv.index = indexPath.row;
        //开始播放
        [playMusicv playMusic];
    }
}
- (IBAction)handleDownLoad:(UIButton *)sender {
    ListTableViewCell *cell = (ListTableViewCell *)sender.superview.superview;
    NSIndexPath *index = [self.tableView indexPathForCell:cell];
    JokeModel *joke = self.dataSourceL[index.row];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"downLoad" object:joke];
}
- (IBAction)handleCollection:(UIBarButtonItem *)sender {
    self.have = 0;
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Collect"];
    NSArray *array = [self.managedObjectContext executeFetchRequest:request error:nil];
    NSMutableArray *temp = [NSMutableArray array];
    [temp addObjectsFromArray:array];
    for (Login *log in temp) {
        if ([log.name isEqualToString:self.nameB]) {
            self.have += 1;
        }
    }
    if (self.have < 1) {
        Login *login = [NSEntityDescription insertNewObjectForEntityForName:@"Collect" inManagedObjectContext:self.managedObjectContext];
        Detail *detail = self.dataSource.firstObject;
        login.image = detail.imageDt;
        login.name = detail.nameDt;
        login.zhubo = detail.zhuboDt;
        login.jishu = [NSString stringWithFormat:@"%ld", detail.jiShuDt];
        login.renqi = [NSString stringWithFormat:@"%ld", detail.renqiDt];
        login.state = [NSString stringWithFormat:@"%ld", detail.stateDt];
        login.idC = [NSString stringWithFormat:@"%ld", self.idB];
        [self.managedObjectContext save:nil];
        self.collectB.tintColor = [UIColor redColor];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"收藏成功" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:action1];
        [self presentViewController:alert animated:YES completion:nil];
    }else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"您已经收藏过了" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:action1];
        [self presentViewController:alert animated:YES completion:nil];
    }
}
- (IBAction)handleZan:(UIButton *)sender {
    NSLog(@"点赞");
}
- (IBAction)handleShare:(UIButton *)sender {
    NSLog(@"分享");
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"507fcab25270157b37000010"
                                      shareText:@"你要分享的文字"
                                     shareImage:[UIImage imageNamed:@"icon.png"]
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent, UMShareToRenren, UMShareToDouban,nil]
                                       delegate:self];
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
