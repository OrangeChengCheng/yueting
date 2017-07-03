//
//  BDListTableViewCell.h
//  YueTing
//
//  Created by lanouhn on 16/3/15.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BDList;
@interface BDListTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *listImage;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *zhuboL;
@property (weak, nonatomic) IBOutlet UILabel *renL;
@property (weak, nonatomic) IBOutlet UILabel *jishuL;
@property (weak, nonatomic) IBOutlet UILabel *zhuangL;


- (void)getBDList:(BDList *)bdList;
@end
