//
//  GPSecondDetailListVC.m
//  GraduationProject
//
//  Created by onwer on 16/1/19.
//  Copyright © 2016年 onwer. All rights reserved.
//

#import "GPSecondDetailListVC.h"
#import "SecondHomeCell.h"
#import "CustomRefreshView.h"
#import "MJRefresh.h"
#import "GPSecondVCClient.h"
#import "SecondViewModel.h"
#import "GPSecondDetailViewController.h"
#import "SecondVCGetData.h"
#import "SecondViewCellModel.h"

@interface GPSecondDetailListVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *listTableView;
@property (nonatomic, strong) NSArray *glideImageArr;

@end

@implementation GPSecondDetailListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setHeadRefresh];
    self.view.backgroundColor = [UIColor colorWithHexString:@"f3f3f3"];
    self.title = self.listModel.tag_name;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithHexString:self.listModel.color]];
    [self.listTableView registerClass:[SecondHomeCell class]
               forCellReuseIdentifier:@"ListCell"];
    [self configView];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    [self dismissBottomView];
}

- (UITableView *)listTableView {
    
    if (!_listTableView) {
        _listTableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        _listTableView.backgroundColor = [UIColor colorWithHexString:@"f3f3f3"];
        _listTableView.delegate = self;
        _listTableView.dataSource = self;
        _listTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
        _listTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _listTableView;
}

- (NSArray *)glideImageArr {
    
    if (!_glideImageArr) {
        _glideImageArr = [NSArray array];
    }
    return _glideImageArr;
}

- (void)configView {
    
    [self.view addSubview:self.listTableView];
}

- (void)setHeadRefresh {
    
    CustomRefreshView *header = [CustomRefreshView headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    // 隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    // 隐藏状态
    header.stateLabel.hidden = YES;
    // 马上进入刷新状态
    [header beginRefreshing];
    // 设置header
    self.listTableView.header = header;
}

//下拉加载数据
- (void)loadNewData {
    
    //模拟1秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 拿到当前的下拉刷新控件，结束刷新状态
        [self fetchDataWithRequest];
        [self.listTableView.header endRefreshing];
        [self.listTableView reloadData];
    });
}

- (void)fetchDataWithRequest {
    
    NSArray *dataArray = [[GPSecondVCClient sharedClient] fetchLocalDataWithHomePlist];
    NSMutableArray *dataModel = [NSMutableArray new];
    for (NSDictionary *dict in dataArray) {
        SecondViewModel *homeModel = [SecondViewModel homeModelWithDict:dict];
        [dataModel addObject:homeModel];
    }
    NSInteger sectionId = [self.sectionId integerValue];
    SecondViewModel *listModel = dataModel[sectionId];
    self.listModel = listModel;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSArray *cellArr = self.listModel.body;
    return cellArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SecondHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ListCell"];
    NSArray *cellArr = self.listModel.body;
    if (cell == nil) {
        cell = [[SecondHomeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ListCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    SecondViewCellModel *cellModel = [SecondViewCellModel cellModelWithDict:(NSDictionary *)(cellArr[indexPath.row])];
    cell.model = cellModel;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 200.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *infoDic = [SecondVCGetData getInfoContentWithSection:[self.sectionId integerValue]
                                                                   row:indexPath.row];
    GPSecondDetailViewController *vc = [GPSecondDetailViewController new];
    vc.cellModel = [SecondViewCellModel cellModelWithDict:self.listModel.body[indexPath.row]];
    vc.placeDic = [infoDic objectOrNilForKey:@"coordinate"];
    vc.whichRow = indexPath.row;
    if ([self.sectionId integerValue] == 0) {
        vc.imageArray = [infoDic objectOrNilForKey:@"glideImages"];
        vc.booksArr = [infoDic objectOrNilForKey:@"booksInfo"];
        vc.infoCellArr = [infoDic objectOrNilForKey:@"storeInfo"];
        vc.isBottomScro = NO;
    }else if([self.sectionId integerValue] == 1) {
        vc.imageArray = [infoDic objectOrNilForKey:@"glideImages"];
        vc.booksArr = [infoDic objectOrNilForKey:@"groomInfo"];
        vc.infoCellArr = [infoDic objectOrNilForKey:@"mainInfo"];
        vc.isBottomScro = YES;
    }
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
