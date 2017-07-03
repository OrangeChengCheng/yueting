//
//  ZhuanTiTableViewCell.h
//  YueTing
//
//  Created by lanouhn on 16/3/15.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZhuanTi;
@interface ZhuanTiTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageZ;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *detailL;
- (void)getZhuanTi:(ZhuanTi *)zhuan;
@end
