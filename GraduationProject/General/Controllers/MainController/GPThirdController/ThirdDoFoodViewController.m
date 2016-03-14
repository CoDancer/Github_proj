//
//  ThirdDoFoodViewController.m
//  GraduationProject
//
//  Created by onwer on 16/1/29.
//  Copyright © 2016年 onwer. All rights reserved.
//

#import "ThirdDoFoodViewController.h"
#import "ThirdDoFoodHeaderView.h"
#import "DoWaysModel.h"
#import "DoWaysCell.h"
#import "GPThirdController.h"

@interface ThirdDoFoodViewController()<UITableViewDataSource, UITableViewDelegate>{
    DoWaysCell *simpleCell;
}

@property (nonatomic, strong) UIView *headerBaseView;
@property (nonatomic, strong) ThirdDoFoodHeaderView *headerView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *baseTableView;
@property (nonatomic, strong) NSArray *modelArr;
@property (nonatomic, strong) UIImageView *backgroundIV;

@end

@implementation ThirdDoFoodViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    simpleCell = [DoWaysCell new];
    self.title = @"召唤小厨师";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor colorWithHexString:@"f3f3f3"];
    [self.tableView registerClass:[DoWaysCell class] forCellReuseIdentifier:@"doWaysCell"];
    [self.view addSubview:self.backgroundIV];
    [self.view addSubview:self.headerBaseView];
    [self.view addSubview:self.baseTableView];
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.tableView];
    [self getLocalModelArr];
}

- (ThirdDoFoodHeaderView *)headerView {
    
    if (!_headerView) {
        _headerView = [[ThirdDoFoodHeaderView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 160*k_IOS_Scale)];
    }
    return _headerView;
}

- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.headerView.bottom + 5, SCREEN_WIDTH, SCREEN_HEIGHT - self.headerView.height - 5 - 64)];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.bounces = NO;
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (UIImageView *)backgroundIV {
    
    if (!_backgroundIV) {
        _backgroundIV = [[UIImageView alloc] initWithFrame:self.view.bounds];
        _backgroundIV.image = [UIImage imageNamed:@"doWayBG.jpg"];
    }
    return _backgroundIV;
}

- (NSArray *)modelArr {
    
    if (!_modelArr) {
        _modelArr = [NSArray array];
    }
    return _modelArr;
}

- (UIView *)headerBaseView {
    
    if (!_headerBaseView) {
        _headerBaseView = [[UIView alloc] initWithFrame:self.headerView.bounds];
        _headerBaseView.top = 64;
        _headerBaseView.backgroundColor = [UIColor whiteColor];
        _headerBaseView.alpha = 0.85;
    }
    return _headerBaseView;
}

- (UIView *)baseTableView {
    
    if (!_baseTableView) {
        _baseTableView = [[UIView alloc] initWithFrame:self.tableView.bounds];
        _baseTableView.top = self.headerBaseView.bottom + 5;
        _baseTableView.backgroundColor = [UIColor whiteColor];
        _baseTableView.alpha = 0.85;
    }
    return _baseTableView;
}

- (void)getLocalModelArr {
    
    NSMutableArray *modelArr = [NSMutableArray array];
    [self.doWaysArr enumerateObjectsUsingBlock:^(NSDictionary *obj,
                                                 NSUInteger idx, BOOL * _Nonnull stop) {
        DoWaysModel *model = [DoWaysModel doWaysModelWithDict:obj];
        [modelArr addObject:model];
    }];
    self.modelArr = [modelArr copy];
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.modelArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DoWaysCell *cell = [tableView dequeueReusableCellWithIdentifier:@"doWaysCell"];
    if (cell == nil) {
        cell = [[DoWaysCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:@"doWaysCell"];
    }
    cell.model = self.modelArr[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    DoWaysModel *model = self.modelArr[indexPath.row];
    return [simpleCell getCellHeightWithCellContent:model.howDo];
}

@end
