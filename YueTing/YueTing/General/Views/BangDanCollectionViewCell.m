//
//  BangDanCollectionViewCell.m
//  YueTing
//
//  Created by lanouhn on 16/3/14.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import "BangDanCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "BangDan.h"
@implementation BangDanCollectionViewCell

- (void)getBangDan:(BangDan *)bangDan {
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:bangDan.imageUrl] placeholderImage:[UIImage imageNamed:@"jiazai"]];
    self.xiaLabel.text = bangDan.name;
}

@end
