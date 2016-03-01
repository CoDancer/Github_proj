//
//  NewsListViewController.m
//  GraduationProject
//
//  Created by onwer on 16/2/29.
//  Copyright © 2016年 onwer. All rights reserved.
//

#import "NewsListViewController.h"
#import "NewsDetailCell.h"
#import "FirstVCGetData.h"
#import "NewsDetailInfoViewController.h"
#import "CustomRefreshView.h"
#import "MJRefresh.h"

@interface NewsListViewController ()<UICollectionViewDataSource, UICollectionViewDelegate ,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, assign) CGFloat collectionViewY;
@property (nonatomic, assign) float lastY;

@end

@implementation NewsListViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.369 green:0.357 blue:0.604 alpha:1.000];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self configView];
    [self setHeadRefresh];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self dismissBottomView];
}

- (void)setHeadRefresh {
    
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    CustomRefreshView *header = [CustomRefreshView headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    // 隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    
    // 隐藏状态
    header.stateLabel.hidden = YES;
    
    // 马上进入刷新状态
    [header beginRefreshing];
    
    // 设置header
    self.collectionView.header = header;
}

- (void)loadNewData {
    
    NSString *httpUrl = @"http://apis.baidu.com/showapi_open_bus/channel_news/search_news";
    NSString *channel = [NSString stringWithFormat:@"channelId=%@",self.channelId];
    NSString *httpArg = [channel stringByAppendingString:@"&channel"];
    [self request: httpUrl withHttpArg: httpArg];
}

-(void)request:(NSString*)httpUrl withHttpArg:(NSString*)HttpArg  {
    
    NSString *urlStr = [[NSString alloc]initWithFormat: @"%@?%@", httpUrl, HttpArg];
    NSURL *url = [NSURL URLWithString: urlStr];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 10];
    [request setHTTPMethod: @"GET"];
    [request addValue: @"9309d411543b0b78392a309f0dcfa6b9" forHTTPHeaderField: @"apikey"];
    [NSURLConnection sendAsynchronousRequest: request
                                       queue: [NSOperationQueue mainQueue]
                           completionHandler: ^(NSURLResponse *response, NSData *data, NSError *error){
                               if (error) {
                                   NSLog(@"Httperror: %@%ld", error.localizedDescription,(long)error.code);
                               } else {
                                   NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                                   NSArray *listArr = dict[@"showapi_res_body"][@"pagebean"][@"contentlist"];
                                   NSMutableArray *modelArr = [NSMutableArray new];
                                   for (NSDictionary *dic in listArr) {
                                       NewsDetailModel *model = [NewsDetailModel newsDetailModelWithDict:dic];
                                       [modelArr addObject:model];
                                   }
                                   self.dataArray = [modelArr copy];
                                   [self.collectionView reloadData];
                                   [self.collectionView.header endRefreshing];
                               }
                           }];
}

- (NSArray *)dataArray {
    
    if (!_dataArray ) {
        _dataArray = [NSArray new];
    }
    return _dataArray;
}

- (void)configView {
    
    UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(10, 64 + 10, SCREEN_WIDTH - 20, SCREEN_HEIGHT) collectionViewLayout:flowLayout];
    self.collectionView.contentInset = UIEdgeInsetsMake(0, 0, 84, 0);
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor colorWithRed:0.369 green:0.357 blue:0.604 alpha:1.000];
    [self.collectionView registerClass:[NewsDetailCell class] forCellWithReuseIdentifier:@"newsDetailCell"];
    
    [self.view addSubview:self.collectionView];
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)prepareVisibleCellsForAnimationWithRow:(NSInteger )row andCell:(NewsDetailCell *)cell {
    
    cell.frame = CGRectMake(-CGRectGetWidth(cell.bounds), cell.frame.origin.y, CGRectGetWidth(cell.bounds), CGRectGetHeight(cell.bounds));
    cell.alpha = 0.f;
}

- (void)animateVisibleCell:(NewsDetailCell *)cell withRow:(NSInteger)row {
    
    cell.alpha = 1.f;
    [UIView animateWithDuration:0.4 delay:0.2 *row usingSpringWithDamping:1.0 initialSpringVelocity:1.0 options:0 animations:^{
        cell.frame = CGRectMake(0.f, cell.frame.origin.y, CGRectGetWidth(cell.bounds), CGRectGetHeight(cell.bounds));
    } completion:^(BOOL finished) {
        
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NewsDetailCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"newsDetailCell" forIndexPath:indexPath];
    NewsDetailModel *model = self.dataArray[indexPath.row];
    cell.detailModel = model;
    
    if (collectionView.contentSize.height - SCREEN_HEIGHT > collectionView.contentOffset.y &&
        collectionView.contentOffset.y >= self.lastY) {
        if (collectionView.contentOffset.y == 0) {
            [self prepareVisibleCellsForAnimationWithRow:indexPath.row andCell:cell];
            [self animateVisibleCell:cell withRow:indexPath.row];
        }else {
            self.lastY = collectionView.contentOffset.y + 150;
            [self prepareVisibleCellsForAnimationWithRow:1 andCell:cell];
            [self animateVisibleCell:cell withRow:1];
        }
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NewsDetailInfoViewController *vc = [NewsDetailInfoViewController new];
    NewsDetailModel *model = self.dataArray[indexPath.row];
    vc.detailModel = model;
    vc.title = model.sourceStr;
    vc.imageArray = self.slideArr;
    [vc dismissBottomView];
    vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    NewsDetailModel *model = self.dataArray[indexPath.row];
    return CGSizeMake(SCREEN_WIDTH - 20, 170 + model.textHeight);
}



@end
