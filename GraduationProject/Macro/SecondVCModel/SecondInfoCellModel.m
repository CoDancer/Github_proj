//
//  SecondInfoCellModel.m
//  GraduationProject
//
//  Created by onwer on 16/1/20.
//  Copyright © 2016年 onwer. All rights reserved.
//

#import "SecondInfoCellModel.h"
#import "MJExtension.h"

@implementation SecondInfoCellModel

+ (instancetype)cellModelWithDict:(NSDictionary *)dict {
    
    SecondInfoCellModel *model = [[self alloc] init];
    [model setKeyValues:dict];
    return model;
}

@end
