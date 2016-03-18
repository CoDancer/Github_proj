//
//  NSFileManager+Catrgory.m
//  GraduationProject
//
//  Created by onwer on 16/3/14.
//  Copyright © 2016年 onwer. All rights reserved.
//

#import "NSFileManager+Catrgory.h"

@implementation NSFileManager (Catrgory)

- (NSString *)cacheDirectory {
    
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    return paths[0];
}

- (BOOL)createFileAtPath:(NSString *)path contents:(NSData *)data intermediate:(BOOL)intermediate {
    
    if (path.length == 0) return NO;
    NSString *dirPath = [path stringByDeletingLastPathComponent];
    if (intermediate && [self fileExistsAtPath:dirPath] == NO) {
        [self createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    BOOL success = [self createFileAtPath:path contents:data attributes:nil];
    //[self addSkipBackupAttributeToItemAtURL:[NSURL fileURLWithPath:path]];
    return success;
}

//- (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)url {
//    
//    if (&NSURLIsExcludedFromBackupKey == nil) { // for iOS <= 5.0.1
//        const char* filePath = [[url path] fileSystemRepresentation];
//        
//        const char* attrName = "com.apple.MobileBackup";
//        u_int8_t attrValue = 1;
//        
//        int result = setxattr(filePath, attrName, &attrValue, sizeof(attrValue), 0, 0);
//        return result == 0;
//    }
//    else { // For iOS >= 5.1
//        NSError *error = nil;
//        [url setResourceValue:[NSNumber numberWithBool:YES] forKey:NSURLIsExcludedFromBackupKey error:&error];
//        return error == nil;
//    }
//}

@end
