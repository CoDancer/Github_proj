//
//  GroomModel.h
//  GraduationProject
//
//  Created by CoDancer on 16/3/6.
//  Copyright © 2016年 onwer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GroomModel : NSObject

@property (nonatomic, strong) NSString *sectionStr;
@property (nonatomic, strong) NSString *rowStr;
@property (nonatomic, strong) NSString *imageUrl;

+ (instancetype)groomModelWithDict:(NSDictionary *)dict;

@end
