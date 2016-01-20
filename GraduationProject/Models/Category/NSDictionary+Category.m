//
//  NSDictionary+Category.m
//  GraduationProject
//
//  Created by onwer on 16/1/19.
//  Copyright © 2016年 onwer. All rights reserved.
//

#import "NSDictionary+Category.h"

@implementation NSDictionary (Category)

- (id)objectOrNilForKey:(NSString *)key {
    
    id object = [self objectForKey:key];
    if ([object isKindOfClass:[NSNull class]]) {
        return nil;
    }
    else {
        return object;
    }
}

@end
