//
//  IngredientsModel.m
//  GraduationProject
//
//  Created by onwer on 16/1/28.
//  Copyright © 2016年 onwer. All rights reserved.
//

#import "IngredientsModel.h"
#import "MJExtension.h"

@implementation IngredientsModel

+ (instancetype)ingredientModelWithDict:(NSDictionary *)dict {
    
    IngredientsModel *model = [IngredientsModel new];
    [model setKeyValues:dict];
    return model;
}

@end
