//
//  GroomView.m
//  GraduationProject
//
//  Created by onwer on 16/3/2.
//  Copyright © 2016年 onwer. All rights reserved.
//

#import "GroomView.h"

@interface GroomView()<UICollisionBehaviorDelegate>

@property (nonatomic, strong) UIImageView *dynamicView;
@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic, strong) NSArray *array;

@end

@implementation GroomView

- (instancetype)initWithFrame:(CGRect )frame ModelArray:(NSArray *)array {
    
    self.array = array;
    return [self initWithFrame:frame];
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self addAnimationOnView];
    }
    return self;
}

- (void)addAnimationOnView {
    
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self];
    for (int i = 0; i < self.array.count; i++) {
        self.dynamicView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
        self.dynamicView.clipsToBounds = YES;
        if (i%3 == 0) {
            self.dynamicView.left = self.centerX - 30 - self.dynamicView.width*3/2.0;
        }else if (i%3 == 1){
            self.dynamicView.centerX = self.centerX;
        }else if (i%3 == 2) {
            self.dynamicView.left = self.centerX + self.dynamicView.width/2.0 + 30;
        }
        self.dynamicView.layer.cornerRadius = self.dynamicView.height/2.0;
        self.dynamicView.image = [UIImage imageNamed:self.array[0]];
        [self addSubview:self.dynamicView];
        
        UIGravityBehavior *gravityBehaviour = [[UIGravityBehavior alloc] initWithItems:@[self.dynamicView]];
        UICollisionBehavior *collision = [UICollisionBehavior new];
        [collision addItem:self.dynamicView];
        CGPoint startP;
        CGPoint endP;
        CGFloat bottomHei = 60;
        if (i < 3) {
            startP = CGPointMake(0, self.height - 10 - bottomHei);
            endP = CGPointMake(SCREEN_WIDTH, self.height - 10 - bottomHei);
        }else if (i >= 3 && i <=5) {
            startP = CGPointMake(0, self.height - 10 - 40 - self.dynamicView.height - bottomHei);
            endP = CGPointMake(SCREEN_WIDTH, self.height - 10 - 40 - self.dynamicView.height - bottomHei);
        }else if (i > 5 && i < 9) {
            startP = CGPointMake(0, self.height - 10 - (40 - self.dynamicView.height)*2 - bottomHei);
            endP = CGPointMake(SCREEN_WIDTH, self.height - 10 - (40 - self.dynamicView.height)*2 - bottomHei);
        }
        UIDynamicItemBehavior *itemBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[self.dynamicView]];
        [itemBehavior setElasticity:0.6];
        [collision addBoundaryWithIdentifier:@"line1" fromPoint:startP toPoint:endP];
        [collision setCollisionDelegate:self];
        [self.animator addBehavior:gravityBehaviour];
        [self.animator addBehavior:collision];
        [self.animator addBehavior:itemBehavior];
    }
}

//- (void)createBangImage {
//    _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bang.png"]];
//    [_imageView setFrame:CGRectMake(100, [UIScreen mainScreen].bounds.size.height - 100, 40, 40)];
//    [_imageView.layer setHidden:YES];
//    [self addSubview:_imageView];
//}
//
//- (void)collisionBehavior:(UICollisionBehavior *)behavior
//      endedContactForItem:(id <UIDynamicItem>)item
//   withBoundaryIdentifier:(id <NSCopying>)identifier {
//    [self bang];
//}
//
//- (void)bang {
//    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"hidden"];
//    [animation setToValue:[NSNumber numberWithBool:NO]];
//    [animation setDuration:0.2];
//    [animation setRemovedOnCompletion:YES];
//    [_imageView.layer addAnimation:animation forKey:nil];
//}

@end
