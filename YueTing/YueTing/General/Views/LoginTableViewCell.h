//
//  LoginTableViewCell.h
//  YueTing
//
//  Created by lanouhn on 16/3/17.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UILabel *loginLabel;
@property (weak, nonatomic) IBOutlet UILabel *moreLabel;

@end
