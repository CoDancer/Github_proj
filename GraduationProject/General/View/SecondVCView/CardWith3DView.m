//
//  CardWith3DView.m
//  PopViewController
//
//  Created by onwer on 16/1/22.
//  Copyright © 2016年 onwer. All rights reserved.
//

#import "CardWith3DView.h"
#import "UIView+Category.h"
#import "SecondVCGetData.h"
#import "MovieView.h"

#define k_IOS_Scale [[UIScreen mainScreen] bounds].size.width/320
#define baseFrame(index) CGRectMake(55*(index)*k_IOS_Scale+30*k_IOS_Scale+154*k_IOS_Scale+55*k_IOS_Scale, 20                                 *k_IOS_Scale, 144*k_IOS_Scale, 230*k_IOS_Scale)

@interface CardWith3DView()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIButton *choiceWay;
@property (nonatomic, strong) NSArray *imageArr;
@property (nonatomic, strong) NSArray *cardsViewArr;
@property (nonatomic, assign) NSInteger initialIndex;
@property (nonatomic, assign) BOOL isRight;

@property (nonatomic, strong) UIView *swipeView;
@property (nonatomic, strong) UISwipeGestureRecognizer *swipeLeftGes;
@property (nonatomic, strong) UISwipeGestureRecognizer *swipeRightGes;

@end

@implementation CardWith3DView

- (instancetype)initWithFrame:(CGRect)frame imageArr:(NSArray *)arr index:(NSInteger)index {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.initialIndex = 0;
        self.isRight = YES;
        self.imageArr = [arr mutableCopy];
        [self addSubview:self.scrollView];
        [self addSubview:self.choiceWay];
        [self initImageViewWithImageArr:arr];
        [self getCardsWithIndex:index];
        [self addGesToCardView];
    }
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
}

- (NSArray *)cardsViewArr {
    
    if (!_cardsViewArr) {
        _cardsViewArr = [NSArray array];
    }
    return _cardsViewArr;
}

- (NSArray *)imageArr {
    
    if (!_imageArr) {
        _imageArr = [NSArray array];
    }
    return _imageArr;
}

- (UIScrollView *)scrollView {
    
    if (!_scrollView) {
        _scrollView = [UIScrollView new];
        CGRect frame = self.bounds;
        frame.size.height = self.height - 50;
        _scrollView.frame = frame;
        _scrollView.userInteractionEnabled = YES;
        _scrollView.top = 0;
        _scrollView.contentSize = CGSizeMake((self.imageArr.count-1)*55*k_IOS_Scale+154*k_IOS_Scale+100*k_IOS_Scale + 50, 0);
        _scrollView.backgroundColor = [UIColor colorWithHexString:@"2a3137"];
        _scrollView.delegate = self;
    }
    return _scrollView;
}

