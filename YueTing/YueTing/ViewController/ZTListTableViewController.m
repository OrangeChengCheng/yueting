//
//  ZTListTableViewController.m
//  YueTing
//
//  Created by lanouhn on 16/3/15.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import "ZTListTableViewController.h"
#import "BDDetailViewController.h"
#import "AFNetworking.h"
#import "ZTList.h"
#import "ZTListTableViewCell.h"
#define ZTList(A) [NSString stringWithFormat:@"http://api.mting.info/yyting/bookclient/ClientGetBookByTopic.action?topicId=%ld&pageNum=1&pageSize=500&sort=0&token=aIFEKzXA5K5fcVc9WLp_I6FRifS7RJpOQb63ToXOFc8*&imei=ODY0Mzg3MDIwMDMxNTg1", A]
#define ZTList2(B) [NSString stringWithFormat:@"http://117.25.143.73/yyting/bookclient/ClientGetBookDetail.action?id=%ld&token=aIFEKzXA5K5fcVc9WLp_I6FRifS7RJpOQb63ToXOFc8*&imei=ODY0Mzg3MDIwMDMxNTg1", B]
@interface ZTListTableViewController ()
@property (nonatomic, strong) NSMutableArray *arrayID;
@property (nonatomic, strong) NSMutableArray *dataSourceZ;
@end

@implementation ZTListTableViewController
- (NSMutableArray *)dataSourceZ {
    if (_dataSourceZ == nil) {
        self.dataSourceZ = [NSMutableArray array];
    }
    return _dataSourceZ;
}
- (NSMutableArray *)arrayID {
    if (_arrayID == nil) {
        self.arrayID = [NSMutableArray array];
    }
    return _arrayID;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.navigationItem.title = self.nameZT;
    [self handleNetWorkWithID:self.idStr];
}
- (void)handleNetWorkWithID:(NSInteger)idS {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    [manager GET:ZTList(idS) parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableArray *array = responseObject[@"list"];
        for (NSMutableDictionary *dic in array) {
            [self.arrayID addObject:dic[@"id"]];
        }
        for (NSString *idSL in self.arrayID) {
            ZTList *zt = [self handleNetWorkWithIDL:[idSL integerValue]];
            [self.dataSourceZ addObject:zt];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
}
- (ZTList *)handleNetWorkWithIDL:(NSInteger)idL {
    ZTList *ztL = [[ZTList alloc]init];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    [manager GET:ZTList2(idL) parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        ztL.imageUrl = responseObject[@"cover"];
        ztL.name = responseObject[@"name"];
        ztL.zhubo = responseObject[@"announcer"];
        ztL.fenlei = responseObject[@"type"];
        ztL.jiShu = [responseObject[@"sections"] integerValue];
        ztL.renqi = [responseObject[@"play"] integerValue];
        ztL.state = [responseObject[@"state"] integerValue];
        ztL.idZTList = [responseObject[@"id"] integerValue];
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
    return ztL;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSourceZ.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZTListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellLL" forIndexPath:indexPath];
    if (self.dataSourceZ.count != 0) {
        ZTList *ztL = self.dataSourceZ[indexPath.section];
        [cell getZTList:ztL];
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
    if ([segue.identifier isEqualToString:@"ztToDetail"]) {
        BDDetailViewController *bdDetail = [segue destinationViewController];
        NSIndexPath *index = [self.tableView indexPathForCell:sender];
        ZTList *ztL = self.dataSourceZ[index.section];
        bdDetail.idB = ztL.idZTList;
        bdDetail.nameB = ztL.name;
    }

}


@end
