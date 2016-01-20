//
//  GPUserDefaults.h
//  GraduationProject
//
//  Created by onwer on 15/11/25.
//  Copyright © 2015年 onwer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GPUserDefaults : NSUserDefaults

+ (BOOL)weatherCurrentVersionFirstLaunch;
+ (void)setCurrentVersionAfterLaunch;

@end
