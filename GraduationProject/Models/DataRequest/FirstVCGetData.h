//
//  FirstVCGetData.h
//  GraduationProject
//
//  Created by onwer on 16/2/1.
//  Copyright © 2016年 onwer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FirstVCGetData : GPHTTPClient

GP_DEFAULT_PARAMS_API(newsDetailDataWithParam:(NSDictionary *)params channelId:(NSString *)channelId);

@end