- (UIButton *)choiceWay {
    
    if (!_choiceWay) {
        _choiceWay = [UIButton new];
        _choiceWay.frame = CGRectMake(30, 0, SCREEN_WIDTH - 30*2, 50);
        _choiceWay.layer.cornerRadius = 5.0;
        [_choiceWay setBackgroundColor:MainColor];
        [_choiceWay setTitle:@"滑动选取" forState:UIControlStateNormal];
        [_choiceWay setTitle:@"快速选取" forState:UIControlStateSelected];
        [_choiceWay setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _choiceWay.top = self.scrollView.bottom + 10;
        [_choiceWay addTarget:self action:@selector(choiceBtnDidTap:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _choiceWay;
}

- (UIView *)swipeView {
    
    if (!_swipeView) {
        _swipeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 250)];
        _swipeView.backgroundColor = [UIColor clearColor];
        _swipeView.userInteractionEnabled = YES;
        _swipeView.layer.zPosition = 1;
    }
    return _swipeView;
}

- (void)initImageViewWithImageArr:(NSArray *)imgArr {
    
    NSMutableArray *imageViewArr = [NSMutableArray array];
    [imgArr enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        SecondViewCellModel *model = [SecondViewCellModel cellModelWithDict:obj];
        MovieView *movieView = [MovieView new];
        movieView.model = model;
        movieView.tag = idx;
        movieView.layer.borderWidth = 3;
        movieView.layer.cornerRadius = 10;
        movieView.clipsToBounds = YES;
        movieView.layer.borderColor = [UIColor whiteColor].CGColor;
        movieView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapClick:)];
        [movieView addGestureRecognizer:tap];
        if (idx == 0) {
            movieView.frame = CGRectMake(0, 0, 154*k_IOS_Scale, 250*k_IOS_Scale);
            movieView.center = CGPointMake(160*k_IOS_Scale, 125*k_IOS_Scale);
        }else{
            MovieView *ima =[imageViewArr lastObject];
            if (idx == 1) {
                movieView.frame = CGRectMake(CGRectGetMaxX(ima.frame)-20*k_IOS_Scale, 20*k_IOS_Scale, 154*k_IOS_Scale, 230*k_IOS_Scale);
            }else{
                movieView.frame = CGRectMake((ima.frame.origin.x)+15*k_IOS_Scale, 20*k_IOS_Scale, 144*k_IOS_Scale, 230*k_IOS_Scale);
            }
            CATransform3D t = CATransform3DIdentity;
            t.m34 = 4.5/-2000;
            t = CATransform3DRotate(t, M_PI/2*3/4, 0, 1, 0);
            movieView.layer.transform = t;
        }
        [_scrollView addSubview:movieView];
        [imageViewArr addObject:movieView];
    }];
    self.cardsViewArr = [imageViewArr copy];
}

- (void)imageTapClick:(UITapGestureRecognizer *)sender{
    
    if (self.initialIndex == sender.view.tag) {
        if (self.modelBlock) {
            MovieView *modelView = self.cardsViewArr[self.initialIndex];
            self.modelBlock(modelView.model);
        }
        return;
    }
    if (self.initialIndex < sender.view.tag) {
        _isRight = YES;
    }else{
        _isRight = NO;
    }
    [self getCardsWithIndex:sender.view.tag];
}

- (void)getCardsWithIndex:(NSInteger)index {
    
    self.initialIndex = index;
    [self updateFrameForVisilably];
    [self updateFrame];
}

