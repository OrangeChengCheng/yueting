//
//  DetailTableViewCell.m
//  YueTing
//
//  Created by lanouhn on 16/3/17.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import "DetailTableViewCell.h"
#import "Detail.h"
#import "UIImageView+WebCache.h"
@implementation DetailTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)getDetail:(Detail *)detail {
    [self.imageDetail sd_setImageWithURL:[NSURL URLWithString:detail.imageDt] placeholderImage:[UIImage imageNamed:@"jiazai"]];
    self.nameDetail.text = detail.nameDt;
    self.zhuboDetail.text = [NSString stringWithFormat:@"主播：%@", detail.zhuboDt];
    self.jishuDetail.text = [NSString stringWithFormat:@"集数：%ld集", detail.jiShuDt];
    self.renqiDetail.text = [NSString stringWithFormat:@"人气：%.2f万", detail.renqiDt / 10000.0];
    if (detail.stateDt == 1) {
        self.staseDetail.text = [NSString stringWithFormat:@"状态：连载中"];
    }else {
        self.staseDetail.text = [NSString stringWithFormat:@"状态：已完结"];
    }
    self.labelD.text = @"内容简介";
    self.timeLabel.text = [NSString stringWithFormat:@"更新时间：%@", detail.timeDt];
    self.detailLabel.text = detail.descDt;
}
@end
