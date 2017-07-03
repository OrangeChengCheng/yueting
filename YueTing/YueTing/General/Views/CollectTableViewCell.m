//
//  CollectTableViewCell.m
//  YueTing
//
//  Created by lanouhn on 16/3/18.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import "CollectTableViewCell.h"
#import "Login.h"
#import "UIImageView+WebCache.h"
@implementation CollectTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)getLogin:(Login *)login {
    [self.imageC sd_setImageWithURL:[NSURL URLWithString:login.image] placeholderImage:[UIImage imageNamed:@"jiazai"]];
    self.labelN.text = login.name;
    self.labelZ.text = [NSString stringWithFormat:@"主播：%@", login.zhubo];
    self.labelJ.text = [NSString stringWithFormat:@"集数：%@", login.jishu];
    self.labelR.text = [NSString stringWithFormat:@"人气：%@", login.renqi];
    if ([login.state integerValue] == 1) {
        self.imageS.image = [UIImage imageNamed:@"serialize"];
    }else {
        self.imageS.image = [UIImage imageNamed:@"finish"];
    }
}
@end
