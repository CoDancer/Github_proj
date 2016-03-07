//
//  BookListModel.m
//  PopViewController
//
//  Created by onwer on 16/1/12.
//  Copyright © 2016年 onwer. All rights reserved.
//

#import "BookListModel.h"
#import "MJExtension.h"

@implementation BookListModel

+ (instancetype)bookListModelWithDict:(NSDictionary *)dict {
    
    BookListModel *model = [BookListModel new];
    [model setKeyValues:dict];
    return model;
}

@end
