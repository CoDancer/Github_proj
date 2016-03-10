//
//  GPAlertView.h
//  GraduationProject
//
//  Created by onwer on 16/3/8.
//  Copyright © 2016年 onwer. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^actionBlock)(NSInteger idx);

@interface GPAlertView : UIView

@property (nonatomic, strong) actionBlock actionBlock;

- (instancetype)initWithTitle:(NSString *)title message:(id)message buttons:(NSArray *)array;

- (void)show;

- (void)dismiss;

@end
