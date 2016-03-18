//
//  GPSecondDetailViewController.m
//  GraduationProject
//
//  Created by CoDancer on 16/1/2.
//  Copyright © 2016年 onwer. All rights reserved.
//

#import "GPSecondDetailViewController.h"
#import "ModalAnimaion.h"
#import "UIImageView+WebCache.h"
#import "SDCycleScrollView.h"
#import "SDWebImageManager.h"
#import "UIImage+Category.h"
#import "NSString+Category.h"
#import "SDImageCache.h"
#import "GPSelectedView.h"

#import "CustomBookCell.h"
#import "BookListModel.h"
#import "ModalAnimaion.h"
#import "EachItemDetailViewController.h"
#import "SecondInfoCell.h"
#import "SecondInfoCellModel.h"
#import "SecondVCGetData.h"
#import "CardWith3DView.h"
#import "InfoFooterView.h"
#import "TribePlaceViewController.h"

//绿色主题
#define Color(r, g, b) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1]
#define GolbalGreen Color(33, 197, 180)
#define TopViewHeight 200
#define SelectdViewHeight 45
#define HeaderViewHeight 245

@interface GPSecondDetailViewController ()<SDCycleScrollViewDelegate,
                                            UIScrollViewDelegate,
                                            UITableViewDataSource,
                                            UITableViewDelegate,
                                            CustromBookCellDelegate,
GPSelectedViewDelegate>{
    SecondInfoCell *infoCell;
}

@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) SDCycleScrollView *topScrollView;
@property (nonatomic, strong) UIView *coverView;
@property (nonatomic, strong) UIImageView *IVOnCoverView;
@property (nonatomic, strong) UIButton *buttonOnCoverView;
@property (nonatomic, assign) NSInteger whichPic;

@property (nonatomic, strong) UIScrollView *backgroundScrollView;
@property (nonatomic, strong) UITableView *bottomTableView;
@property (nonatomic, strong) UIView *naviView;
@property (nonatomic, strong) UIView *ViewOnTopScrollView;

@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) UILabel *naviTitle;
@property (nonatomic, strong) UILabel *naviSubTitle;
/** 记录scrollView上次偏移X的距离 */
@property (nonatomic, assign) CGFloat scrollX;
/** 记录scrollView上次偏移的Y距离 */
@property (nonatomic, assign) CGFloat scrollY;

@property (nonatomic, strong) GPSelectedView *selectedView;

@property (nonatomic, strong) UITableView *groomTableView;
@property (nonatomic, strong) UITableView *infoTableView;
/** 记录当前展示的tableView 计算顶部topView滑动的距离 */
@property (nonatomic, weak  ) UITableView *showingTableView;
@property (nonatomic, strong) NSArray *modelArray;
@property (nonatomic, strong) NSMutableArray *eachGroupModel;
@property (nonatomic, strong) ModalAnimaion *modalAnimation;

@property (nonatomic, strong) NSDictionary *cellHeightDic;
@property (nonatomic, strong) NSDictionary *cellImageDic;
@property (nonatomic, assign) BOOL isCellImage;
@property (nonatomic, strong) CardWith3DView *headerView;
@property (nonatomic, strong) UIView *infoHeaderView;
@property (nonatomic, strong) InfoFooterView *infoFooterView;
@property (nonatomic, strong) SecondInfoPlaceModel *placeModel;

@end

@implementation GPSecondDetailViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.groomTableView registerClass:[CustomBookCell class] forCellReuseIdentifier:@"BookCell"];
    [self.infoTableView registerClass:[SecondInfoCell class] forCellReuseIdentifier:@"InfoCell"];
    [self fetchLocalData];
    [self configView];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    [self dismissBottomView];
}

- (void)configView {
    
    [self addBottomScrollViewToView];
    [self addTopViewInHeaderView];
    [self addNaviViewToView];
}

- (UIView *)topView {
    
    if (!_topView) {
        _topView = [[UIView alloc] initWithFrame:self.topScrollView.bounds];
        _topView.backgroundColor = [UIColor clearColor];
        [_topView addSubview:self.topScrollView];
        [self.topScrollView.superview addSubview:self.ViewOnTopScrollView];
    }
    return _topView;
}

