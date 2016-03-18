//
//  GPSecondController.m
//  GraduationProject
//
//  Created by onwer on 15/11/26.
//  Copyright © 2015年 onwer. All rights reserved.
//

#define GlobalColor(r, g, b) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1]
//抽屉顶部距离 底部一样
#define ScaleTopMargin 35
//app的高度
#define AppWidth ([UIScreen mainScreen].bounds.size.width)
//app的宽度
#define AppHeight ([UIScreen mainScreen].bounds.size.height)
//抽屉拉出来右边剩余比例
#define ZoomScaleRight 0.14
//背景的灰色
#define BackgroundGrayColor GlobalColor(51, 52, 53)

#import "GPSecondController.h"
#import "UIView+Category.h"
#import "AddressPickerView.h"
#import "GPSecondDetailViewController.h"
#import "GPSecondVCClient.h"
#import "SecondHomeCell.h"
#import "SecondViewModel.h"
#import "SecondViewCellModel.h"
#import "SectionHeaderView.h"
#import "GPSecondDetailViewController.h"
#import "SecondVCGetData.h"
#import "GPSecondDetailListVC.h"
#import "CustomRefreshView.h"
#import "MJRefresh.h"
#import "GroomView.h"
#import "GroomModel.h"
#import "GPSigninViewController.h"
#import "GPAlertView.h"
#import <ShareSDKExtension/SSEThirdPartyLoginHelper.h>

@interface GPSecondController()<UITableViewDataSource, UITableViewDelegate, SectionHeaderViewDelegate>

@property (nonatomic, strong) UIView *currentView;
@property (nonatomic, strong) UIView *customNaviView;
@property (nonatomic, strong) UIButton *recoverBtn;
@property (nonatomic, assign) BOOL weatherShowHiddenView;
@property (nonatomic, strong) UITableView *leftMainTableView;
@property (nonatomic, strong) UIImageView *rightImageView;

@property (nonatomic, strong) NSArray *dataModels;
@property (nonatomic, strong) UIButton *recoverBottomBtn;
@property (nonatomic, strong) GroomView *groomView;
@property (nonatomic, strong) NSArray *groomModels;

@end

@implementation GPSecondController

#pragma mark -- sycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setHeadRefresh];
    [self.view addSubview:self.currentView];
    [self.view addSubview:self.recoverBottomBtn];
    [self.leftMainTableView registerClass:[SecondHomeCell class] forCellReuseIdentifier:@"HomeCell"];
    [self fetchDataWithRequest];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    NSString *userlogin = [UserDefaults objectForKey:@"userLogin"];
    self.hiddenView.isUserLogin = [userlogin boolValue];
    [self showBottomView];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)configView {
    
    [self addCustomNaviView];
    [self addCurrentBodyView];
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
    self.leftMainTableView.header = header;
}

//下拉加载数据
- (void)loadNewData {
    
    self.leftMainTableView.userInteractionEnabled = NO;
    //模拟1秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 拿到当前的下拉刷新控件，结束刷新状态
        [self fetchDataWithRequest];
        [self.leftMainTableView.header endRefreshing];
        self.leftMainTableView.userInteractionEnabled = YES;
    });
}

- (void)fetchDataWithRequest {
    
    NSArray *dataArray = [[GPSecondVCClient sharedClient] fetchLocalDataWithHomePlist];
    NSMutableArray *dataModel = [NSMutableArray new];
    for (NSDictionary *dict in dataArray) {
        SecondViewModel *homeModel = [SecondViewModel homeModelWithDict:dict];
        [dataModel addObject:homeModel];
    }
    self.dataModels = [dataModel copy];
    [self.leftMainTableView reloadData];
}

#pragma mark -- getMethods

- (NSArray *)dataModels {
    
    if (!_dataModels) {
        _dataModels = [NSArray array];
    }
    return _dataModels;
}