- (void)updateFrameForVisilably{
    
    MovieView *ima = self.cardsViewArr[self.initialIndex];
    if (self.initialIndex > 0 && self.initialIndex < self.cardsViewArr.count - 1) {
        
        MovieView *pre = self.cardsViewArr[self.initialIndex-1];
        MovieView *tail = self.cardsViewArr[self.initialIndex+1];
        
        CATransform3D t = CATransform3DIdentity;
        t.m34 = 4.5/-2000;
        t = CATransform3DRotate(t, -M_PI/2*3/4, 0, 1, 0);
        
        CATransform3D t2 = CATransform3DIdentity;
        t2.m34 = 4.5/-2000;
        t2 = CATransform3DRotate(t2, 0, 0, 1, 0);
        
        CATransform3D t3 = CATransform3DIdentity;
        t3.m34 = 4.5/-2000;
        t3 = CATransform3DRotate(t3, M_PI/2*3/4, 0, 1, 0);
    
        UIImageView *four = nil;
        if (self.initialIndex > 2&& self.initialIndex < self.cardsViewArr.count - 2) {
            if (_isRight) {
                four = self.cardsViewArr[self.initialIndex + 2];
            }else{
                four = self.cardsViewArr[self.initialIndex - 2];;
            }
        }
        [UIView animateWithDuration:1.0 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0 options:0 animations:^{
            if (!_isRight) {
                four.frame = CGRectMake(55*(self.initialIndex)*k_IOS_Scale+30*k_IOS_Scale+154*k_IOS_Scale+55*k_IOS_Scale, 20*k_IOS_Scale, 144*k_IOS_Scale, 230*k_IOS_Scale);
                
                tail.layer.transform = t3;
                tail.frame = CGRectMake(55*(self.initialIndex-1)*k_IOS_Scale+240*k_IOS_Scale, 20*k_IOS_Scale, 144*k_IOS_Scale, 230*k_IOS_Scale);
                ima.layer.transform = t2;
                ima.frame = CGRectMake(55*(self.initialIndex-1)*k_IOS_Scale+110*k_IOS_Scale, 0, 154*k_IOS_Scale, 250*k_IOS_Scale);
                pre.layer.transform = t;
                pre.frame = CGRectMake(55*(self.initialIndex-1)*k_IOS_Scale+30*k_IOS_Scale, 20*k_IOS_Scale, 144*k_IOS_Scale, 230*k_IOS_Scale);
            }else{
                four.frame = CGRectMake(55*(self.initialIndex-1)*k_IOS_Scale+30*k_IOS_Scale, 20*k_IOS_Scale, 144*k_IOS_Scale, 230*k_IOS_Scale);
                pre.layer.transform = t;
                pre.frame = CGRectMake(55*(self.initialIndex-1)*k_IOS_Scale, 20*k_IOS_Scale, 144*k_IOS_Scale, 230*k_IOS_Scale);
                ima.layer.transform = t2;
                ima.frame = CGRectMake(55*(self.initialIndex-1)*k_IOS_Scale+30*k_IOS_Scale+80*k_IOS_Scale, 0, 154*k_IOS_Scale, 250*k_IOS_Scale);
                tail.layer.transform = t3;
                tail.frame = CGRectMake(55*(self.initialIndex-1)*k_IOS_Scale+30*k_IOS_Scale+154*k_IOS_Scale+55*k_IOS_Scale, 20*k_IOS_Scale, 144*k_IOS_Scale, 230*k_IOS_Scale);
            }
        } completion:^(BOOL finished) {
        }];
    }else if(self.initialIndex == 0){
        MovieView *tail = self.cardsViewArr[self.initialIndex+1];
        CATransform3D t = CATransform3DIdentity;
        t.m34 = 4.5/-2000;
        t = CATransform3DRotate(t, -M_PI/2*3/4, 0, 1, 0);
        
        CATransform3D t2 = CATransform3DIdentity;
        t2.m34 = 4.5/-2000;
        t2 = CATransform3DRotate(t2, 0, 0, 1, 0);
        
        CATransform3D t3 = CATransform3DIdentity;
        t3.m34 = 4.5/-2000;
        t3 = CATransform3DRotate(t3, M_PI/2*3/4, 0, 1, 0);
        
        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0 options:0 animations:^{
            ima.layer.transform = t2;
            ima.frame = CGRectMake(55*(self.initialIndex - 1)*k_IOS_Scale+110*k_IOS_Scale, 0, 154*k_IOS_Scale, 250*k_IOS_Scale);
            tail.layer.transform = t3;
            tail.frame = CGRectMake(55*(self.initialIndex - 1)*k_IOS_Scale+234*k_IOS_Scale, 20*k_IOS_Scale, 144*k_IOS_Scale, 230*k_IOS_Scale);
        }completion:^(BOOL finished) {
        }];
    
    }else if (self.initialIndex == self.cardsViewArr.count - 1){
        MovieView *pre = self.cardsViewArr[self.initialIndex - 1];
        
        CATransform3D t = CATransform3DIdentity;
        t.m34 = 4.5/-2000;
        t = CATransform3DRotate(t, -M_PI/2*3/4, 0, 1, 0);
        
        CATransform3D t2 = CATransform3DIdentity;
        t2.m34 = 4.5/-2000;
        t2 = CATransform3DRotate(t2, 0, 0, 1, 0);
        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0 options:0 animations:^{
            pre.layer.transform = t;
            pre.frame = CGRectMake(55*(self.initialIndex-1)*k_IOS_Scale+30*k_IOS_Scale, 20*k_IOS_Scale, 144*k_IOS_Scale, 230*k_IOS_Scale);
            ima.layer.transform = t2;
            ima.frame = CGRectMake(55*(self.initialIndex-1)*k_IOS_Scale+30*k_IOS_Scale+80*k_IOS_Scale, 0, 154*k_IOS_Scale, 250*k_IOS_Scale);
            
        }completion:^(BOOL finished) {
        }];
    }
}

