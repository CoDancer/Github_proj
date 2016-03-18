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

@property (nonatomic, strong) NSArray *array;
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) SDCycleScrollView *topScrollView;
@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSArray *animatorArr;

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
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
        [self.timer fireDate];
    }
    return self;
}

- (NSArray *)animatorArr {
    
    NSMutableArray *aniArr = [NSMutableArray new];
    for (int i = 0; i < 9; i++) {
        UIDynamicAnimator *ani = [UIDynamicAnimator new];
        [aniArr addObject:ani];
    }
    if (!_animatorArr) {
        _animatorArr = [aniArr copy];
    }
    return _animatorArr;
}

- (void)timeChange {
    static int time = 0;
    if (time == 0 || time < self.array.count) {
        [self getDynamicViewWithIndex:time];
    }
    time ++;
    if (time >= self.array.count) {
        time = 0;
        [_timer invalidate];
        _timer = nil;
    }
}

- (void)getDynamicViewWithIndex:(NSInteger)idx {
    
    UIImageView *dynamicView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    GroomModel *model = self.array[idx];
    dynamicView.tag = idx;
    dynamicView.userInteractionEnabled = YES;
    dynamicView.layer.cornerRadius = 30;
    dynamicView.clipsToBounds = YES;
    if (idx%3 == 0) {
        dynamicView.left = self.centerX - 20 - dynamicView.width*3/2.0;
    }else if (idx%3 == 1){
        dynamicView.centerX = self.centerX;
    }else if (idx%3 == 2) {
        dynamicView.left = 160 + 50/2.0 + 20;
    }
    [dynamicView sd_setImageWithURL:[NSURL URLWithString:model.imageUrl]];
    [self addSubview:dynamicView];
    [self addTapGesOnDynamicView:dynamicView];
    [self getAnimatorWithAni:self.animatorArr[idx] view:dynamicView idx:idx];
}

- (void )getAnimatorWithAni:(UIDynamicAnimator *)ani view:(UIImageView *)dynamicView idx:(NSInteger)i{
    
    UIGravityBehavior *gravityBehaviour = [[UIGravityBehavior alloc] initWithItems:@[dynamicView]];
    gravityBehaviour.magnitude = 100;
    gravityBehaviour.gravityDirection=CGVectorMake(0, 1);
    UICollisionBehavior *collision = [UICollisionBehavior new];
    UIDynamicItemBehavior *itemBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[dynamicView]];
    [itemBehavior setElasticity:0.6];
    [collision addItem:dynamicView];
    collision.translatesReferenceBoundsIntoBoundary = YES;
    CGPoint startP;
    CGPoint endP;
    if (i < 3) {
        startP = CGPointMake(0, self.height - 10);
        endP = CGPointMake(SCREEN_WIDTH, self.height - 10);
    }else if (i >= 3 && i <=5) {
        startP = CGPointMake(0, self.height - 10 - 20 - dynamicView.height);
        endP = CGPointMake(SCREEN_WIDTH, self.height - 10 - 20 - dynamicView.height);
    }else if (i > 5 && i < 9) {
        startP = CGPointMake(0, self.height - 10 - (20 + dynamicView.height)*2);
        endP = CGPointMake(SCREEN_WIDTH, self.height - 10 - (20 + dynamicView.height)*2);
    }
    [collision addBoundaryWithIdentifier:@"line1" fromPoint:startP toPoint:endP];
    [ani addBehavior:gravityBehaviour];
    [ani addBehavior:collision];
    [ani addBehavior:itemBehavior];
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