- (NSArray *)groomModels {
    
    if (!_groomModels) {
        _groomModels = [NSArray array];
    }
    return _groomModels;
}

- (UIView *)currentView {
    
    if (!_currentView) {
        _currentView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _currentView.backgroundColor = [UIColor colorWithRed:0.369 green:0.357 blue:0.604 alpha:1.000];
        
    }
    return _currentView;
}

- (UITableView *)leftMainTableView {
    
    if (!_leftMainTableView) {
        _leftMainTableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _leftMainTableView.top = 64;
        _leftMainTableView.height = AppHeight - 64;
        _leftMainTableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _leftMainTableView.backgroundColor = [UIColor colorWithRed:0.369 green:0.357 blue:0.604 alpha:1.000];
        _leftMainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _leftMainTableView.delegate = self;
        _leftMainTableView.dataSource = self;
    }
    return _leftMainTableView;
}

- (UIImageView *)rightImageView {
    
    if (!_rightImageView) {
        _rightImageView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _rightImageView.top = 64;
        _rightImageView.backgroundColor = [UIColor colorWithRed:0.369 green:0.357 blue:0.604 alpha:1.000];
    }
    return _rightImageView;
}

- (GroomView *)groomView {
    
    if (!_groomView) {
        _groomView = [[GroomView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 120)
                                           ModelArray:self.groomModels];
        _groomView.backgroundColor = [UIColor colorWithRed:0.369 green:0.357 blue:0.604 alpha:1.000];
        __weak __typeof(self)weakSelf = self;
        _groomView.actionBlock = ^(NSInteger idx) {
            [weakSelf pushDetailVCWithIdx:idx];
        };
    }
    return _groomView;
}

- (void)pushDetailVCWithIdx:(NSInteger)idx {
    
    GroomModel *groomModel = self.groomModels[idx];
    SecondViewModel *model = self.dataModels[[groomModel.sectionStr integerValue]];
    NSDictionary *infoDic = [SecondVCGetData getInfoContentWithSection:[groomModel.sectionStr integerValue]
                                                                   row:[groomModel.rowStr integerValue]];
    GPSecondDetailViewController *vc = [GPSecondDetailViewController new];
    SecondViewCellModel *cellModel = [SecondViewCellModel cellModelWithDict:(NSDictionary *)(model.body[[groomModel.rowStr integerValue]])];
    vc.cellModel = cellModel;
    vc.placeDic = [infoDic objectOrNilForKey:@"coordinate"];
    vc.whichRow = [groomModel.rowStr integerValue];
    if ([groomModel.sectionStr integerValue] == 0) {
        vc.imageArray = [infoDic objectOrNilForKey:@"glideImages"];
        vc.booksArr = [infoDic objectOrNilForKey:@"booksInfo"];
        vc.infoCellArr = [infoDic objectOrNilForKey:@"storeInfo"];
        vc.isBottomScro = NO;
    }else if([groomModel.sectionStr integerValue] == 1) {
        vc.imageArray = [infoDic objectOrNilForKey:@"glideImages"];
        vc.booksArr = [infoDic objectOrNilForKey:@"groomInfo"];
        vc.infoCellArr = [infoDic objectOrNilForKey:@"mainInfo"];
        vc.isBottomScro = YES;
    }
    [self.navigationController pushViewController:vc animated:YES];
}

- (UIButton *)recoverBottomBtn {
    
    if (!_recoverBottomBtn) {
        _recoverBottomBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 60, SCREEN_HEIGHT - 45, 30, 30)];
        [_recoverBottomBtn setImage:[UIImage imageNamed:@"plus_icon"] forState:UIControlStateNormal];
        [_recoverBottomBtn addTarget:self action:@selector(recoverBtnDidTap) forControlEvents:UIControlEventTouchUpInside];
    }
    return _recoverBottomBtn;
}

- (void)addCustomNaviView {
    
    [self.currentView addSubview:self.customNaviView];
}

