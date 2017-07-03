//
//  FenLeiCollectionViewController.m
//  YueTing
//
//  Created by lanouhn on 16/3/16.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import "FenLeiCollectionViewController.h"
#import "FenLeiCollectionViewCell.h"
#import "FLListTableViewController.h"
#import "FenLei.h"
#import "AFNetworking.h"
#define FenLei(A) [NSString stringWithFormat:@"http://117.25.143.73/yyting/bookclient/ClientTypeResource.action?type=%ld&pageNum=1&pageSize=500&token=aIFEKzXA5K5fcVc9WLp_I6FRifS7RJpOQb63ToXOFc8*&imei=ODY0Mzg3MDIwMDMxNTg1", A]
@interface FenLeiCollectionViewController ()
@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation FenLeiCollectionViewController
- (NSMutableArray *)dataSource {
    if (_dataSource == nil) {
        self.dataSource = [NSMutableArray array];
    }
    return _dataSource;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    self.navigationItem.title = self.titleFL;
    NSArray *arr = @[@"1", @"80", @"3", @"78", @"3085", @"104", @"54"];
    [self handleNetWorkWithID:[arr[self.idFL] integerValue]];
}
- (void)handleNetWorkWithID:(NSInteger)idF {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    [manager GET:FenLei(idF) parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableArray *array = responseObject[@"list"];
        for (NSMutableDictionary *dic in array) {
            FenLei *fenL = [[FenLei alloc]init];
            fenL.nameF = dic[@"name"];
            fenL.idFL = [dic[@"id"] integerValue];
            [self.dataSource addObject:fenL];
        }
        [self.collectionView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    FLListTableViewController *fenlV = [segue destinationViewController];
    NSIndexPath *index = [self.collectionView indexPathForCell:sender];
    FenLei *fen = self.dataSource[index.row];
    fenlV.idFl = fen.idFL;
    fenlV.nameF = fen.nameF;
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *arr1 = @[@"dscs", @"qcyq", @"kbxy", @"cygy", @"xhcq", @"lsjs", @"wxxx", @"xztl", @"gcsz", @"wykh"];
    NSArray *arr2 = @[@"gkk", @"rszl", @"lscq", @"dqsj", @"rwft", @"zjwh", @"rwzj"];
    NSArray *arr3 = @[@"stf", @"jdxp", @"sxgs", @"psjx", @"zbs", @"gdg", @"cps", @"zlr", @"pcj", @"llr", @"nq", @"jk", @"hcx", @"gyp", @"mj", @"ysh", @"tjz", @"slj", @"ssj", @"cjy", @"cbh", @"hbl", @"lbr", @"ljd", @"gdl", @"ykc", @"sdd", @"sy", @"hyw"];
    NSArray *arr4 = @[@"gxjd", @"scgf", @"wgwx", @"mjmz", @"swsb", @"tswx"];
    NSArray *arr5 = @[@"tzlc", @"gsfy", @"syzh", @"glyx", @"cjdt"];
    NSArray *arr6 = @[@"hwls", @"dfsw", @"wlqw", @"ssqh", @"yzjr"];
    NSArray *arr7 = @[@"yltt", @"tkx", @"ymxh", @"zyjm", @"ystq"];
    NSArray *array = @[arr1, arr2, arr3, arr4, arr5, arr6, arr7];
    FenLeiCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellFL" forIndexPath:indexPath];
    cell.imageFL.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg", (array[self.idFL])[indexPath.row]]];
    FenLei *fen = self.dataSource[indexPath.row];
    cell.labelFL.text = fen.nameF;
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
