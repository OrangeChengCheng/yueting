//
//  FLListTableViewCell.h
//  YueTing
//
//  Created by lanouhn on 16/3/16.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FLList;
@interface FLListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageS;
@property (weak, nonatomic) IBOutlet UIImageView *imageFl;
@property (weak, nonatomic) IBOutlet UILabel *nameFl;
@property (weak, nonatomic) IBOutlet UILabel *zhuboFl;
@property (weak, nonatomic) IBOutlet UILabel *jishuFl;
@property (weak, nonatomic) IBOutlet UILabel *timeFl;
- (void)getFLList:(FLList *)flList;
@end
