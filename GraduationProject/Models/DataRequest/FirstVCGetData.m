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

- (void)configView {
    
    NSString *httpUrl = @"http://apis.baidu.com/showapi_open_bus/channel_news/search_news";
    NSString *httpArg = @"channelId=5572a109b3cdc86cf39001db&channelName=%E5%9B%BD%E5%86%85%E6%9C%80%E6%96%B0&title=%E4%B8%8A%E5%B8%82&page=1";
    [self request: httpUrl withHttpArg: httpArg];
}

-(void)request: (NSString*)httpUrl withHttpArg: (NSString*)HttpArg  {
    
    NSString *urlStr = [[NSString alloc]initWithFormat: @"%@?%@", httpUrl, HttpArg];
    NSURL *url = [NSURL URLWithString: urlStr];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 10];
    [request setHTTPMethod: @"GET"];
    [request addValue: @"9309d411543b0b78392a309f0dcfa6b9" forHTTPHeaderField: @"apikey"];
    [NSURLConnection sendAsynchronousRequest: request
                                       queue: [NSOperationQueue mainQueue]
                           completionHandler: ^(NSURLResponse *response, NSData *data, NSError *error){
                               if (error) {
                                   NSLog(@"Httperror: %@%ld", error.localizedDescription,(long)error.code);
                               } else {
                                   NSInteger responseCode = [(NSHTTPURLResponse *)response statusCode];
                                   NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                   NSLog(@"HttpResponseCode:%ld", (long)responseCode);
                                   NSLog(@"HttpResponseBody %@",responseString);
                               }
                           }];
}


@end