- (CardWith3DView *)headerView {
    
    if (!_headerView) {
        CGRect frame = CGRectMake(0, 100*k_IOS_Scale, 320*k_IOS_Scale, 300*k_IOS_Scale);
        _headerView = [[CardWith3DView alloc] initWithFrame:frame
                                                  imageArr:self.booksArr
                                                     index:self.booksArr.count/2];
        __weak typeof(self) weakSelf = self;
        _headerView.modelBlock = ^(SecondViewCellModel *model){
            EachItemDetailViewController *vc = [EachItemDetailViewController new];
            vc.itemModel = model;
            vc.transitioningDelegate = weakSelf;
            NSDictionary *dic = [SecondVCGetData getMovieDetailInfoWithRow:weakSelf.whichRow
                                                                    number:model.itemId];
            vc.imageArray = [dic objectOrNilForKey:@"movieGlideImg"];
            vc.infoCellArr = [dic objectOrNilForKey:@"movieInfo"];
            [weakSelf presentViewController:vc animated:YES completion:nil];
        };
    }
    return _headerView;
}

- (UIView *)infoHeaderView {
    
    if (!_infoHeaderView) {
        _infoHeaderView = [UIView new];
        _infoHeaderView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 50);
        [_headerView setBackgroundColor:[UIColor colorWithHexString:@"2a3137"]];
        UILabel *contentLabel = [UILabel new];
        contentLabel.text = [NSString stringWithFormat:@"%@",self.cellModel.poi_name];
        contentLabel.font = [UIFont boldSystemFontOfSize:17.0f];
        contentLabel.textColor = [UIColor blackColor];
        [contentLabel sizeToFit];
        contentLabel.centerX = self.view.centerX;
        contentLabel.centerY = 25;
        [_infoHeaderView addSubview:contentLabel];
    }
    return _infoHeaderView;
}

- (void)addInfoFooterView {

    self.infoFooterView = [[InfoFooterView alloc]
                       initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 55, SCREEN_WIDTH, 55)];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(footerViewDidTap)];
    [self.infoFooterView addGestureRecognizer:tap];
    self.placeModel = [SecondInfoPlaceModel viewModelWithDict:self.placeDic];
    [self.infoFooterView initViewWithModel:self.placeModel titleName:self.cellModel.poi_name];
    [self.view addSubview:self.infoFooterView];
}

- (UIView *)naviView {
    
    if (!_naviView) {
        _naviView = [UIView new];
        _naviView.frame = CGRectMake(0, 0, self.view.width, 64);
        _naviView.backgroundColor = GolbalGreen;
        _naviView.alpha = 0.0;
    }
    return _naviView;
}

- (UIButton *)backBtn {
    
    if (!_backBtn) {
        _backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
        _backBtn.left = 8;
        _backBtn.centerY = 42;
        [_backBtn setImage:[UIImage imageNamed:@"nav_arrow"] forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(popViewVC)
           forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}

- (UILabel *)naviTitle {
    
    if (!_naviTitle) {
        _naviTitle = [UILabel new];
        _naviTitle.textColor = [UIColor colorWithWhite:0.047 alpha:1.000];
        _naviTitle.font = [UIFont boldSystemFontOfSize:18.0];
        _naviTitle.text = self.cellModel.poi_name;
        [_naviTitle sizeToFit];
        _naviTitle.left = self.backBtn.right + 10;
        _naviTitle.centerY = self.backBtn.centerY;
    }
    return _naviTitle;
}

- (UILabel *)naviSubTitle {
    
    if (!_naviSubTitle) {
        _naviSubTitle = [UILabel new];
        _naviSubTitle.textColor = [UIColor colorWithWhite:0.021 alpha:1.000];
        _naviSubTitle.font = [UIFont boldSystemFontOfSize:14.0];
        _naviSubTitle.text = self.cellModel.section_title;
        [_naviSubTitle sizeToFit];
        _naviSubTitle.left = 10;
        _naviSubTitle.top = self.backBtn.bottom + 10;
    }
    return _naviSubTitle;
}

- (UIScrollView *)backgroundScrollView {
    
    if (!_backgroundScrollView) {
        _backgroundScrollView = [UIScrollView new];
        _backgroundScrollView.frame = self.view.bounds;
        _backgroundScrollView.backgroundColor = [UIColor colorWithHexString:@"f3f3f3"];
        _backgroundScrollView.pagingEnabled = YES;
        _backgroundScrollView.scrollEnabled = !self.isBottomScro;
        _backgroundScrollView.bounces = NO;
        _backgroundScrollView.showsHorizontalScrollIndicator = NO;
        _backgroundScrollView.delegate = self;
        [_backgroundScrollView setContentSize:CGSizeMake(SCREEN_WIDTH * 2, 0)];
    }
    return _backgroundScrollView;
}

- (SDCycleScrollView *)topScrollView {
    
    if (!_topScrollView) {
        _topScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.view.width, 200) delegate:self placeholderImage:nil];
        _topScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        _topScrollView.currentPageDotColor = GolbalGreen;
        _topScrollView.imageURLStringsGroup = self.imageArray;
    }
    return _topScrollView;
}

