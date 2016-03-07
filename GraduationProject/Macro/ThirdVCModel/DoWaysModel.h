//
//  DoWaysModel.h
//  GraduationProject
//
//  Created by onwer on 16/1/29.
//  Copyright © 2016年 onwer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DoWaysModel : NSObject

@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSString *howDo;

+ (instancetype)doWaysModelWithDict:(NSDictionary *)dict;

@end
