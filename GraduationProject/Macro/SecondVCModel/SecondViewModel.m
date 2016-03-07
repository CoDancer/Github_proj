//
//  SecondViewModel.m
//  GraduationProject
//
//  Created by CoDancer on 16/1/2.
//  Copyright © 2016年 onwer. All rights reserved.
//

#import "SecondViewModel.h"
#import "MJExtension.h"

@implementation SecondViewModel

+ (instancetype)homeModelWithDict:(NSDictionary *)dict
{
    //便利构造方法
    SecondViewModel *home = [[SecondViewModel alloc] init];
    
    [home setKeyValues:dict];
    
    return home;
}

@end
