//
//  SecondViewCellModel.m
//  GraduationProject
//
//  Created by CoDancer on 16/1/2.
//  Copyright © 2016年 onwer. All rights reserved.
//

#import "SecondViewCellModel.h"
#import "MJExtension.h"

@implementation SecondViewCellModel

+ (instancetype)cellModelWithDict:(NSDictionary *)dict
{
    SecondViewCellModel *model = [[self alloc] init];
    [model setKeyValues:dict];
    return model;
}

@end
