//
//  EachItemDetailViewController.m
//  GraduationProject
//
//  Created by onwer on 16/1/19.
//  Copyright © 2016年 onwer. All rights reserved.
//

#import "EachItemDetailViewController.h"
#import "ModalAnimaion.h"
#import "UIView+Category.h"
#import "UIImageView+WebCache.h"
#import "SDCycleScrollView.h"
#import "SDWebImageManager.h"
#import "UIImage+Category.h"
#import "NSString+Category.h"
#import "SDImageCache.h"
#import "SecondInfoCellModel.h"
#import "SecondInfoCell.h"

#define Color(r, g, b) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1]
#define GolbalGreen Color(33, 197, 180)
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define ScreenBounds [UIScreen mainScreen].bounds
#define TopViewHeight 200
#define SelectdViewHeight 45
#define HeaderViewHeight 200

@interface EachItemDetailViewController()<SDCycleScrollViewDelegate,
                                            UIScrollViewDelegate,
                                            UITableViewDataSource,
                                            UITableViewDelegate>

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
/** 记录scrollView上次偏移的Y距离 */
@property (nonatomic, assign) CGFloat scrollY;

@property (nonatomic, strong) UIView *upNaviView;
@property (nonatomic, strong) UIView *topBaseView;
@property (nonatomic, strong) UILabel *upTitleLabel;
@property (nonatomic, strong) UIImageView *bookImageView;
@property (nonatomic, strong) NSString *titleName;


@property (nonatomic, strong) NSDictionary *cellHeightDic;
@property (nonatomic, strong) NSDictionary *cellImageDic;
@property (nonatomic, assign) BOOL isCellImage;
@property (nonatomic, strong) UIView *headerView;

@end

@implementation EachItemDetailViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    self.titleName = @"精彩书评";
    
    [self configView];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self.bottomTableView registerClass:[SecondInfoCell class] forCellReuseIdentifier:@"BookInfoCell"];
    [self getDynamicCellHeight];
}

- (UIView *)upNaviView {
    
    if (!_upNaviView) {
        _upNaviView = [UIView new];
        _upNaviView.backgroundColor = [UIColor colorWithRed:0.173 green:0.724 blue:0.629 alpha:1.000];
        [_upNaviView addSubview:self.upTitleLabel];
    }
    return _upNaviView;
}

- (UILabel *)upTitleLabel {
    
    if (!_upTitleLabel) {
        _upTitleLabel = [UILabel new];
        _upTitleLabel.textColor = [UIColor blackColor];
        _upTitleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
        _upTitleLabel.text = self.titleName;
    }
    return _upTitleLabel;
}

