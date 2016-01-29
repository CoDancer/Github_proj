//
//  ThirdWaterViewModel.m
//  GraduationProject
//
//  Created by onwer on 16/1/27.
//  Copyright © 2016年 onwer. All rights reserved.
//

#import "ThirdWaterViewModel.h"
#import "MJExtension.h"

@implementation ThirdWaterViewModel

+ (instancetype)foodListModelWithDict:(NSDictionary *)dict {
    
    ThirdWaterViewModel *model = [ThirdWaterViewModel new];
    [model setKeyValues:dict];
    return model;
}

@end
