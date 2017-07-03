//
//  BangDanCollectionViewCell.h
//  YueTing
//
//  Created by lanouhn on 16/3/14.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BangDan;
@interface BangDanCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *xiaLabel;
- (void)getBangDan:(BangDan *)bangDan;
@end
