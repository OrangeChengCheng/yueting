//
//  ZhuanTiTableViewController.m
//  YueTing
//
//  Created by lanouhn on 16/3/15.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import "ZhuanTiTableViewController.h"
#import "ZhuanTiTableViewCell.h"
#import "AFNetworking.h"
#import "ZhuanTi.h"
#import "ZTListTableViewController.h"
@interface ZhuanTiTableViewController ()
@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation ZhuanTiTableViewController
- (NSMutableArray *)dataSource {
    if (_dataSource == nil) {
        self.dataSource = [NSMutableArray array];
    }
    return _dataSource;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self handleNetWork];
}
//数据解析
- (void)handleNetWork {
    NSString *urlStr = @"http://117.25.143.77/yyting/bookclient/ClientGetTopicList.action?type=1&IsTop=-1&token=aIFEKzXA5K5fcVc9WLp_I6FRifS7RJpOQb63ToXOFc8*&imei=ODY0Mzg3MDIwMDMxNTg1";
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableArray *array = responseObject[@"list"];
        for (NSMutableDictionary *dic in array) {
            ZhuanTi *zhuanT = [[ZhuanTi alloc]init];
            zhuanT.imageUrl = dic[@"cover"];
            zhuanT.name = dic[@"name"];
            zhuanT.detail = dic[@"desc"];
            zhuanT.idZ = [dic[@"id"] integerValue];
            [self.dataSource addObject:zhuanT];
        }
        NSRange range = {0, 71};
        [self.dataSource removeObjectsInRange:range];
        [self.dataSource removeObjectAtIndex:1];
        [self.dataSource removeObjectAtIndex:7];
        [self.dataSource removeObjectAtIndex:11];
        [self.dataSource removeObjectAtIndex:11];
        [self.dataSource removeObjectAtIndex:12];
        [self.dataSource removeObjectAtIndex:12];
        [self.dataSource removeObjectAtIndex:13];
        [self.dataSource removeObjectAtIndex:14];
        [self.dataSource removeObjectAtIndex:27];
        [self.dataSource removeObjectAtIndex:27];
        [self.dataSource removeObjectAtIndex:31];
        NSRange rang = {33, 9};
        [self.dataSource removeObjectsInRange:rang];
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZhuanTiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellZ" forIndexPath:indexPath];
    if (self.dataSource.count != 0) {
        ZhuanTi *zhuan = self.dataSource[indexPath.section];
        [cell getZhuanTi:zhuan];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 3;
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
    if ([segue.identifier isEqualToString:@"zhuanToList"]) {
        ZTListTableViewController *ztLVC = [segue destinationViewController];
        NSIndexPath *index = [self.tableView indexPathForCell:sender];
        ZhuanTi *zhuan = self.dataSource[index.section];
        ztLVC.idStr = zhuan.idZ;
        ztLVC.nameZT = zhuan.name;
    }
}


@end
