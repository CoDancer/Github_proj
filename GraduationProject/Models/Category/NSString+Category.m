//
//  NSString+Category.m
//  BYHelperCode
//
//  Created by onwer on 15/10/19.
//  Copyright © 2015年 CoDancer. All rights reserved.
//

#import "NSString+Category.h"
#import "NSData+Category.h"

@implementation NSString (Category)

//判断手机号码，1开头的十一位数字
+(BOOL)CheckPhonenumberInput:(NSString *)_text{
    NSString *rule = @"^1(3|5|7|8|4)\\d{9}";
    NSPredicate *phoneNum = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",rule];
    return [phoneNum evaluateWithObject:_text];
}
//判断邮箱
+(BOOL)CheckMailInput:(NSString *)_text{
    NSString *Regex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex];
    return [emailTest evaluateWithObject:_text];
}
//判断密码，6－16位
+(BOOL)CheckPasswordInput:(NSString *)_text{
    NSString *Regex = @"\\w{6,16}";
    NSPredicate *PwTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex];
    return [PwTest evaluateWithObject:_text];
}

-(NSString *)ct_URLEncodedString{
    NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, ((CFStringRef)self), NULL, CFSTR("!*'();:@&=+$,/?%#[]<>"), kCFStringEncodingUTF8));
    return result;
}

- (NSString *)MD5HashString
{
    return [[self dataUsingEncoding:NSUTF8StringEncoding] MD5HashString];
}
//获取pic中的url中imageSize
- (CGSize)imageSizeOfUrl {
    NSArray *array = [self componentsSeparatedByString:@"size="];
    if (array.count == 2) {
        NSString *sub = [array lastObject];
        NSArray *subArray = [sub componentsSeparatedByString:@"&"];
        NSString *real = [subArray firstObject];
        NSArray *sizeArray = [real componentsSeparatedByString:@"x"];
        if (sizeArray.count == 2) {
            return CGSizeMake([[sizeArray firstObject] floatValue], [[sizeArray lastObject] floatValue]);
        } else {
            return CGSizeZero;
        }
    } else {
        return CGSizeZero;
    }
}
- (CGSize)imageSizeOfUrlFormTwo{
    NSArray *array = [self componentsSeparatedByString:@"width="];
    if (array.count == 2) {
        NSString *sub = [array lastObject];
        NSArray *subArray = [sub componentsSeparatedByString:@"&fr="];
        NSString *real = [subArray firstObject];
        NSArray *sizeArray = [real componentsSeparatedByString:@"&height="];
        if (sizeArray.count == 2) {
            return CGSizeMake([[sizeArray firstObject] floatValue], [[sizeArray lastObject] floatValue]);
        } else {
            return CGSizeZero;
        }
    } else {
        return CGSizeZero;
    }
}

@end
