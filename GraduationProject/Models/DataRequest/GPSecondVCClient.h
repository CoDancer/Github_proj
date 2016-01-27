//
//  GPSecondVCClient.h
//  GraduationProject
//
//  Created by CoDancer on 16/1/2.
//  Copyright © 2016年 onwer. All rights reserved.
//

#import "GPHTTPClient.h"

@interface GPSecondVCClient : GPHTTPClient

+ (instancetype)sharedClient;

- (NSArray *)fetchLocalDataWithHomePlist;

- (NSDictionary *)fetchLocalDataWithMovieData;

- (NSDictionary *)fetchLocalDataWithBookStoreDeteilInfo;

- (NSDictionary *)fetchLocalDataWithBookDetailInfo;

@end
