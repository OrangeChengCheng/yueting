//
//  ZhuanTiTableViewCell.m
//  YueTing
//
//  Created by lanouhn on 16/3/15.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import "ZhuanTiTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "ZhuanTi.h"
@implementation ZhuanTiTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)getZhuanTi:(ZhuanTi *)zhuan {
    [self.imageZ sd_setImageWithURL:[NSURL URLWithString:zhuan.imageUrl] placeholderImage:[UIImage imageNamed:@"jiazai"]];
    self.nameL.text = zhuan.name;
    self.detailL.text = zhuan.detail;
}

@end
