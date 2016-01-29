//
//  ThirdWaterViewModel.h
//  GraduationProject
//
//  Created by onwer on 16/1/27.
//  Copyright © 2016年 onwer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ThirdWaterViewModel : NSObject

@property (nonatomic, strong) NSString *titleName;
@property (nonatomic, strong) NSString *numberId;
@property (nonatomic, strong) NSString *imageURL;
@property (nonatomic, strong) NSString *detailName;

+ (instancetype)foodListModelWithDict:(NSDictionary *)dict;

@end