- (UIView *)ViewOnTopScrollView {
    
    if (!_ViewOnTopScrollView) {
        _ViewOnTopScrollView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width * self.imageArray.count, 200)];
        _ViewOnTopScrollView.backgroundColor = GolbalGreen;
        _ViewOnTopScrollView .alpha = 0.0;
    }
    return _ViewOnTopScrollView;
}

- (UITableView *)groomTableView {
    
    if (!_groomTableView) {
        _groomTableView = [UITableView new];
        _groomTableView.backgroundColor = [UIColor colorWithHexString:@"2a3137"];
        _groomTableView.scrollEnabled = YES;
        _groomTableView.delegate = self;
        _groomTableView.dataSource = self;
        _groomTableView.frame = [UIScreen mainScreen].bounds;
        _groomTableView.contentInset = UIEdgeInsetsMake(self.selectedView.bottom, 0, 0, 0);
        _groomTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _groomTableView;
}

- (UITableView *)infoTableView {
    
    if (!_infoTableView) {
        _infoTableView = [[UITableView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, 0,
                                                                       SCREEN_WIDTH, SCREEN_HEIGHT)
                                                      style:UITableViewStylePlain];
        _infoTableView.contentInset = UIEdgeInsetsMake(self.selectedView.bottom, 0, 60, 0);
        _infoTableView.delegate = self;
        _infoTableView.dataSource = self;
        _infoTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _infoTableView;
}

- (NSDictionary *)cellHeightDic {
    
    if (!_cellHeightDic) {
        _cellHeightDic = [NSDictionary dictionary];
    }
    return _cellHeightDic;
}

- (NSArray *)dataArray {
    
    if (!_modelArray) {
        _modelArray = [NSArray array];
    }
    return _modelArray;
}

- (ModalAnimaion *)modalAnimation {
    
    if (!_modalAnimation) {
        _modalAnimation = [ModalAnimaion new];
    }
    return _modalAnimation;
}

- (GPSelectedView *)selectedView {
    
    if (!_selectedView) {
        _selectedView = [GPSelectedView selectView];
        _selectedView.delegate = self;
        _selectedView.frame = CGRectMake(0, CGRectGetMaxY(self.topView.frame),
                                         SCREEN_WIDTH, SelectdViewHeight);
    }
    return _selectedView;
}

- (UIView *)coverView {
    
    if (!_coverView) {
        _coverView = [[UIView alloc] initWithFrame:self.view.bounds];
        _coverView.backgroundColor = [UIColor blackColor];
        _coverView.alpha = 0;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(coverViewDidTap)];
        [_coverView addGestureRecognizer:tap];
    }
    return _coverView;
}

- (UIImageView *)IVOnCoverView {
    
    if (!_IVOnCoverView) {
        _IVOnCoverView = [UIImageView new];
        _IVOnCoverView.size = CGSizeMake(self.view.width, 200);
    }
    return _IVOnCoverView;
}

- (UIButton *)buttonOnCoverView {
    
    if (!_buttonOnCoverView) {
        _buttonOnCoverView = [UIButton new];
        [_buttonOnCoverView setImage:[UIImage imageNamed:@"gen_download"] forState:UIControlStateNormal];
        [_buttonOnCoverView addTarget:self action:@selector(downloadPicture) forControlEvents:UIControlEventTouchUpInside];
    }
    return _buttonOnCoverView;
}

- (void)addNaviViewToView {
    
    [self.view addSubview:self.naviView];
    [self.view addSubview:self.backBtn];
    [self.view addSubview:self.naviTitle];
    [self.view addSubview:self.naviSubTitle];
}

- (void)addTopViewInHeaderView {
    
    [self.view addSubview:self.topView];
}

- (void)addBottomScrollViewToView {
    
    [self.view addSubview:self.backgroundScrollView];
    [self.backgroundScrollView addSubview:self.groomTableView];
    if (self.isBottomScro) {
        self.groomTableView.tableHeaderView = self.headerView;
    }
    [self.view addSubview:self.selectedView];
}

- (void)popViewVC {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)fetchLocalData {
    
    __weak typeof(self) weakSelf = self;
    if (self.booksArr.count != 0 && !self.isBottomScro) {
        NSMutableArray *models = [NSMutableArray array];
        [self.booksArr enumerateObjectsUsingBlock:^(NSDictionary *obj,
                                                NSUInteger idx,
                                                BOOL * _Nonnull stop) {
            BookListModel *bookListModel = [BookListModel bookListModelWithDict:obj];
            if (idx % 3 == 0) {
                weakSelf.eachGroupModel = [NSMutableArray new];
                [models addObject:self.eachGroupModel];
            }
            [weakSelf.eachGroupModel addObject:bookListModel];
        }];
        self.modelArray = [models copy];
    }
}

#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    
    self.whichPic = index;
    [[SDWebImageManager sharedManager] downloadImageWithURL:self.imageArray[index] options:SDWebImageRetryFailed progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        self.isCellImage = NO;
        [self showDownloadImageViewWithImage:image imageFrame:CGRectMake(0, 0, self.view.width, 200)];
    }];
}

