//
//  NSArray+Category.m
//  GraduationProject
//
//  Created by CoDancer on 16/1/2.
//  Copyright © 2016年 onwer. All rights reserved.
//

#import "NSArray+Category.h"

@implementation NSArray (Category)

-(id)objectOrNilAtIndex:(NSUInteger)i {
    if (i < [self count]) {
        return [self objectAtIndex:i];
    }
    return nil;
}

@end
