//
//  NewsDetailInfoViewController.m
//  GraduationProject
//
//  Created by CoDancer on 15/12/26.
//  Copyright © 2015年 onwer. All rights reserved.
//

#import "NewsDetailInfoViewController.h"
#import "SDCycleScrollView.h"
#import "SDWebImageManager.h"
#import "MJRefresh.h"

#define Color(r, g, b) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1]
#define GolbalGreen Color(33, 197, 180)
#define ScreenBounds [UIScreen mainScreen].bounds
#define TopViewHeight 200
#define HeaderViewHeight 200

@interface NewsDetailInfoViewController()<SDCycleScrollViewDelegate, UIScrollViewDelegate ,WKNavigationDelegate>

@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) SDCycleScrollView *topScrollView;
@property (nonatomic, strong) UIView *coverView;
@property (nonatomic, strong) UIImageView *IVOnCoverView;
@property (nonatomic, strong) UIButton *buttonOnCoverView;
@property (nonatomic, assign) NSInteger whichPic;

@property (nonatomic, strong) UIScrollView *backgroundScrollView;
@property (nonatomic, strong) UIView *naviView;
@property (nonatomic, strong) UIView *ViewOnTopScrollView;
@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) UILabel *naviTitle;
@property (nonatomic, assign) CGFloat scrollY;

@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) MBProgressHUD *hud;
@property (nonatomic, assign) BOOL isFirstLoad;

@end

@implementation NewsDetailInfoViewController

- (UIView *)topView {
    
    if (!_topView) {
        _topView = [[UIView alloc] initWithFrame:self.topScrollView.bounds];
        _topView.backgroundColor = [UIColor clearColor];
        [_topView addSubview:self.topScrollView];
        [self.topScrollView.superview addSubview:self.ViewOnTopScrollView];
    }
    return _topView;
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

- (UIScrollView *)backgroundScrollView {
    
    if (!_backgroundScrollView) {
        _backgroundScrollView = [UIScrollView new];
        _backgroundScrollView.frame = self.view.bounds;
        _backgroundScrollView.backgroundColor = [UIColor colorWithRed:0.369 green:0.357 blue:0.604 alpha:1.000];
        _backgroundScrollView.pagingEnabled = YES;
        _backgroundScrollView.bounces = NO;
        _backgroundScrollView.showsHorizontalScrollIndicator = NO;
        _backgroundScrollView.delegate = self;
        [_backgroundScrollView setContentSize:CGSizeMake(320, 0)];
    }
    return _backgroundScrollView;
}

- (UIButton *)buttonOnCoverView {
    
    if (!_buttonOnCoverView) {
        _buttonOnCoverView = [UIButton new];
        [_buttonOnCoverView setImage:[UIImage imageNamed:@"gen_download"] forState:UIControlStateNormal];
        [_buttonOnCoverView addTarget:self action:@selector(downloadPicture) forControlEvents:UIControlEventTouchUpInside];
    }
    return _buttonOnCoverView;
}

- (WKWebView *)webView {
    
    if (!_webView) {
        WKWebViewConfiguration * configuration = [WKWebViewConfiguration new];
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, self.ViewOnTopScrollView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT - 64) configuration:configuration];
        _webView.navigationDelegate = self;
        _webView.allowsBackForwardNavigationGestures = YES;
        _webView.scrollView.delegate = self;
    }
    return _webView;
}

- (UILabel *)naviTitle {
    
    if (!_naviTitle) {
        _naviTitle = [UILabel new];
        _naviTitle.textColor = [UIColor colorWithWhite:0.047 alpha:1.000];
        _naviTitle.font = [UIFont systemFontOfSize:18.0];
        _naviTitle.text = self.detailModel.sourceStr;
        [_naviTitle sizeToFit];
        _naviTitle.left = self.backBtn.right + 10;
        _naviTitle.centerY = self.backBtn.centerY;
    }
    return _naviTitle;
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

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self configView];
}

- (void)configView {
    
    [self addBottomScrollViewToView];
    [self addTopViewInHeaderView];
    [self addNaviViewToView];
    [self addWebView];
}

- (void)addBottomScrollViewToView {
    
    [self.view addSubview:self.backgroundScrollView];
}

- (void)addTopViewInHeaderView {
    
    [self.view addSubview:self.topView];
}

- (void)addNaviViewToView {
    
    [self.view addSubview:self.naviView];
    [self.view addSubview:self.backBtn];
    [self.view addSubview:self.naviTitle];
}

- (void)addWebView {
    
    self.isFirstLoad = YES;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.detailModel.linkStr]]];
    [self.backgroundScrollView addSubview:self.webView];
}

#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    
    self.whichPic = index;
    [[SDWebImageManager sharedManager] downloadImageWithURL:self.imageArray[index] options:SDWebImageRetryFailed progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        [self showDownloadImageViewWithImage:image imageFrame:CGRectMake(0, 0, self.view.width, 200)];
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

- (void)coverViewDidTap {
    
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0 options:0 animations:^{
        self.coverView.alpha = 0;
        self.buttonOnCoverView.size = CGSizeZero;
        self.IVOnCoverView.frame = CGRectMake(self.view.centerX,100, 0, 0);
    } completion:^(BOOL finished) {
        [self.coverView removeFromSuperview];
        [self.IVOnCoverView removeFromSuperview];
        self.IVOnCoverView.frame = CGRectMake(0,0, self.view.width, 200);
        [self.buttonOnCoverView removeFromSuperview];
    }];
}

- (void)putImageToMyDirWithImage:(UIImage *)image {
    
    if (image) {
        [image saveToAlbumWithMetadata:nil customAlbumName:@"MyApp" completionBlock:^{
            //[UIHelper showAutoHideHUDforView:self title:@"保存成功" subTitle:nil];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"需要访问您的照片" message:@"请启用照片-设置/隐私/照片" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alert show];
        } failureBlock:^(NSError *error) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"需要访问您的照片" message:@"请启用照片-设置/隐私/照片" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alert show];
        }];
    }
}

- (void)dismissVC {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat moveOffset = offsetY;
    self.scrollY = offsetY;
    CGFloat naviH = 64;
    
    //NaviView alpha
    CGFloat startF = 0;
    CGFloat alphaScaleShow = (moveOffset + startF) / (TopViewHeight - naviH);
    if (alphaScaleShow >= 0.94) {
        [UIView animateWithDuration:0.04 animations:^{
            self.naviView.alpha = 1;
        }];
    }else {
        self.naviView.alpha = 0;
    }
    self.ViewOnTopScrollView.alpha = alphaScaleShow;
    if (moveOffset > 0) {
        CGRect headRect = self.topView.frame;
        headRect.origin.y = -offsetY;
        self.topView.frame = headRect;
        
        CGRect webRect = self.topView.frame;
        webRect.origin.y = 200-offsetY;
        webRect.size.height = SCREEN_HEIGHT - 64;
        self.webView.frame = webRect;
        if (offsetY >= 200 - naviH) {
            self.webView.top = 64;
        }
        
        self.topView.bottom = TopViewHeight - moveOffset;
    }else {
        self.topView.bottom = TopViewHeight - moveOffset;
        self.topView.top = 0;
        self.webView.top = TopViewHeight;
    }
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    
    if (self.isFirstLoad) {
        self.hud = [UIHelper showHUDAddedTo:self.backgroundScrollView animated:YES];
        self.hud.yOffset = 100;
        self.isFirstLoad = NO;
    }
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
    [UIHelper hideAllMBProgressHUDsForView:self.backgroundScrollView animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    _webView.scrollView.delegate = nil;
}

@end