- (UIView *)customNaviView {
    
    if (!_customNaviView) {
        
        _customNaviView = [self getCustomNaviView];
        UISegmentedControl *segmentControl = [[UISegmentedControl alloc] initWithItems:@[@"部落点",
                                                                                         @"热推荐"]];
        segmentControl.tintColor = [UIColor colorWithRed:0.780 green:0.905 blue:0.991 alpha:0.670];
        segmentControl.width = self.view.width * 0.5;
        segmentControl.height = 30.0f;
        
        NSMutableDictionary *textAttribute = [NSMutableDictionary dictionary];
        textAttribute[NSFontAttributeName] = [UIFont boldSystemFontOfSize:16.0f];
        textAttribute[NSForegroundColorAttributeName] = [UIColor whiteColor];
        [segmentControl setTitleTextAttributes:textAttribute forState:UIControlStateNormal];
        [segmentControl setTitleTextAttributes:textAttribute forState:UIControlStateSelected];
        segmentControl.selectedSegmentIndex = 0;
        [segmentControl addTarget:self action:@selector(segmentControlDidTap:) forControlEvents:UIControlEventValueChanged];
        
        segmentControl.centerX = self.view.centerX;
        segmentControl.centerY = 42;
        
        [_customNaviView addSubview:segmentControl];
    }
    return _customNaviView;
}

- (void)addCurrentBodyView {
    [self.currentView addSubview:self.leftMainTableView];
}

- (void)fetchGroomData {
    
    NSDictionary *groomDic = [[GPSecondVCClient sharedClient] fetchLocalDataWithGroomData];
    NSArray *groomArr = [groomDic objectOrNilForKey:@"itemData"];
    NSMutableArray *modelArr = [NSMutableArray new];
    [groomArr enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        GroomModel *model = [GroomModel groomModelWithDict:obj];
        [modelArr addObject:model];
    }];
    self.groomModels = [modelArr copy];
}

# pragma mark -- tapMethods

- (void)showDrawerView {
    
    self.hiddenView.isAllUnselected = YES;
    if (!self.weatherShowHiddenView) {
        //缩放比例
        CGFloat zoomScale = (AppHeight - 64  - ScaleTopMargin * 2) / (AppHeight);
        //X移动距离
        CGFloat moveX = AppWidth - AppWidth * ZoomScaleRight;
        
        [UIView animateWithDuration:0.3 animations:^{
            
            CGAffineTransform transform = CGAffineTransformMakeScale(zoomScale, zoomScale);
            self.currentView.transform = CGAffineTransformTranslate(transform, moveX, -32);
            self.weatherShowHiddenView = YES;
            [self addRecoverBtnOnCurrentView];
        }];
    }
}

- (void)addRecoverBtnOnCurrentView {
    
    self.recoverBtn = [UIButton new];
    [self.recoverBtn setBackgroundColor:[UIColor clearColor]];
    self.recoverBtn.frame = self.currentView.bounds;
    [self.recoverBtn addTarget:self action:@selector(recoverCurrentView) forControlEvents:UIControlEventTouchUpInside];
    [self.currentView addSubview:self.recoverBtn];
}

- (void)recoverCurrentView {
    
    if (self.weatherShowHiddenView) {
        [UIView animateWithDuration:0.3 animations:^{
            
            CGAffineTransform transform = CGAffineTransformMakeScale(1, 1);
            self.currentView.transform = CGAffineTransformTranslate(transform, 0, 0);
            self.weatherShowHiddenView = NO;
        }];
    }
    if (self.recoverBtn) {
        [self.recoverBtn removeFromSuperview];
    }
}

- (void)segmentControlDidTap:(UISegmentedControl *)segmentView {
    
    if (segmentView.selectedSegmentIndex == 0) {
        [self.currentView addSubview:self.leftMainTableView];
        [self.rightImageView removeFromSuperview];
    }else {
        [self.leftMainTableView removeFromSuperview];
        [self showBottomView];
        [self.currentView addSubview:self.rightImageView];
        [self fetchGroomData];
        [self.currentView addSubview:self.groomView];
    }
}

