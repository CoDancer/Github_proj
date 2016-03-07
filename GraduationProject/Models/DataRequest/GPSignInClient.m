//
//  GPSignInClient.m
//  GraduationProject
//
//  Created by CoDancer on 15/12/12.
//  Copyright © 2015年 onwer. All rights reserved.
//

#import "GPSignInClient.h"

@implementation GPSignInClient

+ (instancetype)sharedClient
{
    static dispatch_once_t once;
    static GPSignInClient *__singleton__;
    dispatch_once(&once, ^ {
        __singleton__ = [[self alloc] init];
    });
    return __singleton__;
}

GP_DEFAULT_PARAMS_API(userRegisterWithParam:(NSDictionary *)params) {
    return [self POST:@"/user/reg" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:GP_HTTP_FAILURE];
}

GP_DEFAULT_PARAMS_API(fetchCodeWithPohoneWithParam:(NSDictionary *)params) {
    return [self POST:@"/user/getcode" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:GP_HTTP_FAILURE];
}
GP_DEFAULT_PARAMS_API(userLoginWithParam:(NSDictionary *)params) {
    return [self POST:@"/user/login" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:GP_HTTP_FAILURE];
}

@end
