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

- (NSDictionary *)fetchLocalDataWithMovieData {
    
    return [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle]
                                                pathForResource:@"MovieData"
                                                ofType:@"plist"]];
}

- (NSDictionary *)fetchLocalDataWithBookStoreDeteilInfo {
    
    return [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle]
                                                       pathForResource:@"SecondDetailData"
                                                       ofType:@"plist"]];
}

- (NSDictionary *)fetchLocalDataWithBookDetailInfo {
    
    return [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle]
                                                       pathForResource:@"BookData"
                                                       ofType:@"plist"]];
}

- (NSArray *)fetchLocalDataWithTasteFoodContent {
    
    return [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]
                                                       pathForResource:@"TasteFood"
                                                       ofType:@"plist"]];
}

- (NSDictionary *)fetchLocalDataWithGroomData {
    
    return [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle]
                                                       pathForResource:@"GroomData"
                                                       ofType:@"plist"]];
}

@end
