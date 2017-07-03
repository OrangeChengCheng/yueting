//
//  FLListTableViewController.m
//  YueTing
//
//  Created by lanouhn on 16/3/16.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import "FLListTableViewController.h"
#import "FLListTableViewCell.h"
#import "BDDetailViewController.h"
#import "AFNetworking.h"
#import "FLList.h"
#define FLList(A) [NSString stringWithFormat:@"http://117.25.143.73/yyting/bookclient/ClientTypeResource.action?type=%ld&pageNum=1&pageSize=500&sort=0&token=aIFEKzXA5K5fcVc9WLp_I6FRifS7RJpOQb63ToXOFc8*&imei=ODY0Mzg3MDIwMDMxNTg1", A]
@interface FLListTableViewController ()
@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation FLListTableViewController
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
    self.navigationItem.title = self.nameF;
    [self handleNetWorkWithID:self.idFl];
}
- (void)handleNetWorkWithID:(NSInteger)idFl {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    [manager GET:FLList(idFl) parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableArray *array = responseObject[@"list"];
        for (NSMutableDictionary *dic in array) {
            FLList *flL = [[FLList alloc]init];
            flL.imageFl = dic[@"cover"];
            flL.nameFl = dic[@"name"];
            flL.zhubo = dic[@"announcer"];
            flL.timeFl = dic[@"lastUpdateTime"];
            flL.jiShuFl = [dic[@"sections"] integerValue];
            flL.stateFl = [dic[@"state"] integerValue];
            flL.idFLList = [dic[@"id"] integerValue];
            [self.dataSource addObject:flL];
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
    FLListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellFl" forIndexPath:indexPath];
    FLList *flL = self.dataSource[indexPath.row];
    [cell getFLList:flL];
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
    if ([segue.identifier isEqualToString:@"flToDetail"]) {
        BDDetailViewController *bdDetail = [segue destinationViewController];
        NSIndexPath *index = [self.tableView indexPathForCell:sender];
        FLList *flL = self.dataSource[index.row];
        bdDetail.idB = (NSInteger)flL.idFLList;
        bdDetail.nameB = flL.nameFl;
    }
}


@end
