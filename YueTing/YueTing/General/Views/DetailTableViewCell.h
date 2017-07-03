//
//  DetailTableViewCell.h
//  YueTing
//
//  Created by lanouhn on 16/3/17.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Detail;
@class XiaView;
@interface DetailTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageDetail;
@property (weak, nonatomic) IBOutlet UILabel *nameDetail;
@property (weak, nonatomic) IBOutlet UILabel *zhuboDetail;
@property (weak, nonatomic) IBOutlet UILabel *jishuDetail;
@property (weak, nonatomic) IBOutlet UILabel *renqiDetail;
@property (weak, nonatomic) IBOutlet UILabel *staseDetail;
@property (weak, nonatomic) IBOutlet UILabel *labelD;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UIView *lineV;
@property (weak, nonatomic) IBOutlet XiaView *xiaView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *detailH;  //自适应高度



- (void)getDetail:(Detail *)detail;
@end
