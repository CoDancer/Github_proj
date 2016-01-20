//
//  NSMutableArray+Category.m
//  GraduationProject
//
//  Created by CoDancer on 16/1/8.
//  Copyright © 2016年 onwer. All rights reserved.
//

#import "NSMutableArray+Category.h"

@implementation NSMutableArray (Category)

-(id)addObjectIfNotNil:(id)object {
    if (object) {
        [self addObject:object];
        return object;
    }
    return nil;
}

@end
