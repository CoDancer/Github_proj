//
//  NSData+Category.m
//  BYHelperCode
//
//  Created by onwer on 15/10/22.
//  Copyright © 2015年 CoDancer. All rights reserved.
//

#import "NSData+Category.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSData (Category)

- (NSString *)MD5HashString
{
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5([self bytes], (CC_LONG)[self length], result);
    
    NSString *fmt = @"%02x%02x%02x%02x%02x%02x%02x%02x"
    @"%02x%02x%02x%02x%02x%02x%02x%02x";
    
    return [[NSString alloc] initWithFormat:fmt,
            result[ 0], result[ 1], result[ 2], result[ 3],
            result[ 4], result[ 5], result[ 6], result[ 7],
            result[ 8], result[ 9], result[10], result[11],
            result[12], result[13], result[14], result[15]];
}

@end
