//
//  GPHTTPClient.h
//  GraduationProject
//
//  Created by CoDancer on 15/12/12.
//  Copyright © 2015年 onwer. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"

@interface GPHTTPClient : AFHTTPRequestOperationManager

+ (instancetype)sharedClient;

@end
