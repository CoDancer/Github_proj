//
//  SystemPermission.h
//  GraduationProject
//
//  Created by onwer on 16/3/14.
//  Copyright © 2016年 onwer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SystemPermission : NSObject

+ (BOOL)cameraAuthorized;
+ (BOOL)assetsAuthorized;

@end
