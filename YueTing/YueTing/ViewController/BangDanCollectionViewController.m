//
//  BangDanCollectionViewController.m
//  YueTing
//
//  Created by lanouhn on 16/3/14.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import "BangDanCollectionViewController.h"
#import "BDListTableViewController.h"
#import "BangDanCollectionViewCell.h"
#import "BangDanCollectionReusableView.h"
#import "BDDetailViewController.h"
#import "LunBoCollectionReusableView.h"
#import "ZTListTableViewController.h"
#import "SDCycleScrollView.h"
#import "AFNetworking.h"
#import "BangDan.h"
@interface BangDanCollectionViewController ()<SDCycleScrollViewDelegate>
@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation BangDanCollectionViewController

//static NSString * const reuseIdentifier = @"Cell";
- (NSMutableArray *)dataSource {
    if (_dataSource == nil) {
        self.dataSource = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataSource;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self handleNetWork];
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[LunBoCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"lunbo"];
}

//数据解析
- (void)handleNetWork {
    NSString *urlStr = @"http://117.25.143.77/yyting/bookclient/ClientRankingsItemList.action?rankType=2&rangeType=3&pageNum=1&pageSize=100&token=aIFEKzXA5K5fcVc9WLp_I6FRifS7RJpOQb63ToXOFc8**&imei=ODY0Mzg3MDIwMDMxNTg1";
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableArray *array = responseObject[@"list"];
        for (NSMutableDictionary *dic in array) {
            BangDan *bangD = [[BangDan alloc]init];
            bangD.imageUrl = dic[@"cover"];
            bangD.name = dic[@"name"];
            bangD.idBD = [dic[@"id"] integerValue];
            if (bangD.name.length < 7) {
                [self.dataSource addObject:bangD];
            }
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
    if ([segue.identifier isEqualToString:@"toBDList"]) {
    BDListTableViewController *BDListVC = [segue destinationViewController];
    UIButton *btn = (UIButton *)sender;
    BDListVC.num = btn.tag;
    }
    if ([segue.identifier isEqualToString:@"bdToDetail"]) {
        BDDetailViewController *bdDetail = [segue destinationViewController];
        NSIndexPath *index = [self.collectionView indexPathForCell:sender];
        BangDan *bDan = self.dataSource[index.row + 8 * index.section - 8];
        bdDetail.idB = bDan.idBD;
        bdDetail.nameB = bDan.name;
    }
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 5;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }else {
        return 8;
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return CGSizeMake([UIScreen mainScreen].bounds.size.width, 180);
    }else {
        return CGSizeMake([UIScreen mainScreen].bounds.size.width, 37);
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BangDanCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    if (self.dataSource.count != 0) {
        BangDan *bangD = self.dataSource[indexPath.row + 8 * indexPath.section - 8];
        [cell getBangDan:bangD];
    }
    return cell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (kind == UICollectionElementKindSectionHeader) {
        if (indexPath.section == 0) {
            LunBoCollectionReusableView *lunbo = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"lunbo" forIndexPath:indexPath];
            lunbo.lunboScroll.delegate = self;
            NSArray *array = @[@"http://bookpic.lrts.me/7970648195234274b76c3a3b2076935b.jpg", @"http://bookpic.lrts.me/59dbcc7f817049b58084d993a46879aa.jpg", @"http://bookpic.lrts.me/522787cc0f534e7a8c6b84571b42ff6d.jpg", @"http://bookpic.lrts.me/c0c5742cfefe439abe3d8bdfdf1f70d8.jpg", @"http://bookpic.lrts.me/6aa55e847f484b66afa1caead664cea6.jpg"];
            [lunbo getHeaderImages:(NSMutableArray *)array];
            return lunbo;
        }else {
            BangDanCollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
            NSArray *arr = [NSArray array];
            arr = @[@"推荐排行榜", @"好评排行榜", @"热搜排行榜", @"下载排行榜"];
            header.headerLabel.text = arr[indexPath.section - 1];
            header.headerButton.tag = indexPath.section - 1;
            return header;
        }
    }
    return nil;
}
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    ZTListTableViewController *ztListV = [self.storyboard instantiateViewControllerWithIdentifier:@"ZTListTableViewController"];
    NSArray *arr = @[@"18", @"17", @"13", @"15", @"16"];
    NSInteger temp = [arr[index] integerValue];
    ztListV.idStr = temp;
    [self.navigationController pushViewController:ztListV animated:YES];
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
