//
//  SecondViewCellModel.h
//  GraduationProject
//
//  Created by CoDancer on 16/1/2.
//  Copyright © 2016年 onwer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SecondViewCellModel : NSObject

/** cellTitle */
@property (nonatomic, copy) NSString *section_title;
/** 图片地址 */
@property (nonatomic, copy) NSString *imageURL;
/** 星级 */
@property (nonatomic, copy) NSString *fav_count;
/** 底部名称 */
@property (nonatomic, copy) NSString *poi_name;

@property (nonatomic, strong) NSString *itemId;

+ (instancetype)cellModelWithDict:(NSDictionary *)dict;

@end
