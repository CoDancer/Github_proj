//
//  GPSecondVCClient.m
//  GraduationProject
//
//  Created by CoDancer on 16/1/2.
//  Copyright © 2016年 onwer. All rights reserved.
//

#import "GPSecondVCClient.h"

@interface GPSecondVCClient()

@end

@implementation GPSecondVCClient

+ (instancetype)sharedClient
{
    static dispatch_once_t once;
    static GPSecondVCClient *__singleton__;
    dispatch_once(&once, ^ {
        __singleton__ = [[self alloc] init];
    });
    return __singleton__;
}

- (NSArray *)fetchLocalDataWithHomePlist {
    
    return [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]
                                             pathForResource:@"HomeDatas"
                                             ofType:@"plist"]];
}

- (NSDictionary *)fetchLocalDataWithBookStoreGlideImage {
    
    return [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle]
                                                pathForResource:@"BookGlideImg"
                                                ofType:@"plist"]];
}

- (NSDictionary *)fetchLocalDataWithBookStoreDeteilInfo {
    
    return [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle]
                                                       pathForResource:@"SecondDetailData"
                                                       ofType:@"plist"]];
}


@end
