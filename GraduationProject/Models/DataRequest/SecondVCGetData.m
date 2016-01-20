//
//  SecondVCGetData.m
//  GraduationProject
//
//  Created by onwer on 16/1/18.
//  Copyright © 2016年 onwer. All rights reserved.
//

#import "SecondVCGetData.h"
#import "GPSecondVCClient.h"
#import "MJExtension.h"

@implementation SecondVCGetData

+ (NSArray *)getGlideImageArrWithSection:(NSInteger)section row:(NSInteger)row {
    
    NSDictionary *sectionDic = [[GPSecondVCClient sharedClient]
                       fetchLocalDataWithBookStoreGlideImage];
    NSString *sectionKeyStr = [NSString stringWithFormat:@"item%d",section];
    NSString *rowKeyStr = [NSString stringWithFormat:@"section%d%d",section,row];
    NSDictionary *dic = [sectionDic objectOrNilForKey:sectionKeyStr];
    if (dic == nil) {
        return @[@"http://img.chengmi.com/cm/3bc2198c-c909-4698-91b2-88e00c5dff2a",
                 @"http://img.chengmi.com/cm/dba3fb4d-b5ef-4218-b976-52cba4538381",
                 @"http://img.chengmi.com/cm/934ad87f-400c-452e-9427-12a03fe9cf6e"];
    }else {
        return [dic objectOrNilForKey:rowKeyStr];
    }
    
}

@end
