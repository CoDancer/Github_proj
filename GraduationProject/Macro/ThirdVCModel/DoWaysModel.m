//
//  DoWaysModel.m
//  GraduationProject
//
//  Created by onwer on 16/1/29.
//  Copyright © 2016年 onwer. All rights reserved.
//

#import "DoWaysModel.h"
#import "MJExtension.h"

@implementation DoWaysModel

+ (instancetype)doWaysModelWithDict:(NSDictionary *)dict {
    
    DoWaysModel *model = [DoWaysModel new];
    [model setKeyValues:dict];
    return model;
}

@end
