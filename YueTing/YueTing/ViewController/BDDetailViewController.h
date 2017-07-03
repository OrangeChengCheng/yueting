//
//  BDDetailViewController.h
//  YueTing
//
//  Created by lanouhn on 16/3/15.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BDDetailViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic) NSInteger idB;
@property (nonatomic, strong) NSString *nameB;
@end
