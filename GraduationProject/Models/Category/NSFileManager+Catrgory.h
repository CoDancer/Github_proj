//
//  NSFileManager+Catrgory.h
//  GraduationProject
//
//  Created by onwer on 16/3/14.
//  Copyright © 2016年 onwer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (Catrgory)

- (NSString *)cacheDirectory;
- (BOOL)createFileAtPath:(NSString *)path contents:(NSData *)data intermediate:(BOOL)intermediate;

@end
