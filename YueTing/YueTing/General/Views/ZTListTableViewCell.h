//
//  ZTListTableViewCell.h
//  YueTing
//
//  Created by lanouhn on 16/3/15.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZTList;
@interface ZTListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageZTL;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *zhuboL;
@property (weak, nonatomic) IBOutlet UILabel *fenleiL;
@property (weak, nonatomic) IBOutlet UILabel *jishuL;
@property (weak, nonatomic) IBOutlet UILabel *renqil;
@property (weak, nonatomic) IBOutlet UIImageView *imageX;

- (void)getZTList:(ZTList *)ztList;
@end
