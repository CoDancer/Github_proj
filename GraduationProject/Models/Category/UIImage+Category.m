//
//  UIImage+Category.m
//  GraduationProject
//
//  Created by CoDancer on 16/1/8.
//  Copyright © 2016年 onwer. All rights reserved.
//

#import "UIImage+Category.h"
#import "NSMutableArray+Category.h"
#import <AssetsLibrary/AssetsLibrary.h>

@implementation UIImage (Category)

- (void)saveToAlbumWithMetadata:(NSDictionary *)metadata
                customAlbumName:(NSString *)customAlbumName
                completionBlock:(void (^)(void))completionBlock
                   failureBlock:(void (^)(NSError *error))failureBlock
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];
        NSMutableArray *groups=[[NSMutableArray alloc]init];
        ALAssetsLibraryGroupsEnumerationResultsBlock listGroupBlock = ^(ALAssetsGroup *group, BOOL *stop)
        {
            if (group)
            {
                [groups addObject:group];
            }
            
            else
            {
                BOOL haveHDRGroup = NO;
                
                for (ALAssetsGroup *gp in groups)
                {
                    NSString *name =[gp valueForProperty:ALAssetsGroupPropertyName];
                    
                    if ([name isEqualToString:customAlbumName])
                    {
                        haveHDRGroup = YES;
                    }
                }
                
                if (!haveHDRGroup)
                {
                    [assetsLibrary addAssetsGroupAlbumWithName:customAlbumName
                                                   resultBlock:^(ALAssetsGroup *group)
                     {
                         [groups addObjectIfNotNil:group];
                         
                     }
                                                  failureBlock:nil];
                    haveHDRGroup = YES;
                }
            }
            
        };
        //创建相簿
        [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAlbum usingBlock:listGroupBlock failureBlock:nil];
        
        [self saveToAlbumWithMetadata:nil imageData:UIImagePNGRepresentation(self) customAlbumName:customAlbumName completionBlock:completionBlock failureBlock:failureBlock];
    });
    
}

- (void)saveToAlbumWithMetadata:(NSDictionary *)metadata
                      imageData:(NSData *)imageData
                customAlbumName:(NSString *)customAlbumName
                completionBlock:(void (^)(void))completionBlock
                   failureBlock:(void (^)(NSError *error))failureBlock
{
    
    ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];
    void (^AddAsset)(ALAssetsLibrary *, NSURL *) = ^(ALAssetsLibrary *assetsLibrary, NSURL *assetURL) {
        [assetsLibrary assetForURL:assetURL resultBlock:^(ALAsset *asset) {
            [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
                
                if ([[group valueForProperty:ALAssetsGroupPropertyName] isEqualToString:customAlbumName]) {
                    [group addAsset:asset];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (completionBlock) {
                            completionBlock();
                        }
                    });
                }
            } failureBlock:^(NSError *error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (failureBlock) {
                        failureBlock(error);
                    }
                });
            }];
        } failureBlock:^(NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (failureBlock) {
                    failureBlock(error);
                }
            });
        }];
    };
    __weak typeof(assetsLibrary) weakassetsLibrary = assetsLibrary;
    [assetsLibrary writeImageDataToSavedPhotosAlbum:imageData metadata:metadata completionBlock:^(NSURL *assetURL, NSError *error) {
        if (customAlbumName) {
            [assetsLibrary addAssetsGroupAlbumWithName:customAlbumName resultBlock:^(ALAssetsGroup *group) {
                if (group) {
                    [weakassetsLibrary assetForURL:assetURL resultBlock:^(ALAsset *asset) {
                        [group addAsset:asset];
                        dispatch_async(dispatch_get_main_queue(), ^{
                            if (completionBlock) {
                                completionBlock();
                            }
                        });
                    } failureBlock:^(NSError *error) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            if (failureBlock) {
                                failureBlock(error);
                            }
                        });
                    }];
                } else {
                    AddAsset(weakassetsLibrary, assetURL);
                }
            } failureBlock:^(NSError *error) {
                AddAsset(weakassetsLibrary, assetURL);
            }];
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (completionBlock) {
                    completionBlock();
                }
            });
        }
    }];
}

- (UIImage *)imageByScalingToSize:(CGSize)targetSize {
    
    UIImage *sourceImage = self;
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    if (CGSizeEqualToSize(imageSize, targetSize) == NO) {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if (widthFactor < heightFactor)
            scaleFactor = widthFactor;
        else
            scaleFactor = heightFactor;
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        // center the image
        if (widthFactor < heightFactor) {
            
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        } else if (widthFactor > heightFactor) {
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    // this is actually the interesting part:
    UIGraphicsBeginImageContext(targetSize);
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    [sourceImage drawInRect:thumbnailRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    if(newImage == nil)
        NSLog(@"could not scale image");
    return newImage ;
}

+ (UIImage *)imageWithCaputureView:(UIView *)view
{
    // 开启位图上下文
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0);
    
    // 获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 把控件上的图层渲染到上下文,layer只能渲染
    [view.layer renderInContext:ctx];
    
    // 生成一张图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    // 关闭上下文
    UIGraphicsEndImageContext();
    
    return image;
}

@end