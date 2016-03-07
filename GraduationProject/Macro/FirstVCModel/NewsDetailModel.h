//
//  NewsDetailModel.h
//  GraduationProject
//
//  Created by onwer on 16/2/29.
//  Copyright © 2016年 onwer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsDetailModel : NSObject

@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSString *titleStr;
@property (nonatomic, strong) NSString *sourceStr;
@property (nonatomic, strong) NSString *timeStr;
@property (nonatomic, assign) NSInteger textHeight;
@property (nonatomic, strong) NSString *linkStr;

+ (instancetype)newsDetailModelWithDict:(NSDictionary *)dict;

@end
