//
//  CollectTableViewController.m
//  YueTing
//
//  Created by lanouhn on 16/3/18.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import "CollectTableViewController.h"
#import "AppDelegate.h"
#import "CollectTableViewCell.h"
#import "Login.h"
#import "BDDetailViewController.h"
@interface CollectTableViewController ()
@property (nonatomic, strong)  NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation CollectTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"收藏夹";
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
     self.navigationItem.rightBarButtonItem = self.editButtonItem;
    AppDelegate *delega = [UIApplication sharedApplication].delegate;
    self.managedObjectContext = delega.managedObjectContext;
//    NSLog(@"%@", NSHomeDirectory());
    self.dataSource = [NSMutableArray array];
    
    //查询
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Collect"];
    NSArray *array = [self.managedObjectContext executeFetchRequest:request error:nil];
    [self.dataSource addObjectsFromArray:array];
    [self.tableView reloadData];
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
    CollectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellC" forIndexPath:indexPath];
    Login *log = self.dataSource[indexPath.row];
    [cell getLogin:log];
    return cell;
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Login *log = self.dataSource[indexPath.row];
        [self.managedObjectContext deleteObject:log];
        [self.managedObjectContext save:nil];
        [self.dataSource removeObject:log];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

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
    if ([segue.identifier isEqualToString:@"collectTo"]) {
        BDDetailViewController *detailV = [segue destinationViewController];
        NSIndexPath *index = [self.tableView indexPathForCell:sender];
         Login *log = self.dataSource[index.row];
        detailV.idB = [log.idC integerValue];
        detailV.nameB = log.name;
    }
}


@end
