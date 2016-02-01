//
//  GPThirdController.m
//  GraduationProject
//
//  Created by onwer on 15/11/26.
//  Copyright © 2015年 onwer. All rights reserved.
//

#import "GPThirdController.h"
#import "GPPrepareLogin.h"
#import "ZBWaterView.h"
#import "YALTabBarInteracting.h"
#import "GPUserCenterViewController.h"
#import "SecondVCGetData.h"
#import "ThirdWaterViewModel.h"
#import "UIImageView+WebCache.h"
#import "BYImproveFlowView.h"
#import "CustomRefreshView.h"
#import "MJRefresh.h"
#import "ThirdDetailViewController.h"

@interface GPThirdController()<YALTabBarInteracting,ZBWaterViewDatasource, ZBWaterViewDelegate>

@property (nonatomic, strong) ZBWaterView *waterView;
@property (nonatomic, strong) MBProgressHUD *HUD;

@property (nonatomic ,assign) BOOL          hasMore;
@property (nonatomic ,assign) NSInteger     offset;
@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic ,assign) NSInteger tapIndex;
@property (nonatomic, weak) id<YALTabBarInteracting> delegate;
@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic, strong) NSArray *modelArr;
@property (nonatomic, strong) NSDictionary *cellHeightDic;
@property (nonatomic, strong) NSDictionary *cellImageDic;

@end

@implementation GPThirdController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"馔玉";
    [self setHeadRefresh];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self getLocalData];
    [self configView];
    self.delegate = self;
}

#pragma mark -- refreshAndRequestData

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
    self.waterView.header = header;
}

//下拉加载数据
- (void)loadNewData {
    
    self.waterView.userInteractionEnabled = NO;
    //模拟1秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 拿到当前的下拉刷新控件，结束刷新状态
        [self getLocalData];
        [self.waterView.header endRefreshing];
        self.waterView.userInteractionEnabled = YES;
    });
}

- (void)viewWillAppear:(BOOL)animated {
    
    [self showBottomView];
    [super viewWillAppear:animated];
}

- (NSArray *)dataArr {
    
    if (!_dataArr) {
        _dataArr = [NSArray array];
    }
    return _dataArr;
}

- (NSArray *)modelArr {
    
    if (!_modelArr) {
        _modelArr = [NSArray array];
    }
    return _modelArr;
}

- (NSDictionary *)cellHeightDic {
    
    if (!_cellHeightDic) {
        _cellHeightDic = [NSDictionary new];
    }
    return _cellHeightDic;
}

- (NSDictionary *)cellImageDic {
    
    if (!_cellImageDic) {
        _cellImageDic = [NSDictionary new];
    }
    return _cellImageDic;
}

- (void)extraRightItemDidPressed {
    
    GPUserCenterViewController *vc = [GPUserCenterViewController new];
    [vc dismissBottomView];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)rightBarItemDidTap {
    
    [GPPrepareLogin showLoginViewController];
}

- (void)configView {
    
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [leftBtn setImage:[UIImage imageNamed:@"food"] forState:UIControlStateNormal];
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftBarItem;
}

- (ZBWaterView *)waterView {
    
    if (!_waterView) {
        _waterView = [[ZBWaterView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
        _waterView.backgroundColor = [UIColor clearColor];
        _waterView.contentInset = UIEdgeInsetsMake(0, 0, 64, 0);
        
        _waterView.waterDelegate = self;
        _waterView.waterDataSource = self;
    }
    return _waterView;
}

- (void)getLocalData {
    
    self.dataArr = [SecondVCGetData getTasteFoodContent];
    NSMutableDictionary *cellHeightDic = [NSMutableDictionary dictionary];
    NSMutableDictionary *cellImageDic = [NSMutableDictionary dictionary];
    NSMutableArray *modelArr = [NSMutableArray array];
    if (self.cellHeightDic.count == 0) {
        MBProgressHUD *hud = [UIHelper showHUDAddedTo:self.view animated:YES];
        hud.yOffset = 0;
    }
    [self.dataArr enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary *cellInfoDic = [obj objectOrNilForKey:@"cellInfo"];
        ThirdWaterViewModel *model = [ThirdWaterViewModel foodListModelWithDict:cellInfoDic];
        [modelArr addObject:model];
        [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:model.imageURL] options:SDWebImageDownloaderLowPriority|SDWebImageDownloaderContinueInBackground progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
            if (image) {
                CGSize size = [self appropriateSizeWithImageSize:image.size];
                CGFloat cellHeight = size.height;
                [cellHeightDic setObject:@(cellHeight) forKey:@(idx)];
                [cellImageDic setObject:image forKey:@(idx)];
                if ([cellHeightDic count] == self.dataArr.count) {
                    self.cellHeightDic = [cellHeightDic copy];
                    self.cellImageDic = [cellImageDic copy];
                    [self.waterView removeFromSuperview];
                    [self.view addSubview:self.waterView];
//                    [self.waterView scrollToIndex:_tapIndex animated:YES];
                    [UIHelper hideAllMBProgressHUDsForView:self.view animated:YES];
                    [self.waterView reloadData];
                }
            }
            
        }];
    }];
    self.modelArr = [modelArr copy];
}

