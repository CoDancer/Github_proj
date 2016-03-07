//
//  SecondInfoPlaceModel.h
//  GraduationProject
//
//  Created by onwer on 16/1/26.
//  Copyright © 2016年 onwer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SecondInfoPlaceModel : NSObject

@property (nonatomic, strong) NSString *placeName;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSString *longitude;
@property (nonatomic, strong) NSString *latitude;

+ (instancetype)viewModelWithDict:(NSDictionary *)dict;

@end
