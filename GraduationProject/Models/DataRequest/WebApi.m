//
//  WebApi.m
//  GraduationProject
//
//  Created by CoDancer on 15/12/19.
//  Copyright © 2015年 onwer. All rights reserved.
//

#import "WebApi.h"

@implementation WebApi

+(void)tagParams:(NSMutableDictionary *)params
{
    if (!params) {
        params = [NSMutableDictionary dictionary];
    }
    NSDate *fixedDate = [NSDate date];
    long utcTime = fixedDate ? fixedDate.timeIntervalSince1970 : time(NULL);
    
    NSString *uuid = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    NSDictionary *dictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *ver = [dictionary objectForKey:@"CFBundleShortVersionString"];
    NSString *userID = [UserDefaults objectForKey:@"user_id"];
    params[@"timesign"] = [NSString stringWithFormat:@"%ld", utcTime];
    params[@"device"] = @"ios";
    params[@"key"] = KEY;
    params[@"ver"] = ver;
    params[@"deviceuuid"] = uuid;
    if (userID != nil) {
        params[@"user_id"] = userID;
    }
    
    
    NSMutableString *stringToBeSigned = [NSMutableString string];
    
    @autoreleasepool {
        NSArray *sortedKeys = [params.allKeys sortedArrayUsingSelector:@selector(compare:)];
        for (NSString *key in sortedKeys) {
            NSString *value = params[key];
            if ([value isKindOfClass:[NSString class]]) {
                if ([value length] > 0)
                    [stringToBeSigned appendFormat:@"%@=%@&", key, value.ct_URLEncodedString];
            }
            else {
                [stringToBeSigned appendFormat:@"%@=%@&", key, value.description];
            }
        }
    }
    
    NSRange range;
    range.location = stringToBeSigned.length - 1;
    range.length = 1;
    
    [stringToBeSigned deleteCharactersInRange:range];
    params[@"sign"] = [stringToBeSigned MD5HashString];
    [params removeObjectForKey:@"key"];
}

@end