- (CGSize)appropriateSizeWithImageSize:(CGSize)size {
    
    CGFloat cellWidth = (SCREEN_WIDTH - 30)/2.0;
    CGFloat cellHeight = cellWidth/size.width * size.height;
    return CGSizeMake(cellWidth, cellHeight);
}

- (void)startReq:(NSInteger)offset {
    
    
}

- (NSInteger)numberOfFlowViewInWaterView:(ZBWaterView *)waterView {

    return self.dataArr.count;
}

//瀑布流信息
- (CustomWaterInfo *)infoOfWaterView:(ZBWaterView*)waterView {
    
    CustomWaterInfo *waterInfo = [CustomWaterInfo new];
    waterInfo.topMargin = 20;
    waterInfo.bottomMargin = 10;
    waterInfo.leftMargin = 10;
    waterInfo.rightMargin = 10;
    waterInfo.horizonPadding = 10;
    waterInfo.veticalPadding = 10;
    waterInfo.numOfColumn = 2;
    return waterInfo;
}

//每个流
- (ZBFlowView *)waterView:(ZBWaterView *)waterView flowViewAtIndex:(NSInteger)index {
    
    BYImproveFlowView *flowView = [waterView dequeueReusableCellWithIdentifier:@"cell"];
    NSDictionary *dic = [self.dataArr[index] objectForKey:@"cellInfo"];
    ThirdWaterViewModel *model = [ThirdWaterViewModel foodListModelWithDict:dic];
    if (!flowView) {
        id cellHeight = [self.cellHeightDic objectForKey:@(index)];
        flowView = [[BYImproveFlowView alloc] initWithFrame:CGRectMake(0, 0,
                                                                       (SCREEN_WIDTH - 10 * 3)/2 ,
                                                                       [cellHeight integerValue] + 50)];
        flowView.reuseIdentifier = @"cell";
    }
    UIImage *image = [self.cellImageDic objectForKey:@(index)];
    [flowView setImage:image model:model];
    flowView.index = index;
    return flowView;
}

//每个流高度
- (CGFloat)waterView:(ZBWaterView *)waterView heightOfFlowViewAtIndex:(NSInteger)index {
    
    id cellHeight = [self.cellHeightDic objectForKey:@(index)];
    return [cellHeight integerValue] + 50;
}

#pragma mark - ZBWaterViewDelegate

- (void)needLoadMoreByWaterView:(ZBWaterView *)waterView {
    
    if(_hasMore){
        [self startReq:_offset];
    }
}

- (void)phoneWaterViewDidScroll:(ZBWaterView *)waterView {

    return;
}

- (void)waterView:(ZBWaterView *)waterView didSelectAtIndex:(NSInteger)index {
    
    _tapIndex = index;
    NSDictionary *detailDic = [self.dataArr[index] objectOrNilForKey:@"detailCell"];
    ThirdDetailViewController *vc = [ThirdDetailViewController new];
    [vc dismissBottomView];
    vc.model = self.modelArr[index];
    vc.waysArr = [detailDic objectOrNilForKey:@"doWays"];
    vc.ingredientsArr = [detailDic objectOrNilForKey:@"ingredients"];

    [self.navigationController pushViewController:vc animated:YES];
    
    NSLog(@"%d",index);
}

@end