- (void)showDownloadImageViewWithImage:(UIImage *)image imageFrame:(CGRect)frame{
    
    self.IVOnCoverView.image = image;
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0 options:0 animations:^{
        self.IVOnCoverView.frame = frame;
        self.IVOnCoverView.center = self.view.center;
        self.buttonOnCoverView.size = CGSizeMake(50, 50);
        self.buttonOnCoverView.bottom = self.view.height - 20;
        self.buttonOnCoverView.centerX = self.view.centerX;
        [self.view addSubview:self.coverView];
        [self.view addSubview:self.IVOnCoverView];
        [self.view addSubview:self.buttonOnCoverView];
        self.coverView.alpha = 1.0;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)downloadPicture {
    
    [self downloadPictureWithIndex:self.whichPic];
}

- (void)downloadPictureWithIndex:(NSInteger)index {
    
    NSURL *urlOrPath = [NSURL URLWithString:self.imageArray[index]];
    NSString *savePath = [[SDImageCache sharedImageCache] defaultCachePathForKey:urlOrPath.absoluteString];
    // NSString *urlOrPath = [self.imageArray[index] otherImageDownloadPath];
    if ([[NSFileManager defaultManager] fileExistsAtPath:savePath isDirectory:nil]) {
        UIImage *image = [UIImage imageWithContentsOfFile:savePath];
        if (image) {
            [image saveToAlbumWithMetadata:nil customAlbumName:@"FabLook" completionBlock:^{
                //[UIHelper showAutoHideHUDforView:self title:@"保存成功" subTitle:nil];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"需要访问您的照片" message:@"请启用照片-设置/隐私/照片" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [alert show];
            } failureBlock:^(NSError *error) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"需要访问您的照片" message:@"请启用照片-设置/隐私/照片" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [alert show];
                
            }];
            
        }
    }
}