- (void)researchRecommend {
    
}

- (void)choiceAddressBtnDidTapWithButton:(UIButton *)button {
    NSLog(@"Ok");
    [AddressPickerView showPickerViewWithAddressBlock:^(NSString *addressInfo) {
        [button setTitle:addressInfo forState:UIControlStateNormal];
        button.selected = YES;
    }];
}

- (void)mainViewBtnOrFoundBtnDidTapWithButton:(UIButton *)button {
    
    NSLog(@"Ok");
    button.selected = !button.selected;
    [self recoverCurrentView];
}

- (void)userLogBtn:(UIButton *)button {
    
    if (button.tag == 100) {
        GPSigninViewController *vc = [GPSigninViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }else {
        GPAlertView *alertView = [[GPAlertView alloc] initWithTitle:@"提示" message:@"是否注销登录?" buttons:@[@"取消",@"确定"]];
        alertView.actionBlock = ^(NSInteger idx) {
            if (idx == 1) {
                [SSEThirdPartyLoginHelper logout:nil];
                [UserDefaults setObject:nil forKey:@"iconImg"];
                GPSigninViewController *vc = [GPSigninViewController new];
                vc.isLogout = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
        };
        [alertView show];
    }
}

#pragma mark -- UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [self.dataModels count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 200.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 60;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    SectionHeaderView *headerView = [[SectionHeaderView alloc] init];
    headerView.headerDelegate = self;
    headerView.homeModel = self.dataModels[section];
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SecondHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeCell"];
    SecondViewModel *model = self.dataModels[indexPath.section];
    if (cell == nil) {
        cell = [[SecondHomeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HomeCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    SecondViewCellModel *cellModel = [SecondViewCellModel cellModelWithDict:(NSDictionary *)(model.body[indexPath.row])];
    cell.model = cellModel;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SecondViewModel *model = self.dataModels[indexPath.section];
    SecondViewCellModel *cellModel = [SecondViewCellModel cellModelWithDict:(NSDictionary *)(model.body[indexPath.row])];
    GPSecondDetailViewController *vc = [GPSecondDetailViewController new];
    vc.cellModel = cellModel;
    NSDictionary *infoDic = [SecondVCGetData getInfoContentWithSection:indexPath.section
                                                                   row:indexPath.row];
    vc.placeDic = [infoDic objectOrNilForKey:@"coordinate"];
    vc.whichRow = indexPath.row;
    if (indexPath.section == 0) {
        vc.imageArray = [infoDic objectOrNilForKey:@"glideImages"];
        vc.booksArr = [infoDic objectOrNilForKey:@"booksInfo"];
        vc.infoCellArr = [infoDic objectOrNilForKey:@"storeInfo"];
        vc.isBottomScro = NO;
    }else if(indexPath.section == 1) {
        vc.imageArray = [infoDic objectOrNilForKey:@"glideImages"];
        vc.booksArr = [infoDic objectOrNilForKey:@"groomInfo"];
        vc.infoCellArr = [infoDic objectOrNilForKey:@"mainInfo"];
        vc.isBottomScro = YES;
    }
    [vc dismissBottomView];
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView.contentOffset.y > 200) {
        [self dismissBottomView];
    }else {
        [self showBottomView];
    }
}

- (void)recoverBtnDidTap {
    
    [self showBottomView];
}

#pragma mark -- SectionHeaderDelegate

- (void)sectionHeaderViewDidTap:(SectionHeaderView *)view {
    
    NSLog(@"%@",view);
    GPSecondDetailListVC *listVC = [GPSecondDetailListVC new];
    listVC.listModel = view.homeModel;
    listVC.sectionId = view.homeModel.ID;
    [self.navigationController pushViewController:listVC animated:YES];
}

@end