- (void)updateFrame{
    
    for (NSInteger i=0; i<self.cardsViewArr.count; i++) {
        MovieView *imageV = self.cardsViewArr[i];
        if (i==self.initialIndex) {
            if (i==0) {
                imageV.frame = CGRectMake(0, 0, 180*k_IOS_Scale, 250*k_IOS_Scale);
                imageV.centerX = SCREEN_WIDTH/2.0;
                imageV.centerY = 125*k_IOS_Scale;
            }else{
                MovieView *ima = self.cardsViewArr[i-1];
                imageV.frame = CGRectMake(ima.frame.origin.x+66*k_IOS_Scale, 0, 180*k_IOS_Scale, 250*k_IOS_Scale);
            }
            if (_isRight) {
                CATransform3D t = CATransform3DIdentity;
                t.m34 = 4.5/-2000;
                t = CATransform3DRotate(t, 0, 0, 1, 0);
                imageV.layer.transform = t;
            }else{
                CATransform3D t = CATransform3DIdentity;
                t.m34 = 4.5/-2000;
                t = CATransform3DRotate(t, 0, 0, 1, 0);
                imageV.layer.transform = t;
            }
        }else if (i<self.initialIndex){
            CATransform3D t = CATransform3DIdentity;
            t.m34 = 4.5/-2000;
            t = CATransform3DRotate(t, -M_PI/2*3/4, 0, 1, 0);
            imageV.layer.transform = t;
            imageV.frame = CGRectMake(55*i*k_IOS_Scale+20*k_IOS_Scale, 20*k_IOS_Scale, 144*k_IOS_Scale, 230*k_IOS_Scale);
            
        }else if (i>self.initialIndex){
            CATransform3D t = CATransform3DIdentity;
            t.m34 = 4.5/-2000;
            t = CATransform3DRotate(t, M_PI/2*3/4, 0, 1, 0);
            imageV.layer.transform = t;
            imageV.frame = CGRectMake(55*(i-1)*k_IOS_Scale+20*k_IOS_Scale+154*k_IOS_Scale+55*k_IOS_Scale, 20*k_IOS_Scale, 144*k_IOS_Scale, 230*k_IOS_Scale);
        }
    }
    MovieView *imaa = self.cardsViewArr[self.initialIndex];
    _scrollView.contentOffset = CGPointMake(imaa.frame.origin.x-70 , 0);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView.contentOffset.x == 0) {
        [self getCardsWithIndex:0];
    }else if (scrollView.contentOffset.x == self.scrollView.contentSize.width - self.width) {
        [self getCardsWithIndex:self.imageArr.count - 1];
    }
}

- (void)addGesToCardView {
    
    [self addSubview:self.swipeView];
    self.swipeRightGes = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeCardView:)];
    self.swipeRightGes.direction = UISwipeGestureRecognizerDirectionRight;
    self.swipeRightGes.delaysTouchesBegan = NO;
    
    self.swipeLeftGes = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeCardView:)];
    self.swipeLeftGes.direction = UISwipeGestureRecognizerDirectionLeft;
    self.swipeLeftGes.delaysTouchesBegan = NO;
    
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cardViewDidTap)];
    [self.swipeView addGestureRecognizer:self.swipeRightGes];
    [self.swipeView addGestureRecognizer:self.swipeLeftGes];
    [self.swipeView addGestureRecognizer:tapGes];
}

- (void)swipeCardView:(UISwipeGestureRecognizer *)ges {
    
    if (ges == self.swipeRightGes && self.initialIndex != 0) {
        self.isRight = YES;
        [self getCardsWithIndex:--self.initialIndex];
    }else if (ges == self.swipeLeftGes && self.initialIndex != self.imageArr.count - 1) {
        self.isRight = NO;
        [self getCardsWithIndex:++self.initialIndex];
    }
}

- (void)cardViewDidTap {
    
    if (self.modelBlock) {
        MovieView *modelView = self.cardsViewArr[self.initialIndex];
        self.modelBlock(modelView.model);
    }
}

- (void)choiceBtnDidTap:(UIButton *)sender {
    
    self.choiceWay.selected = !sender.selected;
    if (self.choiceWay.selected == YES) {
        [self.swipeView removeFromSuperview];
    }else {
        [self addGesToCardView];
    }
}

- (void)dealloc {
    
}

@end
