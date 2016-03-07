//
//  GPFirstController.m
//  GraduationProject
//
//  Created by onwer on 15/11/26.
//  Copyright © 2015年 onwer. All rights reserved.
//

#import "GPFirstController.h"
#import "NewsCollectionViewCell.h"
#import "NewsDetailInfoViewController.h"
#import "NewsChannelIdModel.h"
#import "NewsListViewController.h"
#import "FirstVCGetData.h"

#define kScreen_Height [UIScreen mainScreen].bounds.size.height
#define kScreen_Width [UIScreen mainScreen].bounds.size.width
#define separationWidth 8.0
#define Cell_Width (kScreen_Width - 10 * 2 - separationWidth * 2)/3.0
#define Cell_Height (kScreen_Width - 15 * 2 - separationWidth * 3)/4.0

@interface GPFirstController()<UICollectionViewDataSource,
                                UICollectionViewDelegate,
                                UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, assign) CGFloat collectionViewHeight;
@property (nonatomic, strong) NewsChannelIdModel *model;

@end

@implementation GPFirstController

- (void)viewDidLoad{
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"f3f3f3"];
    self.title = @"时事";
    self.model = [NewsChannelIdModel new];
    [self getDataAfterRequest];
}

- (void)getDataAfterRequest {
    
    NSString *httpUrl = @"http://apis.baidu.com/showapi_open_bus/channel_news/channel_news";
    NSString *httpArg = @"";
    [self request: httpUrl withHttpArg: httpArg];
}

-(void)request: (NSString*)httpUrl withHttpArg: (NSString*)HttpArg {
    
    NSString *urlStr = [[NSString alloc]initWithFormat: @"%@?%@", httpUrl, HttpArg];
    NSURL *url = [NSURL URLWithString: urlStr];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 10];
    [request setHTTPMethod: @"GET"];
    [request addValue: @"9309d411543b0b78392a309f0dcfa6b9" forHTTPHeaderField: @"apikey"];
    [NSURLConnection sendAsynchronousRequest: request
                                       queue: [NSOperationQueue mainQueue]
                           completionHandler: ^(NSURLResponse *response, NSData *data, NSError *error){
                               if (error) {
                               } else {
                                   NSInteger responseCode = [(NSHTTPURLResponse *)response statusCode];
                                   NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                   [self configView];
                               }
                           }];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
}

- (void)configView {
    
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 35)];
    [leftBtn setImage:[UIImage imageNamed:@"news"] forState:UIControlStateNormal];
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftBarItem;
    
    [self.view addSubview:self.collectionView];
    [self.collectionView registerClass:[NewsCollectionViewCell class] forCellWithReuseIdentifier:@"NewsCell"];
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (CGFloat)collectionViewHeight {
    
    if (!_collectionViewHeight) {
        CGFloat collectionViewHeight = 85 * 4 + 8 * 3 + 15;
        if (collectionViewHeight <= kScreen_Height) {
            _collectionViewHeight = collectionViewHeight;
        }else {
            _collectionViewHeight = kScreen_Height;
        }
    }
    return _collectionViewHeight;
}

- (UICollectionView *)collectionView {
    
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
        flowLayout.minimumInteritemSpacing = 8.0;
        flowLayout.minimumLineSpacing = 8.0;
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(10, 64 + 15, kScreen_Width - 10*2, self.collectionViewHeight) collectionViewLayout:flowLayout];
        _collectionView.centerY = kScreen_Height/2.0 ;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
    }
    return _collectionView;
}

- (NSArray *)dataArray {
    
    if (!_dataArray) {
        _dataArray = @[@"cars.jpg",@"entertainment.jpg",@"fashion.jpg",@"junshi.jpg",@"live.jpg",
                       @"money.jpg",@"renwen.jpg",@"society.jpg",@"sport.jpg",@"travel.jpg",
                       @"technology.jpg",@"hourse.jpg"];
    }
    return _dataArray;
}

- (void)prepareVisibleCellsForAnimationWithRow:(NSInteger )row andCell:(NewsCollectionViewCell *)cell {
    
    cell.frame = CGRectMake(cell.centerX, cell.centerY, 0, 0);
    cell.alpha = 0.f;
}

- (void)animateVisibleCell:(NewsCollectionViewCell *)cell withRow:(NSInteger)row cellFrame:(CGRect)cellFrame {
    
    cell.alpha = 1.f;
    [UIView animateWithDuration:0.25f
                          delay:0.2 * row
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         cell.frame = cellFrame;
                     }
                     completion:nil];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NewsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"NewsCell" forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.row];
    CGRect cellFrame = cell.frame;
    [self prepareVisibleCellsForAnimationWithRow:indexPath.row andCell:cell];
    [self animateVisibleCell:cell withRow:indexPath.row cellFrame:cellFrame];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NewsListViewController *vc = [NewsListViewController new];
    vc.title = [[[self.model getDic] objectOrNilForKey:@"channelName"] objectAtIndex:indexPath.row];
    vc.channelId = [[[self.model getDic] objectOrNilForKey:@"channelId"] objectAtIndex:indexPath.row];
    vc.slideArr = [FirstVCGetData getNewsSlideImagesWithRow:indexPath.row];
    [vc dismissBottomView];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(90, 85);
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

@end
