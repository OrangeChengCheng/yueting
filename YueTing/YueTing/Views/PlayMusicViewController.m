//
//  PlayMusicViewController.m
//  FMLesson
//
//  Created by lanouhn on 16/2/24.
//  Copyright (c) 2016年 Orange. All rights reserved.
//

#import "PlayMusicViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "JokeModel.h"
@interface PlayMusicViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *backgroundImage; //背景
@property (strong, nonatomic) IBOutlet UILabel *titleLabel; //标题
@property (strong, nonatomic) IBOutlet UIImageView *needle; //播放杆
@property (strong, nonatomic) IBOutlet UISlider *progressSlider; //进度条
@property (strong, nonatomic) IBOutlet UIButton *playBtn;

@property (nonatomic ,strong) NSTimer *timer; //存储时间计时器对象
@property (nonatomic, strong) AVPlayer *player; //存储播放器对象
@property (nonatomic, strong) AVPlayerItem *playerItem; //存储音频信息
@property (nonatomic) BOOL orBegin; //记录当前播放杆是否处于起始位置
@end

@implementation PlayMusicViewController
+ (PlayMusicViewController *)shareWithPlayMusicViewController {
    static PlayMusicViewController *playV = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        playV = [[PlayMusicViewController alloc]initWithNibName:@"PlayMusicViewController" bundle:nil];
    });
    return playV;
}
//懒加载常见音频播放器对象
- (AVPlayer *)player {
    if (_player == nil) {
        self.player = [[AVPlayer alloc]init];
    }
    return _player;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //为背景图片添加高斯模糊效果
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc]initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
    effectView.frame = self.backgroundImage.frame;
    [self.backgroundImage addSubview:effectView];
    
    //修改标签的边角
    self.titleLabel.layer.cornerRadius = self.titleLabel.frame.size.width / 2;
    self.titleLabel.layer.masksToBounds = YES;
    JokeModel *joke = self.dataSource[self.index];
    self.titleLabel.text = joke.title;
    
    //修改播放杆的锚点坐标
    self.needle.layer.anchorPoint = CGPointMake(0.28, 0.18);
    self.orBegin = YES;
    //5:监听播放进度
    [self addObserverForprogress];
    //6:监听播放器的状态
    [self addObserverForState];
}

#pragma mark PlayMusic
//播放音乐
- (void)playMusic {
    //1:获取对应的音频数据
    JokeModel *joke = self.dataSource[self.index];
    self.titleLabel.text = joke.title;
    //2:创建AVPlayerItem对象
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:joke.audio_64_url]];
    //3:替换播放器之前的Item
    [self.player replaceCurrentItemWithPlayerItem:playerItem];
    //4:开始播放
    [self.player play];
   
}
//监听播放进度
- (void)addObserverForprogress {
    //获取当前播放器的音频信息
    AVPlayerItem *playItem = self.player.currentItem;
    //开始监听播放器播放进度的变化
    __weak PlayMusicViewController *playV = self;
    [playV.player addPeriodicTimeObserverForInterval:CMTimeMake(1.0, 2.0) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        //获取当前的播放进度
        float currentTime = CMTimeGetSeconds(time);
        //获取音频文件的总时间
        float totalTime = CMTimeGetSeconds(playItem.duration);
        //改变进度条的总大小
        playV.progressSlider.maximumValue = totalTime;
        //改变进度条的进度
        [playV.progressSlider setValue:currentTime animated:YES];
    }];
}
//KVO监听当前播放器的播放状态
- (void)addObserverForState {
    //添加监听者
    [self.player.currentItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    //获取当前的状态
    AVPlayerStatus statu = [change[@"new"]intValue];
    //如果状态是准备播放执行相应的操作
    if (statu == AVPlayerStatusReadyToPlay) {
        [self.playBtn setImage:[UIImage imageNamed:@"playing_btn_pause_n"] forState:UIControlStateNormal];
        //旋转播放杆
        [self handleNeedleRotation:NO];
        [self.timer invalidate];
        //创建计时器旋转标题
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(handleTitleLabelRotation) userInfo:nil repeats:YES];
    }
}
#pragma mark Btn Click
//上一曲
- (IBAction)previousMusic:(id)sender {
    if (self.index > 0) {
        self.index--;
    }else {
        self.index = self.dataSource.count - 1;
    }
    [self stop];
    [self playMusic];
}
//下一曲
- (IBAction)nextMusic:(id)sender {
    if (self.index < self.dataSource.count - 1) {
        self.index++;
    }else {
        self.index = 0;
    }
    [self stop];
    [self playMusic];
}
//播放按钮
- (IBAction)playMusic:(id)sender {
    //1:判断播放器的状态
    if (self.player.rate == 1) {
        [self stop];
    }else {
        [self start];
    }
}
//定义方法将播放界面的控件恢复为未播放状态
- (void)stop {
    [self.player pause];
    [self.playBtn setImage:[UIImage imageNamed:@"playing_btn_play_n"] forState:UIControlStateNormal];       //修改按钮图片
    [self.timer invalidate];         //暂停计时器
    [self handleNeedleRotation:YES]; //恢复播放杆的状态
}
//定义方法将播放界面设置为播放状态
- (void)start {
    [self.player play]; //启动播放器
    [self.playBtn setImage:[UIImage imageNamed:@"playing_btn_pause_n"] forState:UIControlStateNormal];
    [self.timer invalidate];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(handleTitleLabelRotation) userInfo:nil repeats:YES];
    [self handleNeedleRotation:NO];
}
- (IBAction)changeProgress:(UISlider *)sender {
    //改变播放器的进度
    [self.player seekToTime:CMTimeMake(sender.value, 1.0)];
}

#pragma mark Rotation
- (void)handleTitleLabelRotation {
    self.titleLabel.transform = CGAffineTransformRotate(self.titleLabel.transform, M_PI / 60);
}
//定义方法实现播放杆的旋转
- (void)handleNeedleRotation:(BOOL)orPause {
    //播放状态
    __weak PlayMusicViewController *playV = self;
    if (orPause == NO && self.orBegin == YES) {
        [UIView animateWithDuration:0.5 animations:^{
            playV.needle.transform = CGAffineTransformRotate(playV.needle.transform, M_PI / 9);
        }];
        self.orBegin = NO;
    }else if(orPause == YES && self.orBegin == NO) {
    //暂停状态
        [UIView animateWithDuration:0.5 animations:^{
            playV.needle.transform = CGAffineTransformRotate(playV.needle.transform, -M_PI / 9);
        }];
        self.orBegin = YES;
    }
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