- (void)coverViewDidTap {
    
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0 options:0 animations:^{
        self.coverView.alpha = 0;
        self.buttonOnCoverView.size = CGSizeZero;
        self.IVOnCoverView.frame = CGRectMake(self.view.centerX,
                                              self.isCellImage ? self.view.centerY : 100, 0, 0);
    } completion:^(BOOL finished) {
        [self.coverView removeFromSuperview];
        [self.IVOnCoverView removeFromSuperview];
        self.IVOnCoverView.frame = CGRectMake(0,0, self.view.width, 200);
        [self.buttonOnCoverView removeFromSuperview];
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView == self.groomTableView || scrollView == self.infoTableView) {
        CGFloat offsetY = scrollView.contentOffset.y;
        CGFloat moveOffset = offsetY + HeaderViewHeight;
        self.scrollY = offsetY;
        CGFloat naviH = 64;
        
        //NaviView alpha
        CGFloat startF = 0;
        CGFloat alphaScaleShow = (moveOffset + startF) / (TopViewHeight - naviH);
        self.naviSubTitle.alpha = 1 - alphaScaleShow;
        if (alphaScaleShow >= 0.94) {
            [UIView animateWithDuration:0.04 animations:^{
                self.naviView.alpha = 1;
                self.naviSubTitle.alpha = 0;
            }];
        }else {
            self.naviView.alpha = 0;
        }
        self.ViewOnTopScrollView.alpha = alphaScaleShow;
        if (moveOffset > 0) {
            CGRect headRect = self.topView.frame;
            headRect.origin.y = -(offsetY + HeaderViewHeight);
            self.topView.frame = headRect;
        }else {
            self.topView.bottom = TopViewHeight - moveOffset ;
            self.selectedView.height = SelectdViewHeight;
        }
        
        CGFloat scaleTopView = 1 - (offsetY + HeaderViewHeight) / 100;
        scaleTopView = scaleTopView > 1 ? scaleTopView : 1;
        CGAffineTransform transform = CGAffineTransformMakeScale(scaleTopView, scaleTopView);
        CGFloat ty = (scaleTopView - 1) * TopViewHeight;
        self.topView.transform = CGAffineTransformTranslate(transform, 0, -ty * 0.1);
        
        if (offsetY >= -(naviH + SelectdViewHeight)) {
            self.selectedView.frame = CGRectMake(0, naviH, SCREEN_WIDTH, SelectdViewHeight);
        } else {
            self.selectedView.frame = CGRectMake(0, CGRectGetMaxY(self.topView.frame),
                                                 SCREEN_WIDTH, SelectdViewHeight);
        }
    }else {
        CGFloat selectViewOffsetY = self.isBottomScro ? 0 : self.selectedView.top - TopViewHeight;
        if (self.isBottomScro) {
            self.topView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 200);
            self.ViewOnTopScrollView.alpha = 0;
            self.naviView.alpha = 0;
            self.selectedView.frame = CGRectMake(0, 200, SCREEN_WIDTH, 45);
        }
        if (selectViewOffsetY != -TopViewHeight && selectViewOffsetY <= 0) {
            if (self.showingTableView == self.groomTableView) {
                self.groomTableView.contentOffset = CGPointMake(0, -245 - selectViewOffsetY);
            } else {
                self.infoTableView.contentOffset = CGPointMake(0, -245 - selectViewOffsetY);
            }
        }
        CGFloat offsetX = self.backgroundScrollView.contentOffset.x;
        NSInteger index = offsetX / SCREEN_WIDTH;
        CGFloat seleOffsetX = offsetX - self.scrollX;
        self.scrollX = offsetX;
        
        //根据scrollViewX偏移量算出顶部selectViewline的位置
        if (seleOffsetX > 0 && offsetX / SCREEN_WIDTH >= (0.5 + index)) {
            [self.selectedView lineToIndex:index + 1];
        } else if (seleOffsetX < 0 && offsetX / SCREEN_WIDTH <= (0.5 + index)) {
            [self.selectedView lineToIndex:index];
        }
    }
}

- (void)getDynamicCellHeight {
    
    NSMutableDictionary *cellHeightDic = [NSMutableDictionary dictionary];
    NSMutableDictionary *cellImageDic = [NSMutableDictionary dictionary];
    if (self.cellHeightDic.count == 0) {
        MBProgressHUD *hud = [UIHelper showHUDAddedTo:self.backgroundScrollView animated:YES];
        hud.yOffset = 100;
    }
    __weak typeof(self) weakSelf = self;
    [self.infoCellArr enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        SecondInfoCellModel *model = [SecondInfoCellModel cellModelWithDict:obj];
        [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:model.imageUrl] options:SDWebImageDownloaderLowPriority|SDWebImageDownloaderContinueInBackground progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
            if (image != nil) {
                CGSize size = [UIHelper getAppropriateImageSizeWithSize:image.size];
                CGSize lableSize = CGSizeMake(SCREEN_WIDTH - 20, 0);
                CGRect rect=[model.contentInfo boundingRectWithSize:lableSize
                                                            options:NSStringDrawingUsesLineFragmentOrigin
                                                         attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:16.0f],NSFontAttributeName, nil] context:nil];
                CGFloat cellHeight = size.height + rect.size.height + 20;
                [cellHeightDic setObject:@(cellHeight) forKey:@(idx)];
                [cellImageDic setObject:image forKey:@(idx)];
                if ([cellHeightDic count] == self.infoCellArr.count) {
                    weakSelf.cellHeightDic = [cellHeightDic copy];
                    weakSelf.cellImageDic = [cellImageDic copy];
                    [weakSelf.backgroundScrollView addSubview:weakSelf.infoTableView];
                    weakSelf.infoTableView.tableHeaderView = weakSelf.infoHeaderView;
                    [weakSelf.infoTableView reloadData];
                }
            }
        }];
    }];
}

