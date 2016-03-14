//
//  GPLoginViewController.h
//  GraduationProject
//
//  Created by onwer on 15/11/25.
//  Copyright © 2015年 onwer. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, BYLoginShowType) {
    BYLoginShowType_NONE,
    BYLoginShowType_USER,
    BYLoginShowType_PASS
};

typedef enum
{
    teleNumFieldTag = 1,
    pwFieldTag,
    teleNumInputFieldTag,
    pwInputFieldTag,
    
    commitBtTag,
    registerBtTag,
    forgetPwBtTag,
    qqLoginBtTag,
    wechatLoginBtTag,
    weiboLoginBtTag,
    lookFirstTag
} ViewTag;

@interface GPSigninViewController : BYBaseVC



@end
