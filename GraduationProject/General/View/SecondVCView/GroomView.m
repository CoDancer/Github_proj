//
//  GroomView.m
//  GraduationProject
//
//  Created by onwer on 16/3/2.
//  Copyright © 2016年 onwer. All rights reserved.
//

#import "GroomView.h"
#import "SDCycleScrollView.h"
#import "UIImageView+WebCache.h"
#import "GroomModel.h"

#define Color(r, g, b) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1]
#define GolbalGreen Color(33, 197, 180)

@interface GroomView()<SDCycleScrollViewDelegate>

@property (nonatomic, strong) UIImageView *dynamicView;
@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic, strong) NSArray *array;

@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) SDCycleScrollView *topScrollView;
@property (nonatomic, strong) NSArray *imageArray;

@end

@implementation GroomView

- (instancetype)initWithFrame:(CGRect )frame ModelArray:(NSArray *)array {
    
    self.array = array;
    return [self initWithFrame:frame];
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.topView];
        [self addAnimationOnView];
    }
    return self;
}

- (void)addAnimationOnView {
    
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self];
    for (int i = 0; i < self.array.count; i++) {
        GroomModel *model = self.array[i];
        self.dynamicView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
        self.dynamicView.clipsToBounds = YES;
        self.dynamicView.tag = i;
        self.dynamicView.userInteractionEnabled = YES;
        if (i%3 == 0) {
            self.dynamicView.left = self.centerX - 20 - self.dynamicView.width*3/2.0;
        }else if (i%3 == 1){
            self.dynamicView.centerX = self.centerX;
        }else if (i%3 == 2) {
            self.dynamicView.left = self.centerX + self.dynamicView.width/2.0 + 20;
        }
        self.dynamicView.layer.cornerRadius = self.dynamicView.height/2.0;
        self.dynamicView.clipsToBounds = YES;
        [self.dynamicView sd_setImageWithURL:[NSURL URLWithString:model.imageUrl]];
        self.dynamicView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:self.dynamicView];
        [self addTapGesOnDynamicView:self.dynamicView];
        UIGravityBehavior *gravityBehaviour = [[UIGravityBehavior alloc] initWithItems:@[self.dynamicView]];
        UICollisionBehavior *collision = [UICollisionBehavior new];
        [collision addItem:self.dynamicView];
        CGPoint startP;
        CGPoint endP;
        if (i < 3) {
            startP = CGPointMake(0, self.height - 10);
            endP = CGPointMake(SCREEN_WIDTH, self.height - 10);
        }else if (i >= 3 && i <=5) {
            startP = CGPointMake(0, self.height - 10 - 20 - self.dynamicView.height);
            endP = CGPointMake(SCREEN_WIDTH, self.height - 10 - 20 - self.dynamicView.height);
        }else if (i > 5 && i < 9) {
            startP = CGPointMake(0, self.height - 10 - (20 + self.dynamicView.height)*2);
            endP = CGPointMake(SCREEN_WIDTH, self.height - 10 - (20 + self.dynamicView.height)*2);
        }
        UIDynamicItemBehavior *itemBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[self.dynamicView]];
        [itemBehavior setElasticity:0.6];
        [collision addBoundaryWithIdentifier:@"line1" fromPoint:startP toPoint:endP];
        [self.animator addBehavior:gravityBehaviour];
        [self.animator addBehavior:collision];
        [self.animator addBehavior:itemBehavior];
    }
}

- (void)addTapGesOnDynamicView:(UIImageView *)view {
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dyanmicViewDidTap:)];
    [view addGestureRecognizer:tap];
}

- (UIView *)topView {
    
    if (!_topView) {
        _topView = [[UIView alloc] initWithFrame:self.topScrollView.bounds];
        _topView.backgroundColor = [UIColor clearColor];
        [_topView addSubview:self.topScrollView];
    }
    return _topView;
}

- (SDCycleScrollView *)topScrollView {
    
    if (!_topScrollView) {
        _topScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.width, 200) delegate:self placeholderImage:nil];
        _topScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        _topScrollView.currentPageDotColor = GolbalGreen;
        _topScrollView.imageURLStringsGroup = self.imageArray;
    }
    return _topScrollView;
}

- (NSArray *)imageArray {
    
    if (!_imageArray) {
        _imageArray = @[@"http://img5.duitang.com/uploads/item/201601/18/20160118175218_mxWHv.png",
                        @"http://img4.duitang.com/uploads/item/201305/01/20130501154553_UU5CF.jpeg",
                        @"http://img.chengmi.com/cm/5088440a-a240-4deb-908a-39e8dfc6c6d5"];
    }
    return _imageArray;
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    
    
}

- (void)dyanmicViewDidTap:(UIGestureRecognizer *)ges {
    
    if (self.actionBlock) {
        self.actionBlock(ges.view.tag);
    }
}


@end
