//
//  GPFirstLaunchView.m
//  GraduationProject
//
//  Created by onwer on 15/11/25.
//  Copyright © 2015年 onwer. All rights reserved.
//

#import "GPFirstLaunchView.h"

@interface GPFirstLaunchView()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@end
@implementation GPFirstLaunchView

- (instancetype)init{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.bounces = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = NO;
        
        [self loadContentView];
        [self addSubview:self.scrollView];
    }
    return self;
}
- (void)loadContentView{
    UIImageView *image1 = [[UIImageView alloc] initWithFrame:self.bounds];
    image1.userInteractionEnabled = YES;
    image1.left = self.left;
    image1.image = image1.height > 480 ? [UIImage imageNamed:@"default_h960_1"] : [UIImage imageNamed:@"default1"];
    
    UIImageView *image2 = [[UIImageView alloc] initWithFrame:self.bounds];
    image2.userInteractionEnabled = YES;
    image2.left = image1.right;
    image2.image = image2.height > 480 ? [UIImage imageNamed:@"default_h960_2"] : [UIImage imageNamed:@"default2"];
    
    UIImageView *image3 = [[UIImageView alloc] initWithFrame:self.bounds];
    image3.userInteractionEnabled = YES;
    image3.left = image2.right;
    image3.image = image3.height > 480 ? [UIImage imageNamed:@"default_h960_3"] : [UIImage imageNamed:@"default3"];
    
    UIImageView *image4 = [[UIImageView alloc] initWithFrame:self.bounds];
    image4.userInteractionEnabled = YES;
    image4.left = image3.right;
    image4.image = image1.height > 480 ? [UIImage imageNamed:@"default_h960_4"] : [UIImage imageNamed:@"default4"];
    
    //点击时消失
    [image4 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)]];
    [_scrollView addSubview:image1];
    [_scrollView addSubview:image2];
    [_scrollView addSubview:image3];
    [_scrollView addSubview:image4];
    _scrollView.contentSize = CGSizeMake(_scrollView.width * 4, _scrollView.height);
    //滑动时消失
    //    UIImageView *image5 = [[UIImageView alloc] initWithFrame:self.bounds];
    //    image5.image = [UIImage imageNamed:@""];
    //    _scrollView.contentSize = CGSizeMake(_scrollView.width * 5, _scrollView.height);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat scrollOffset = scrollView.contentOffset.x;
    if (scrollOffset == scrollView.width * 4) {
        [self dismiss];
    }
}

- (void)dismiss{
    if (self.dismissBlock) {
        self.dismissBlock();
    }
    [self removeFromSuperview];
}

@end
