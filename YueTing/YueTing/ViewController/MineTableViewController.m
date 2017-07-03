//
//  MineTableViewController.m
//  YueTing
//
//  Created by lanouhn on 16/3/17.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import "CollectTableViewController.h"
#import "MineTableViewController.h"
#import "AboutViewController.h"
#import "LoginTableViewCell.h"
#import "LoginDTableViewCell.h"
#import "DownLoadViewController.h"
@interface MineTableViewController ()

@end

@implementation MineTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        LoginTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellM" forIndexPath:indexPath];
        return cell;
    }
    LoginDTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellD" forIndexPath:indexPath];
    NSArray *array = @[@"我的收藏", @"我的下载", @"关于我们"];
    NSArray *arr = @[@"collection", @"download", @"about"];
    cell.descroLabel.text = array[indexPath.section - 1];
    cell.fenleImage.image = [UIImage imageNamed:arr[indexPath.section - 1]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        CollectTableViewController *collectV = [self.storyboard instantiateViewControllerWithIdentifier:@"CollectTableViewController"];
        [self.navigationController pushViewController:collectV animated:YES];
    }
    if (indexPath.section == 2) {
        DownLoadViewController *downLoadV = [DownLoadViewController shareWithDownLoadViewController];
        [self.navigationController pushViewController:downLoadV animated:YES];
    }
    if (indexPath.section == 3) {
        AboutViewController *aboutV = [self.storyboard instantiateViewControllerWithIdentifier:@"AboutViewController"];
        [self.navigationController pushViewController:aboutV animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 118;
    }
    return 71;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section < 2) {
        return 30;
    }
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 3) {
        return 30;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
