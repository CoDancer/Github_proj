//
//  SecondVCGetData.h
//  GraduationProject
//
//  Created by onwer on 16/1/18.
//  Copyright © 2016年 onwer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SecondVCGetData : NSObject

+ (NSDictionary *)getMovieDetailInfoWithRow:(NSInteger)row number:(NSString *)number;

+ (NSDictionary *)getInfoContentWithSection:(NSInteger)section row:(NSInteger)row;

+ (NSDictionary *)getBookDetailInfoWithRow:(NSString *)row number:(NSString *)number;

@end
