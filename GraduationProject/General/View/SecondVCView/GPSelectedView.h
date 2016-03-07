//
//  GPSelectedView.h
//  PopViewController
//
//  Created by onwer on 16/1/18.
//  Copyright © 2016年 onwer. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GPSelectedView;

@protocol GPSelectedViewDelegate <NSObject>

@optional
//当按钮点击时通知代理
- (void)selectView:(GPSelectedView *)selectView didSelectedButtonFrom:(NSInteger)from to:(NSInteger)to;

- (void)selectView:(GPSelectedView *)selectView didChangeSelectedView:(NSInteger)to;

@end

@interface GPSelectedView : UIView

@property(nonatomic, weak) id<GPSelectedViewDelegate> delegate;

+ (instancetype)selectView;
//提供给外部一个可以滑动底部line的方法
- (void)lineToIndex:(NSInteger)index;

@end
