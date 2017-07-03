//
//  CollectTableViewCell.h
//  YueTing
//
//  Created by lanouhn on 16/3/18.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Login;
@interface CollectTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageS;
@property (weak, nonatomic) IBOutlet UIImageView *imageC;
@property (weak, nonatomic) IBOutlet UILabel *labelN;
@property (weak, nonatomic) IBOutlet UILabel *labelZ;
@property (weak, nonatomic) IBOutlet UILabel *labelJ;
@property (weak, nonatomic) IBOutlet UILabel *labelR;
- (void)getLogin:(Login *)login;
@end
