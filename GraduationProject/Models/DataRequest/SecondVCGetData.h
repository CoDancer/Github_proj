//
//  SecondVCGetData.h
//  GraduationProject
//
//  Created by onwer on 16/1/18.
//  Copyright © 2016年 onwer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SecondVCGetData : NSObject

+ (NSArray *)getGlideImageArrWithSection:(NSInteger)section row:(NSInteger)row;

+ (NSDictionary *)getInfoContentWithSection:(NSInteger)section row:(NSInteger)row;

@end
