//
//  JokeModel.h
//  FMLesson
//
//  Created by lanouhn on 16/2/24.
//  Copyright (c) 2016年 Orange. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JokeModel : NSObject

@property (nonatomic, copy) NSString *title;          //文件名
@property (nonatomic, copy) NSString *audio_64_url;   //播放链接
@property (nonatomic, copy) NSString *duration;             //文件时长
@property (nonatomic) NSInteger totalLength;         //存储文件的总大小
@property (nonatomic, copy) NSString *play_num;
@end
