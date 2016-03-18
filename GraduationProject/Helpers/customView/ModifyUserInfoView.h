//
//  ModifyUserInfoView.h
//  GraduationProject
//
//  Created by onwer on 16/3/15.
//  Copyright © 2016年 onwer. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ActionBlock)(NSInteger idx);

@interface ModifyUserInfoView : UIView

@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *fieldText;
@property (nonatomic, strong) NSString *placeholder;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) ActionBlock actionBlock;

- (instancetype)initWihtTitle:(NSString *)title message:(NSString *)message
                      leftStr:(NSString *)str rightStr:(NSString *)rightStr;

- (instancetype)initWihtCanEditTitle:(NSString *)title message:(NSString *)message
                             leftStr:(NSString *)str rightStr:(NSString *)rightStr;

- (void)show;

@end
