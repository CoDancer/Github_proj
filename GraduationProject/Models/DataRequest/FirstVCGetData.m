//
//  FirstVCGetData.m
//  GraduationProject
//
//  Created by onwer on 16/2/1.
//  Copyright © 2016年 onwer. All rights reserved.
//

#import "FirstVCGetData.h"

@implementation FirstVCGetData

+ (instancetype)sharedClient
{
    static dispatch_once_t once;
    static FirstVCGetData *__singleton__;
    dispatch_once(&once, ^ {
        __singleton__ = [[self alloc] init];
    });
    return __singleton__;
}

GP_DEFAULT_PARAMS_API(newsDetailDataWithParam:(NSDictionary *)params channelId:(NSString *)channelId) {
    
    NSString *httpUrl = @"http://apis.baidu.com/showapi_open_bus/channel_news/search_news";
    NSString *channel = [NSString stringWithFormat:@"channelId=%@",channelId];
    NSString *httpArg = [channel stringByAppendingString:@"&channelName=%E5%9B%BD%E5%86%85%E6%9C%80%E6%96%B0&title=%E4%B8%8A%E5%B8%82&page=1"];
    NSString *urlStr = [[NSString alloc]initWithFormat: @"%@?%@", httpUrl, httpArg];
    return [self NewsPOST:urlStr parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:GP_HTTP_FAILURE];
}

@end
