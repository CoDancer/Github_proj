//
//  BaseAnimation.h
//  PopViewController
//
//  Created by onwer on 15/12/31.
//  Copyright © 2015年 onwer. All rights reserved.
//

#import <Foundation/Foundation.h>
 #import <UIKit/UIKit.h>

typedef enum {
    AnimationTypePresent,
    AnimationTypeDismiss
} AnimationType;

@interface BaseAnimation : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) AnimationType type;

@end
