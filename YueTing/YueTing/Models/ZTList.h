//
//  ZTList.h
//  YueTing
//
//  Created by lanouhn on 16/3/15.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZTList : NSObject
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *zhubo;
@property (nonatomic, strong) NSString *fenlei;
@property (nonatomic) NSInteger jiShu;
@property (nonatomic) NSInteger renqi;
@property (nonatomic) NSInteger state;
@property (nonatomic) NSInteger idZTList;

@end
