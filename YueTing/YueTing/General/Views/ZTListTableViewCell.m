//
//  ZTListTableViewCell.m
//  YueTing
//
//  Created by lanouhn on 16/3/15.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import "ZTListTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "ZTList.h"
@implementation ZTListTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)getZTList:(ZTList *)ztList {
    [self.imageZTL sd_setImageWithURL:[NSURL URLWithString:ztList.imageUrl] placeholderImage:[UIImage imageNamed:@"jiazai"]];
    self.nameL.text = ztList.name;
    self.zhuboL.text = [NSString stringWithFormat:@"主播：%@", ztList.zhubo];
    self.fenleiL.text = ztList.fenlei;
    self.jishuL.text = [NSString stringWithFormat:@"集数：%ld", ztList.jiShu];
    self.renqil.text = [NSString stringWithFormat:@"人气：%ld", ztList.renqi];
    if (ztList.state == 1) {
        self.imageX.image = [UIImage imageNamed:@"serialize"];
    }else {
        self.imageX.image = [UIImage imageNamed:@"finish"];
    }
}

@end
