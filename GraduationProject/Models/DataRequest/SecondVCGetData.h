//
//  SecondVCGetData.h
//  GraduationProject
//
//  Created by onwer on 16/1/18.
//  Copyright © 2016年 onwer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SecondVCGetData : NSObject
//获取电影的详细信息
+ (NSDictionary *)getMovieDetailInfoWithRow:(NSInteger)row number:(NSString *)number;
//获取书店，影院等信息
+ (NSDictionary *)getInfoContentWithSection:(NSInteger)section row:(NSInteger)row;
//获取书的详细信息
+ (NSDictionary *)getBookDetailInfoWithRow:(NSString *)row number:(NSString *)number;

+ (NSArray *)getTasteFoodContent;

@end
