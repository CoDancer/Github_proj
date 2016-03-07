//
//  BaseAnimation.m
//  PopViewController
//
//  Created by onwer on 15/12/31.
//  Copyright © 2015年 onwer. All rights reserved.
//

#import "BaseAnimation.h"

@implementation BaseAnimation

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    NSAssert(NO, @"animateTransition: should be handled by subclass of BaseAnimation");
}

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 1.0;
}

-(void)handlePinch:(UIPinchGestureRecognizer *)pinch {
    NSAssert(NO, @"handlePinch: should be handled by a subclass of BaseAnimation");
}

@end
