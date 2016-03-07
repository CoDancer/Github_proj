//
//  GPRegisterController.h
//  GraduationProject
//
//  Created by onwer on 15/11/26.
//  Copyright © 2015年 onwer. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, RegisterShowType) {
    RegisterShowType_NONE,
    RegisterShowType_USER,
    RegisterShowType_PASS
};

typedef enum {
    registerTeleNumInputFieldTag = 1,
    registerCodeInputFieldTag,
    registerPWInputFieldTag,
    registerBtnTag
} RegisterViewTag;

typedef void(^GetTeleAndPasswordBlock)(NSString *teleStr, NSString *password);

@interface GPRegisterController : BYBaseVC

@property (nonatomic, strong) GetTeleAndPasswordBlock telePwBlock;
@property (nonatomic, assign) BOOL weatherResetPassword;

@end
