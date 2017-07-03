//
//  ListTableViewCell.h
//  YueTing
//
//  Created by lanouhn on 16/3/17.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameList;
@property (weak, nonatomic) IBOutlet UILabel *countList;
@property (weak, nonatomic) IBOutlet UIButton *downLoad;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIView *lineView;

@end
