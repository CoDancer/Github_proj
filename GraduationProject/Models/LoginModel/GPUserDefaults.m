//
//  GPUserDefaults.m
//  GraduationProject
//
//  Created by onwer on 15/11/25.
//  Copyright © 2015年 onwer. All rights reserved.
//

#import "GPUserDefaults.h"

@implementation GPUserDefaults

+ (BOOL)weatherCurrentVersionFirstLaunch{
    if ([[GPUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"versionFirstLaunch%@",[self Version]]] == nil ||
        [[GPUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"versionFirstLaunch%@",[self Version]]] == [NSNull null]){
        return YES;
    }
    return NO;
}
+ (NSString *)Version
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}
+ (void)setCurrentVersionAfterLaunch{
    [[GPUserDefaults standardUserDefaults] setObject:@(NO) forKey:[NSString stringWithFormat:@"versionFirstLaunch%@",[self Version]]];
}

@end
