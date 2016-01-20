//
//  ModalAnimaion.m
//  PopViewController
//
//  Created by onwer on 15/12/31.
//  Copyright © 2015年 onwer. All rights reserved.
//

#import "ModalAnimaion.h"
#import "UIView+Category.h"

#define kScreen_Height [UIScreen mainScreen].bounds.size.height

@interface ModalAnimaion()

@property (nonatomic, strong) UIButton *coverButton;

@end

@implementation ModalAnimaion

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {

    if (self.type == AnimationTypePresent) {
        UIView *containView = [transitionContext containerView];
        UIView *modalView = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view;
        if (!_coverButton) {
            _coverButton = [[UIButton alloc] initWithFrame:containView.bounds];
            _coverButton.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
            [_coverButton addTarget:self action:@selector(coverBtnDidTap) forControlEvents:UIControlEventTouchUpInside];
            _coverButton.alpha = 0;
        }
        [containView addSubview:_coverButton];
        [containView addSubview:modalView];
        
        [containView bringSubviewToFront:modalView];
        
        modalView.frame = CGRectMake(containView.centerX, containView.centerY, 0, 0);
        [UIView animateWithDuration:1.0 delay:0.0 usingSpringWithDamping:0.8 initialSpringVelocity:1.0 options:0 animations:^{
            modalView.frame = CGRectMake(0, 0, containView.width, containView.height);
            //modalView.center = containView.center;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    }else {
        UIView *containerView = [transitionContext containerView];
        UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        
        UIView *fromSnapShot = [fromViewController.view snapshotViewAfterScreenUpdates:NO];
        fromSnapShot.frame = fromViewController.view.frame;
        [containerView insertSubview:fromSnapShot aboveSubview:fromViewController.view];
        [fromViewController.view removeFromSuperview];
        
        toViewController.view.frame = fromSnapShot.frame;
        [containerView insertSubview:toViewController.view belowSubview:fromSnapShot];

        CGFloat width = floorf(fromSnapShot.frame.size.width/2.0) + 5.0;
        
        [UIView animateKeyframesWithDuration:1.3 delay:0.0 options:0 animations:^{
            [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.2 animations:^{
                CATransform3D fromAni = CATransform3DIdentity;
                fromAni.m34 = 1.0 / -2000;
                fromAni = CATransform3DTranslate(fromAni, 0, 0, -590);
                fromSnapShot.layer.transform = fromAni;
                fromSnapShot.alpha = 1.0;
                
                CATransform3D toAni = CATransform3DIdentity;
                toAni.m34 = 1.0 / -2000;
                toAni = CATransform3DTranslate(toAni, 0, 0, -600);
                toViewController.view.layer.transform = toAni;
            }];
            
            [UIView addKeyframeWithRelativeStartTime:0.2 relativeDuration:0.2 animations:^{
                if (self.type == AnimationTypeDismiss) {
                    fromSnapShot.layer.transform = CATransform3DTranslate(fromSnapShot.layer.transform,
                                                                          width, 0.0, 0);
                    fromSnapShot.alpha = 1.0;
                    toViewController.view.layer.transform = CATransform3DTranslate(toViewController.view.layer.transform, -width, 0.0, 0.0);
                }
            }];
            
            [UIView addKeyframeWithRelativeStartTime:0.4 relativeDuration:0.2 animations:^{
                fromSnapShot.layer.transform = CATransform3DTranslate(fromSnapShot.layer.transform, 0.0, 0.0, -200);
                fromSnapShot.alpha = 0.7;
                toViewController.view.layer.transform = CATransform3DTranslate(toViewController.view.layer.transform, 0, 0, 500);
            }];
            
            [UIView addKeyframeWithRelativeStartTime:0.6 relativeDuration:0.2 animations:^{
                CATransform3D fromT = fromSnapShot.layer.transform;
                CATransform3D toT = toViewController.view.layer.transform;
                if (self.type == AnimationTypeDismiss) {
                    fromT = CATransform3DTranslate(fromT, floorf(-width), 0, 200);
                    toT = CATransform3DTranslate(toT, floorf(width * 0.03), 0, 0);
                }
                fromSnapShot.layer.transform = fromT;
                fromSnapShot.alpha = 0.4;
                toViewController.view.layer.transform = toT;
            }];
            
            [UIView addKeyframeWithRelativeStartTime:0.80 relativeDuration:0.20 animations:^{
                toViewController.view.layer.transform = CATransform3DIdentity;
                
            }];
        } completion:^(BOOL finished) {
            [_coverButton removeFromSuperview];
            [fromSnapShot removeFromSuperview];
            [transitionContext completeTransition:YES];
        }];
    }
}

- (void)coverBtnDidTap {
    [UIView animateWithDuration:0.0 animations:^{
        _coverButton.alpha = 0;
        _coverButton = nil;
    }];
    
}

@end
