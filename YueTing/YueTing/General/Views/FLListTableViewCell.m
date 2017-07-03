//
//  FLListTableViewCell.m
//  YueTing
//
//  Created by lanouhn on 16/3/16.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import "FLListTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "FLList.h"
@implementation FLListTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)getFLList:(FLList *)flList {
    [self.imageFl sd_setImageWithURL:[NSURL URLWithString:flList.imageFl] placeholderImage:[UIImage imageNamed:@"jiazai"]];
    self.nameFl.text = flList.nameFl;
    self.zhuboFl.text = [NSString stringWithFormat:@"主播：%@", flList.zhubo];
    self.jishuFl.text = [NSString stringWithFormat:@"集数：%ld", flList.jiShuFl];
    self.timeFl.text = [NSString stringWithFormat:@"更新时间：%@", flList.timeFl];
    if (flList.stateFl == 1) {
        self.imageS.image = [UIImage imageNamed:@"serialize"];
    }else {
        self.imageS.image = [UIImage imageNamed:@"finish"];
    }

}
@end
