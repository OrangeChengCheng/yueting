//
//  BDListTableViewCell.m
//  YueTing
//
//  Created by lanouhn on 16/3/15.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import "BDListTableViewCell.h"
#import "BDList.h"
#import "UIImageView+WebCache.h"
@implementation BDListTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)getBDList:(BDList *)bdList {
    [self.listImage sd_setImageWithURL:[NSURL URLWithString:bdList.imgUrl] placeholderImage:[UIImage imageNamed:@"jiazai"]];
    self.nameL.text = bdList.nameL;
    self.zhuboL.text = [NSString stringWithFormat:@"主播：%@", bdList.zhuboL];
    self.renL.text = [NSString stringWithFormat:@"播放：%ld万", bdList.renL / 10000];
    self.jishuL.text = [NSString stringWithFormat:@"集数：%ld", bdList.jishuL];
    if (bdList.zhuangL == 1) {
        self.zhuangL.text = @"状态：连载中";
    }else {
        self.zhuangL.text = @"状态：已完结";
    }
}
//- (void)layoutSubviews {
//    UIImage *img = self.imageView.image;
//    self.imageView.image = [UIImage imageNamed:@"jiazai"];
//    [super layoutSubviews];
//    self.imageView.image = img;
//}

@end
