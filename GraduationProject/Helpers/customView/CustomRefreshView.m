//
//  CustomRefreshView.m
//  GraduationProject
//
//  Created by onwer on 16/1/19.
//  Copyright © 2016年 onwer. All rights reserved.
//

#import "CustomRefreshView.h"
#import "UIImage+Category.h"

@implementation CustomRefreshView

- (void)prepare
{
    [super prepare];
    
    // 设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=50; i++) {
        NSString *imageName = [NSString stringWithFormat:@"loading_0%02zd", i];
        UIImage *image = [UIImage imageNamed:imageName];
        UIImage *newImage = [image imageByScalingToSize:CGSizeMake(40, 40)];
        [idleImages addObject:newImage];
    }
    [self setImages:idleImages forState:MJRefreshStateIdle];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 50; i<=50; i++) {
        NSString *imageName = [NSString stringWithFormat:@"loading_0%02zd", i];
        UIImage *image = [UIImage imageNamed:imageName];
        UIImage *newImage = [image imageByScalingToSize:CGSizeMake(40, 40)];
        [refreshingImages addObject:newImage];
    }
    [self setImages:refreshingImages forState:MJRefreshStatePulling];
    
    NSMutableArray *startImages = [NSMutableArray array];
    for (NSUInteger i = 50; i<= 95; i++) {
        NSString *imageName = [NSString stringWithFormat:@"loading_0%02zd", i];
        UIImage *image = [UIImage imageNamed:imageName];
        UIImage *newImage = [image imageByScalingToSize:CGSizeMake(40, 40)];
        [startImages addObject:newImage];
    }
    // 设置正在刷新状态的动画图片
    [self setImages:startImages forState:MJRefreshStateRefreshing];
    
}

@end
