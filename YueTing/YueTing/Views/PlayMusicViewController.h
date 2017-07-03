//
//  PlayMusicViewController.h
//  FMLesson
//
//  Created by lanouhn on 16/2/24.
//  Copyright (c) 2016年 Orange. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayMusicViewController : UIViewController

//属性传值
@property(nonatomic, strong) NSMutableArray *dataSource; //存储所有的音频数据
@property(nonatomic) NSInteger index; //存储当前播放的音频数据的下标

//声明一个方法创建音乐播放器界面对象
+ (PlayMusicViewController *)shareWithPlayMusicViewController;

//定义一个方法完成音频数据的播放
- (void)playMusic;
@end
