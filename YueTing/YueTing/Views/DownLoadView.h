//
//  DownLoadView.h
//  YueTing
//
//  Created by lanouhn on 16/3/21.
//  Copyright (c) 2016年 Orange. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DownLoadView;
@class JokeModel;
@protocol DownLoadViewDelegate <NSObject>

- (void)removeDownLoad:(DownLoadView *)downLoadV;

@end

@interface DownLoadView : UIView
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *progressV;
@property (nonatomic, assign) id<DownLoadViewDelegate>delegate;
@property (nonatomic, strong)  NSMutableData *mutableData;
@property (nonatomic, strong) JokeModel *joke;
@property (nonatomic) long long totalLength;

- (void)startDownLoadWithData:(NSMutableData *)mutableData;
- (void)addObserverForApplicationState;

@end
