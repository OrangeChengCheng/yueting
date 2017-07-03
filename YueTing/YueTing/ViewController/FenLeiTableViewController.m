//
//  FenLeiTableViewController.m
//  YueTing
//
//  Created by lanouhn on 16/3/14.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import "FenLeiTableViewController.h"
#import "FenLeiTableViewCell.h"
#import "FenLeiCollectionViewController.h"
@interface FenLeiTableViewController ()

@end

@implementation FenLeiTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView setSeparatorColor:[UIColor blueColor]];  //设置分割线为蓝色
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 7;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FenLeiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellF" forIndexPath:indexPath];
    NSArray *arrayF = @[@"ys", @"rw", @"xs", @"mz", @"sy", @"xl", @"zy"];
    NSArray *arrayL = @[@"有声小说", @"人文生活", @"相声评书", @"文学名著", @"商业时事", @"心灵鸡汤", @"综艺娱乐"];
    cell.imageF.image = [UIImage imageNamed:arrayF[indexPath.section]];
    cell.labelF.text = arrayL[indexPath.section];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0 || section == 2 || section == 5) {
        return 15;
    }
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 6) {
        return 15;
    }
    return 0;
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
    FenLeiCollectionViewController *fenleiC = [segue destinationViewController];
    NSIndexPath *index = [self.tableView indexPathForCell:sender];
    fenleiC.idFL = index.section;
    NSArray *arrayL = @[@"有声小说", @"人文生活", @"相声评书", @"文学名著", @"商业时事", @"心灵鸡汤", @"综艺娱乐"];
    fenleiC.titleFL = arrayL[index.section];
}


@end
