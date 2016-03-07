//
//  GroomModel.m
//  GraduationProject
//
//  Created by CoDancer on 16/3/6.
//  Copyright © 2016年 onwer. All rights reserved.
//

#import "GroomModel.h"
#import "GPSecondVCClient.h"

@implementation GroomModel

+ (instancetype)groomModelWithDict:(NSDictionary *)dict {
    
    GroomModel *model = [GroomModel new];
    model.sectionStr = [dict objectOrNilForKey:@"section"];
    model.rowStr = [dict objectForKey:@"row"];
    NSArray *array = [[GPSecondVCClient sharedClient] fetchLocalDataWithHomePlist];
    NSDictionary *dic = [array objectAtIndex:[model.sectionStr integerValue]];
    NSDictionary *imageDic = [[dic objectOrNilForKey:@"body"] objectAtIndex:[model.rowStr integerValue]];
    model.imageUrl = [imageDic objectOrNilForKey:@"imageURL"];
    return model;
}

@end
