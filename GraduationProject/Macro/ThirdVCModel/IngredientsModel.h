//
//  IngredientsModel.h
//  GraduationProject
//
//  Created by onwer on 16/1/28.
//  Copyright © 2016年 onwer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IngredientsModel : NSObject

@property (nonatomic, strong) NSString *howMuch;
@property (nonatomic, strong) NSString *whatFood;

+ (instancetype)ingredientModelWithDict:(NSDictionary *)dict;

@end
