//
//  UIImage+Category.h
//  GraduationProject
//
//  Created by CoDancer on 16/1/8.
//  Copyright © 2016年 onwer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Category)

- (void)saveToAlbumWithMetadata:(NSDictionary *)metadata
                customAlbumName:(NSString *)customAlbumName
                completionBlock:(void (^)(void))completionBlock
                   failureBlock:(void (^)(NSError *error))failureBlock;

- (UIImage *)imageByScalingToSize:(CGSize)targetSize;

+ (UIImage *)blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur;

@end
