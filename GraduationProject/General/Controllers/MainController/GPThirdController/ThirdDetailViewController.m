//
//  ThirdDetailViewController.m
//  GraduationProject
//
//  Created by onwer on 16/1/28.
//  Copyright © 2016年 onwer. All rights reserved.
//

#import "ThirdDetailViewController.h"
#import "ThirdDetailHeaderView.h"
#import "UIImageView+WebCache.h"
#import "IngredientsCell.h"
#import "BaseAnimation.h"
#import "ShuffleAnimation.h"
#import "ThirdDoFoodViewController.h"

@interface ThirdDetailViewController()<UITableViewDataSource, UITableViewDelegate>{
        ShuffleAnimation *_shuffleAnimationController;
}

@property (nonatomic, strong) ThirdDetailHeaderView *headerView;
@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *ingreModelArr;

@end

@implementation ThirdDetailViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = self.model.titleName;
    self.automaticallyAdjustsScrollViewInsets = NO;
    _shuffleAnimationController = [[ShuffleAnimation alloc] init];
    [self.tableView registerClass:[IngredientsCell class] forCellReuseIdentifier:@"ingreCell"];
    [self configView];
}

- (void)configView {
    
    [self addHeaderView];
    [self getLocalData];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self dismissBottomView];
}

- (void)addHeaderView {
    
    MBProgressHUD *hud = [UIHelper showHUDAddedTo:self.view animated:YES];
    hud.yOffset = 0;
    [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:self.model.imageURL] options:SDWebImageDownloaderLowPriority|SDWebImageDownloaderContinueInBackground progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
        if (image) {
            self.headerView.image = image;
            [self.view addSubview:self.tableView];
            self.tableView.tableHeaderView = self.headerView;
            self.tableView.tableFooterView = self.footerView;
            [self.tableView reloadData];
        }
        [UIHelper hideAllMBProgressHUDsForView:self.view animated:YES];
    }];
}

- (void)getLocalData {
    
    NSMutableArray *ingreArr = [NSMutableArray array];
    [self.ingredientsArr enumerateObjectsUsingBlock:^(NSDictionary *obj,
                                                      NSUInteger idx, BOOL * _Nonnull stop) {
        IngredientsModel *model = [IngredientsModel ingredientModelWithDict:obj];
        [ingreArr addObject:model];
    }];
    self.ingreModelArr = [ingreArr copy];
}

- (ThirdDetailHeaderView *)headerView {
    
    if (!_headerView) {
        _headerView = [[ThirdDetailHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH- 40)];
    }
    return _headerView;
}

- (UIView *)footerView {
    
    if (!_footerView) {
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
        UIButton *enterBtn = [[UIButton alloc] initWithFrame:CGRectMake(30, 0, SCREEN_WIDTH - 30*2, 40)];
        enterBtn.centerY = _footerView.height/2.0;
        enterBtn.layer.cornerRadius = 5.0f;
        [enterBtn setTitle:@"进入厨房" forState:UIControlStateNormal];
        [enterBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [enterBtn setBackgroundColor:MainColor];
        [enterBtn.titleLabel setFont:[UIFont systemFontOfSize:18.0f]];
        [enterBtn addTarget:self action:@selector(enterBtnDidTap) forControlEvents:UIControlEventTouchUpInside];
        [_footerView addSubview:enterBtn];
    }
    return _footerView;
}

- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        _tableView.backgroundColor = [UIColor colorWithHexString:@"f3f3f3"];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.bounces = NO;
        _tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (NSArray *)ingredientsArr {
    
    if (!_ingredientsArr) {
        _ingredientsArr = [NSArray array];
    }
    return _ingredientsArr;
}

#pragma mark -- UITableViewDelegate DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.ingredientsArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    IngredientsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ingreCell"];
    if (cell == nil) {
        cell = [[IngredientsCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:@"ingreCell"];
    }
    cell.model = self.ingreModelArr[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 40;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y > -44) {
        if (!scrollView.bounces) scrollView.bounces = YES;
    } else {
        if (scrollView.bounces) scrollView.bounces = NO;
    }
}

- (void)enterBtnDidTap {
    
    ThirdDoFoodViewController *vc = [ThirdDoFoodViewController new];
    vc.doWaysArr = self.waysArr;
    self.navigationController.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Navigation Controller Delegate

-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    
    BaseAnimation *animationController;
    
    animationController = _shuffleAnimationController;
    switch (operation) {
        case UINavigationControllerOperationPush:
            animationController.type = AnimationTypePresent;
            return  animationController;
        case UINavigationControllerOperationPop:
            animationController.type = AnimationTypeDismiss;
            return animationController;
        default: return nil;
    }
    
}
@end
