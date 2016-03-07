//
//  SecondInfoCellModel.h
//  GraduationProject
//
//  Created by onwer on 16/1/20.
//  Copyright © 2016年 onwer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SecondInfoCellModel : NSObject

@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSString *contentInfo;

+ (instancetype)cellModelWithDict:(NSDictionary *)dict;

@end
