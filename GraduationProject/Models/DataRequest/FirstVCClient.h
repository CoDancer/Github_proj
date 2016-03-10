//
//  FirstVCClient.h
//  GraduationProject
//
//  Created by onwer on 16/3/1.
//  Copyright © 2016年 onwer. All rights reserved.
//

#import "GPHTTPClient.h"

@interface FirstVCClient : GPHTTPClient

//+ (instancetype)sharedClient;

- (NSDictionary *)fetchLocalDataWithNewsSlidePlist;

@end
