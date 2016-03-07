//
//  FirstVCGetData.m
//  GraduationProject
//
//  Created by onwer on 16/2/1.
//  Copyright © 2016年 onwer. All rights reserved.
//

#import "FirstVCGetData.h"
#import "FirstVCClient.h"

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

+ (NSArray *)getNewsSlideImagesWithRow:(NSInteger)row {
    
    NSDictionary *dic = [[FirstVCClient sharedClient]
                         fetchLocalDataWithNewsSlidePlist];
    NSString *keyStr = [NSString stringWithFormat:@"row%ld",(long)row+1];
    return [[dic objectOrNilForKey:keyStr] objectOrNilForKey:@"slideImages"];
}

@end
