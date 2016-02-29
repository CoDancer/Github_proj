//
//  NewsDetailModel.m
//  GraduationProject
//
//  Created by onwer on 16/2/29.
//  Copyright © 2016年 onwer. All rights reserved.
//

#import "NewsDetailModel.h"
#import "WZXDateToStrTool.h"

@interface NewsDetailModel ()

@property (nonatomic, strong) NSArray *imageArr;

@end

@implementation NewsDetailModel

+ (instancetype)newsDetailModelWithDict:(NSDictionary *)dict {
    
    NewsDetailModel *model = [NewsDetailModel new];
    model.imageArr = [dict objectOrNilForKey:@"imageurls"];
    if (model.imageArr.count != 0) {
        NSDictionary *imageDic = [model.imageArr firstObject];
        model.imageUrl = [imageDic objectOrNilForKey:@"url"];
    }else {
       model.imageUrl = @"";
    }
    model.titleStr = [dict objectOrNilForKey:@"title"];
    model.sourceStr = [dict objectOrNilForKey:@"source"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date=[formatter dateFromString:[dict objectOrNilForKey:@"pubDate"]];
    NSString * message = [[WZXDateToStrTool tool]dateToStrWithDate:date WithStrType:StrType1];
    model.timeStr = message;
    CGSize lableSize = CGSizeMake(SCREEN_WIDTH - 40, 0);
    CGRect rect=[model.titleStr boundingRectWithSize:lableSize
                                                options:NSStringDrawingUsesLineFragmentOrigin
                                             attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:16.0],NSFontAttributeName, nil] context:nil];
    model.textHeight = rect.size.height;
    return model;
}

- (NSArray *)imageArr {
    
    if (!_imageArr) {
        _imageArr = [NSArray new];
    }
    return _imageArr;
}

@end
