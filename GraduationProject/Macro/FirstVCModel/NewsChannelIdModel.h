//
//  NewsChannelIdModel.h
//  GraduationProject
//
//  Created by onwer on 16/2/20.
//  Copyright © 2016年 onwer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsChannelIdModel : NSObject

@property (nonatomic, strong) NSArray *channelIdArray;
@property (nonatomic, strong) NSArray *nameArray;

- (NSDictionary *)getDic;

@end