#pragma mark -- UITableViewDelegate And DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == self.groomTableView && !self.isBottomScro) {
       return self.modelArray.count;
    }else if (tableView == self.infoTableView) {
        return self.infoCellArr.count;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.groomTableView && !self.isBottomScro) {
        return 200.0f;
    }else if (tableView == self.infoTableView){
        if (self.cellHeightDic.count != 0) {
            return [[self.cellHeightDic objectForKey:@(indexPath.row)] integerValue];
        }
        return 200;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.groomTableView && !self.isBottomScro) {
        CustomBookCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BookCell"];
        cell.bookModels = self.modelArray[indexPath.row];
        cell.bookDelegate = self;
        return cell;
    }else if (tableView == self.infoTableView){
        SecondInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InfoCell"];
        SecondInfoCellModel *model = [SecondInfoCellModel cellModelWithDict:self.infoCellArr[indexPath.row]];
        [cell setCellImage:[self.cellImageDic objectForKey:@(indexPath.row)] contentInfo:model.contentInfo];
        
        __weak typeof(self) weakSelf = self;
        cell.imageBlock = ^(UIImageView *imageView){
            weakSelf.isCellImage = YES;
            CGRect imageFrame;
            imageFrame = imageView.bounds;
            if (imageView.height >= SCREEN_HEIGHT) {
                imageFrame.size.height = SCREEN_HEIGHT;
            }
            [weakSelf showDownloadImageViewWithImage:imageView.image imageFrame:imageFrame];
        };
        return cell;
    }
    return nil;
}

#pragma mark - SelectViewDelegate选择条的代理方法
- (void)selectView:(GPSelectedView *)selectView didSelectedButtonFrom:(NSInteger)from to:(NSInteger)to {
    
    switch (to) {
        case 0:
            self.showingTableView = self.groomTableView;
            [self.infoFooterView removeFromSuperview];
            break;
        case 1:
            [self addInfoFooterView];
            self.showingTableView = self.infoTableView;
            if ([self.cellImageDic count] == 0) {
                [self getDynamicCellHeight];
            }
            break;
        default:
            break;
    }
    
    //根据点击的按钮计算出backgroundScrollView的内容偏移量
    CGFloat offsetX = to * SCREEN_WIDTH;
    CGPoint scrPoint = self.backgroundScrollView.contentOffset;
    scrPoint.x = offsetX;
    //默认滚动速度有点慢 加速了下
    [UIView animateWithDuration:0.3 animations:^{
        [self.backgroundScrollView setContentOffset:scrPoint];
    }];
    
}

//当滑动scrollView切换tableView时通知
- (void)selectView:(GPSelectedView *)selectView didChangeSelectedView:(NSInteger)to {
    
    if (to == 0) {
        self.showingTableView = self.groomTableView;
        [self.infoFooterView removeFromSuperview];
        self.infoFooterView = nil;
    } else if (to == 1) {
        if (self.infoFooterView == nil) {
            [self addInfoFooterView];
        }
        self.showingTableView = self.infoTableView;
        if ([self.cellImageDic count] == 0) {
            [self getDynamicCellHeight];
        }
    }
}

- (void)bookViewDidTapBookView:(BookView *)bookView {
    
    EachItemDetailViewController *itemVC = [EachItemDetailViewController new];
    itemVC.bookModel = bookView.bookModel;
    NSDictionary *dic = [SecondVCGetData getBookDetailInfoWithRow:
                         [NSString stringWithFormat:@"%ld",(long)self.whichRow]
                                                           number:bookView.bookModel.bookId];
    itemVC.imageArray = [dic objectOrNilForKey:@"bookGlideImg"];
    itemVC.infoCellArr = [dic objectOrNilForKey:@"bookInfo"];
    itemVC.transitioningDelegate = self;
    [self presentViewController:itemVC animated:YES completion:nil];
}

- (void)footerViewDidTap {
    
    TribePlaceViewController *vc = [TribePlaceViewController new];
    vc.placeModel = self.placeModel;
    vc.subTitle = self.cellModel.poi_name;
    UIImageView *view = [UIImageView new];
    [view sd_setImageWithURL:[NSURL URLWithString:self.cellModel.imageURL] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        vc.image = image;
        [self presentViewController:vc animated:YES completion:nil];
    }];
    vc.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
}

#pragma mark -- presentVC Animation

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    
    self.modalAnimation.type = AnimationTypePresent;
    return self.modalAnimation;
}

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    
    self.modalAnimation.type = AnimationTypeDismiss;
    return self.modalAnimation;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end