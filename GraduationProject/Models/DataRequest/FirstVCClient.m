//
//  FirstVCClient.m
//  GraduationProject
//
//  Created by onwer on 16/3/1.
//  Copyright © 2016年 onwer. All rights reserved.
//

#import "FirstVCClient.h"

@implementation FirstVCClient

- (NSDictionary *)fetchLocalDataWithNewsSlidePlist {
    
    return [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle]
                                                       pathForResource:@"NewsSlide"
                                                       ofType:@"plist"]];
}

@end
