//
//  SecondInfoPlaceModel.m
//  GraduationProject
//
//  Created by onwer on 16/1/26.
//  Copyright © 2016年 onwer. All rights reserved.
//

#import "SecondInfoPlaceModel.h"
#import "MJExtension.h"

@implementation SecondInfoPlaceModel

+ (instancetype)viewModelWithDict:(NSDictionary *)dict {
    
    SecondInfoPlaceModel *model = [[self alloc] init];
    [model setKeyValues:dict];
    return model;
}

@end
