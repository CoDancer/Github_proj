//
//  GPSignInClient.h
//  GraduationProject
//
//  Created by CoDancer on 15/12/12.
//  Copyright © 2015年 onwer. All rights reserved.
//

#import "GPHTTPClient.h"

@interface GPSignInClient : GPHTTPClient

+ (instancetype)sharedClient;
//用户注册
GP_DEFAULT_PARAMS_API(userRegisterWithParam:(NSDictionary *)params);
//获取手机验证码信息
GP_DEFAULT_PARAMS_API(fetchCodeWithPohoneWithParam:(NSDictionary *)params);
//用户登录
GP_DEFAULT_PARAMS_API(userLoginWithParam:(NSDictionary *)params);

@end
