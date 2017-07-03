//
//  LunBoCollectionReusableView.m
//  YueTing
//
//  Created by lanouhn on 16/3/17.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import "LunBoCollectionReusableView.h"

@implementation LunBoCollectionReusableView
- (SDCycleScrollView *)lunboScroll {
    if (_lunboScroll == nil) {
        self.lunboScroll = [[SDCycleScrollView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 180)];
        _lunboScroll.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    }
    return _lunboScroll;
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.lunboScroll];
    }
    return self;
}
- (void)getHeaderImages:(NSMutableArray *)images {
    self.lunboScroll.imageURLStringsGroup = images;
}
@end
