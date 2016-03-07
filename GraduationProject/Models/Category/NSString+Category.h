//
//  NSString+Category.h
//  BYHelperCode
//
//  Created by onwer on 15/10/19.
//  Copyright © 2015年 CoDancer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Category)

//判断手机号码，1开头的十一位数字
+(BOOL)CheckPhonenumberInput:(NSString *)_text;
//判断邮箱
+(BOOL)CheckMailInput:(NSString *)_text;
//判断密码，6－16位
+(BOOL)CheckPasswordInput:(NSString *)_text;

-(NSString *)ct_URLEncodedString;

- (NSString *)MD5HashString;

//获取pic中的url中imageSize
- (CGSize)imageSizeOfUrl;

- (CGSize)imageSizeOfUrlFormTwo;

@end
