//
//  LunBoCollectionReusableView.h
//  YueTing
//
//  Created by lanouhn on 16/3/17.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"
@interface LunBoCollectionReusableView : UICollectionReusableView
@property (nonatomic, strong) SDCycleScrollView *lunboScroll;
- (void)getHeaderImages:(NSMutableArray *)images;
@end