- (UIButton *)backBtn {
    
    if (!_backBtn) {
        _backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
        _backBtn.left = 8;
        _backBtn.centerY = 42;
        [_backBtn setImage:[UIImage imageNamed:@"nav_arrow"] forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(dismissVC)
           forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}

- (UIView *)headerView {
    
    if (!_headerView) {
        _headerView = [UIView new];
        _headerView.frame = CGRectMake(0, 200, SCREEN_WIDTH, 50);
        [_headerView setBackgroundColor:[UIColor whiteColor]];
        UILabel *contentLabel = [UILabel new];
        if (self.bookModel != nil) {
            contentLabel.text = [NSString stringWithFormat:@"%@书评",self.bookModel.book_name];
        }else {
            contentLabel.text = [NSString stringWithFormat:@"%@",self.itemModel.poi_name];
        }
        contentLabel.font = [UIFont boldSystemFontOfSize:17.0f];
        contentLabel.textColor = [UIColor blackColor];
        [contentLabel sizeToFit];
        contentLabel.centerX = self.view.centerX;
        contentLabel.centerY = 25;
        [_headerView addSubview:contentLabel];
    }
    return _headerView;
}

- (UILabel *)naviTitle {
    
    if (!_naviTitle) {
        _naviTitle = [UILabel new];
        _naviTitle.textColor = [UIColor colorWithWhite:0.047 alpha:1.000];
        _naviTitle.font = [UIFont boldSystemFontOfSize:18.0];
        _naviTitle.text = self.bookModel != nil ? self.bookModel.book_name : self.itemModel.poi_name;
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
        _naviSubTitle.text = self.bookModel.author;
        [_naviSubTitle sizeToFit];
        _naviSubTitle.left = 10;
        _naviSubTitle.top = self.backBtn.bottom + 10;
    }
    return _naviSubTitle;
}

- (UIView *)topBaseView {
    
    if (!_topBaseView) {
        _topBaseView = [UIView new];
        _topBaseView.backgroundColor = [UIColor whiteColor];
    }
    return _topBaseView;
}

- (NSDictionary *)cellHeightDic {
    
    if (!_cellHeightDic) {
        _cellHeightDic = [NSDictionary dictionary];
    }
    return _cellHeightDic;
}

- (void)configView {
    
    [self addBottomScrollViewToView];
    [self addTopViewInHeaderView];
    [self addNaviViewToView];
    
    if (self.bookModel != nil) {
        [self.bookImageView sd_setImageWithURL:[NSURL URLWithString:self.bookModel.imageURL]
                              placeholderImage:nil];
    }else {
        [self.bookImageView sd_setImageWithURL:[NSURL URLWithString:self.itemModel.imageURL]
                              placeholderImage:nil];
    }
    
    [self.view addSubview:self.topBaseView];
    [self.topBaseView addSubview:self.upNaviView];
    [self.topBaseView addSubview:self.bookImageView];
}

- (UIImageView *)bookImageView {
    
    if (!_bookImageView) {
        _bookImageView = [UIImageView new];
        UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(dismissBookView:)];
        swipeGesture.direction = UISwipeGestureRecognizerDirectionLeft |
        UISwipeGestureRecognizerDirectionUp;
        swipeGesture.delaysTouchesEnded = NO;
        _bookImageView.userInteractionEnabled = YES;
        [_bookImageView addGestureRecognizer:swipeGesture];
    }
    return _bookImageView;
}

- (void)viewWillLayoutSubviews {
    
    [super viewWillLayoutSubviews];
    self.topBaseView.frame = self.view.bounds;
    self.upNaviView.frame = CGRectMake(0, 0, self.view.width, 64);
    self.bookImageView.frame = CGRectMake(20, self.upNaviView.bottom + 40,
                                          self.view.width - 20 * 2, self.view.height - 80*2);
    [self.upTitleLabel sizeToFit];
    self.upTitleLabel.centerX = self.view.centerX;
    self.upTitleLabel.centerY = 42;
}

- (void)dismissBookView:(UISwipeGestureRecognizer *)ges {
    
    [UIView animateWithDuration:0.8 delay:0 options:0 animations:^{
        self.topBaseView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.topBaseView removeFromSuperview];
    }];
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

- (UIView *)naviView {
    
    if (!_naviView) {
        _naviView = [UIView new];
        _naviView.frame = CGRectMake(0, 0, self.view.width, 64);
        _naviView.backgroundColor = GolbalGreen;
        _naviView.alpha = 0.0;
    }
    return _naviView;
}

- (UIScrollView *)backgroundScrollView {
    
    if (!_backgroundScrollView) {
        _backgroundScrollView = [UIScrollView new];
        _backgroundScrollView.frame = self.view.bounds;
        _backgroundScrollView.backgroundColor = [UIColor lightGrayColor];
        _backgroundScrollView.pagingEnabled = YES;
        _backgroundScrollView.bounces = NO;
        _backgroundScrollView.showsHorizontalScrollIndicator = NO;
        _backgroundScrollView.delegate = self;
        [_backgroundScrollView setContentSize:CGSizeMake(320, 0)];
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

- (UITableView *)bottomTableView {
    
    if (!_bottomTableView) {
        _bottomTableView = [UITableView new];
        _bottomTableView.backgroundColor = [UIColor lightGrayColor];
        _bottomTableView.scrollEnabled = YES;
        _bottomTableView.delegate = self;
        _bottomTableView.dataSource = self;
        _bottomTableView.frame = [UIScreen mainScreen].bounds;
        _bottomTableView.contentInset = UIEdgeInsetsMake(self.ViewOnTopScrollView.bottom, 0, 0, 0);
    }
    return _bottomTableView;
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

- (void)dismissVC {
    [self dismissViewControllerAnimated:YES completion:nil];
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
    }
    
    CGFloat scaleTopView = 1 - (offsetY + HeaderViewHeight) / 100;
    scaleTopView = scaleTopView > 1 ? scaleTopView : 1;
    CGAffineTransform transform = CGAffineTransformMakeScale(scaleTopView, scaleTopView);
    CGFloat ty = (scaleTopView - 1) * TopViewHeight;
    self.topView.transform = CGAffineTransformTranslate(transform, 0, -ty * 0.1);
    
}

- (void)getDynamicCellHeight {
    
    NSMutableDictionary *cellHeightDic = [NSMutableDictionary dictionary];
    NSMutableDictionary *cellImageDic = [NSMutableDictionary dictionary];
    if (self.cellHeightDic.count == 0) {
        MBProgressHUD *hud = [UIHelper showHUDAddedTo:self.backgroundScrollView animated:YES];
        hud.yOffset = 100;
    }
    [self.infoCellArr enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        SecondInfoCellModel *model = [SecondInfoCellModel cellModelWithDict:obj];
        [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:model.imageUrl] options:SDWebImageDownloaderLowPriority|SDWebImageDownloaderContinueInBackground progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
            if (image) {
                CGSize size = [UIHelper getAppropriateImageSizeWithSize:image.size];
                CGSize lableSize = CGSizeMake(SCREEN_WIDTH - 20, 0);
                CGRect rect=[model.contentInfo boundingRectWithSize:lableSize
                                                            options:NSStringDrawingUsesLineFragmentOrigin
                                                         attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:16.0f],NSFontAttributeName, nil] context:nil];
                CGFloat cellHeight = size.height + rect.size.height + 20;
                [cellHeightDic setObject:@(cellHeight) forKey:@(idx)];
                [cellImageDic setObject:image forKey:@(idx)];
                if ([cellHeightDic count] == self.infoCellArr.count) {
                    self.cellHeightDic = [cellHeightDic copy];
                    self.cellImageDic = [cellImageDic copy];
                    [self.backgroundScrollView addSubview:self.bottomTableView];
                    self.bottomTableView.tableHeaderView = self.headerView;
                    [self.bottomTableView reloadData];
                }
            }
            [UIHelper hideAllMBProgressHUDsForView:self.backgroundScrollView animated:YES];
        }];
    }];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.infoCellArr.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.cellHeightDic.count != 0) {
        return [[self.cellHeightDic objectForKey:@(indexPath.row)] integerValue];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SecondInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BookInfoCell"];
    SecondInfoCellModel *model = [SecondInfoCellModel cellModelWithDict:self.infoCellArr[indexPath.row]];
    [cell setCellImage:[self.cellImageDic objectForKey:@(indexPath.row)] contentInfo:model.contentInfo];
    cell.imageBlock = ^(UIImageView *imageView){
        self.isCellImage = YES;
        CGRect imageFrame;
        imageFrame = imageView.bounds;
        if (imageView.height >= SCREEN_HEIGHT) {
            imageFrame.size.height = SCREEN_HEIGHT;
        }
        [self showDownloadImageViewWithImage:imageView.image imageFrame:imageFrame];
    };
    return cell;
}

- (void)dealloc {
    
}


@end
