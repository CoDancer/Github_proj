//
//  BookListModel.h
//  PopViewController
//
//  Created by onwer on 16/1/12.
//  Copyright © 2016年 onwer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BookListModel : NSObject

@property (nonatomic, copy) NSString *author;
/** 图片地址 */
@property (nonatomic, copy) NSString *imageURL;
/** 浏览次数 */
@property (nonatomic, copy) NSString *fav_count;
/** 底部名称 */
@property (nonatomic, copy) NSString *book_name;

+ (instancetype)bookListModelWithDict:(NSDictionary *)dict;

@end
