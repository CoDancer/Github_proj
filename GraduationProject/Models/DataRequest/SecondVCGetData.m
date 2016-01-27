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

+ (NSDictionary *)getMovieDetailInfoWithRow:(NSInteger)row number:(NSString *)number {
    
    NSDictionary *sectionDic = [[GPSecondVCClient sharedClient]
                       fetchLocalDataWithMovieData];
    NSString *sectionKeyStr = [NSString stringWithFormat:@"section1%d",row];
    NSString *rowKeyStr = [NSString stringWithFormat:@"place%@",number];
    NSDictionary *dic = [sectionDic objectOrNilForKey:sectionKeyStr];
    return [dic objectOrNilForKey:rowKeyStr];
    
}

+ (NSDictionary *)getInfoContentWithSection:(NSInteger)section row:(NSInteger)row {
    
    NSDictionary *dic = [[GPSecondVCClient sharedClient]
                                fetchLocalDataWithBookStoreDeteilInfo];
    NSString *sectionKeyStr = [NSString stringWithFormat:@"section%ld",(long)section];
    NSDictionary *sectionDic = [dic objectOrNilForKey:sectionKeyStr];
    NSString *rowKeyStr = [NSString stringWithFormat:@"section%ld%ld",(long)section,(long)row];
    NSDictionary *rowDic = [sectionDic objectOrNilForKey:rowKeyStr];
    
    if (section == 0) {
        return [self initRowDicWeatherTheInfoWillNilWithRowDic:rowDic fromDic:dic];
    }else if (section == 1) {
        return rowDic;
    }
    return nil;
}

+ (NSDictionary *)initRowDicWeatherTheInfoWillNilWithRowDic:(NSDictionary *)dic fromDic:(NSDictionary *)fromDic {
    
    if (dic == nil) {
        dic = fromDic[@"section0"][@"section00"];
    }
    NSMutableDictionary *muDic = [dic mutableCopy];
    if (dic[@"booksInfo"]  == nil ||
        dic[@"glideImages"] == nil ||
        dic[@"storeInfo"] == nil) {
        if (dic[@"booksInfo"] == nil) {
            muDic[@"booksInfo"] = fromDic[@"section0"][@"section00"][@"booksInfo"];
        }else if (dic[@"glideImages"] == nil) {
            muDic[@"glideImages"] = @[@"http://img.chengmi.com/cm/3bc2198c-c909-4698-91b2-88e00c5dff2a",
                                      @"http://img.chengmi.com/cm/dba3fb4d-b5ef-4218-b976-52cba4538381",
                                      @"http://img.chengmi.com/cm/934ad87f-400c-452e-9427-12a03fe9cf6e"];
        }else if (dic[@"storeInfo"] == nil) {
            muDic[@"storeInfo"] = fromDic[@"section0"][@"section00"][@"storeInfo"];
        }
    }
    return muDic;
}

+ (NSDictionary *)getBookDetailInfoWithRow:(NSString *)row number:(NSString *)number {
    
    NSDictionary *dic = [[GPSecondVCClient sharedClient]
                         fetchLocalDataWithBookDetailInfo];
    NSString *sectionKeyStr = [NSString stringWithFormat:@"section0%@",row];
    NSDictionary *bookDic = [dic objectOrNilForKey:sectionKeyStr];
    NSString *rowKeyStr = [NSString stringWithFormat:@"place%@",number];
    NSDictionary *rowDic = [bookDic objectOrNilForKey:rowKeyStr];
    return [self initRowDicWeatherTheBookInfoWillNilWithRowDic:rowDic fromDic:bookDic];
}

+ (NSDictionary *)initRowDicWeatherTheBookInfoWillNilWithRowDic:(NSDictionary *)dic
                                                        fromDic:(NSDictionary *)fromDic {

    if (dic == nil) {
        dic = fromDic[@"section01"];
    }
    NSMutableDictionary *muDic = [dic mutableCopy];
    
    return muDic;
}

@end
