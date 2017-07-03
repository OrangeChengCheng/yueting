//
//  BDListTableViewController.m
//  YueTing
//
//  Created by lanouhn on 16/3/14.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import "BDListTableViewController.h"
#import "BDListTableViewCell.h"
#import "BDDetailViewController.h"
#import "AFNetworking.h"
#import "BDList.h"
@interface BDListTableViewController ()
@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation BDListTableViewController
- (NSMutableArray *)dataSource {
    if (_dataSource == nil) {
        self.dataSource = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataSource;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    NSArray *arr = @[@"推荐排行榜", @"好评排行榜", @"热搜排行榜", @"下载排行榜"];
    self.navigationItem.title = arr[self.num];
    [self handleNetWork];
}

//数据解析
- (void)handleNetWork {
    NSString *str1 = @"http://117.25.143.77/yyting/bookclient/ClientRankingsItemList.action?rankType=1&rangeType=3&pageNum=1&pageSize=100&token=aIFEKzXA5K5fcVc9WLp_I6FRifS7RJpOQb63ToXOFc8**&imei=ODY0Mzg3MDIwMDMxNTg1";
    NSString *str2 = @"http://117.25.143.77/yyting/bookclient/ClientRankingsItemList.action?rankType=2&rangeType=3&pageNum=1&pageSize=100&token=aIFEKzXA5K5fcVc9WLp_I6FRifS7RJpOQb63ToXOFc8**&imei=ODY0Mzg3MDIwMDMxNTg1";
    NSString *str3 = @"http://117.25.143.77/yyting/bookclient/ClientRankingsItemList.action?rankType=4&rangeType=3&pageNum=1&pageSize=100&token=aIFEKzXA5K5fcVc9WLp_I6FRifS7RJpOQb63ToXOFc8**&imei=ODY0Mzg3MDIwMDMxNTg1";
    NSString *str4 = @"http://117.25.143.77/yyting/bookclient/ClientRankingsItemList.action?rankType=3&rangeType=3&pageNum=1&pageSize=100&token=aIFEKzXA5K5fcVc9WLp_I6FRifS7RJpOQb63ToXOFc8**&imei=ODY0Mzg3MDIwMDMxNTg1";
    NSArray *array = @[str1, str2, str3, str4];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    [manager GET:array[self.num] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableArray *array = responseObject[@"list"];
        for (NSMutableDictionary *dic in array) {
            BDList *bangD = [[BDList alloc]init];
            bangD.imgUrl = dic[@"cover"];
            bangD.nameL = dic[@"name"];
            bangD.zhuboL = dic[@"announcer"];
            bangD.renL = [dic[@"hot"] integerValue];
            bangD.jishuL = [dic[@"sections"] integerValue];
            bangD.zhuangL = [dic[@"state"] integerValue];
            bangD.idBDList = [dic[@"id"] integerValue];
            [self.dataSource addObject:bangD];
        }
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BDListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellB" forIndexPath:indexPath];
    BDList *bdList = self.dataSource[indexPath.row];
    [cell getBDList:bdList];
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"toBDetail"]) {
        BDDetailViewController *bdDetail = [segue destinationViewController];
        NSIndexPath *index = [self.tableView indexPathForCell:sender];
        BDList *bdL = self.dataSource[index.row];
        bdDetail.idB = bdL.idBDList;
        bdDetail.nameB = bdL.nameL;
    }
}


@end
