//
//  SystemPermission.m
//  GraduationProject
//
//  Created by onwer on 16/3/14.
//  Copyright © 2016年 onwer. All rights reserved.
//

#import "SystemPermission.h"
#import <AVFoundation/AVFoundation.h>
#import <CoreLocation/CoreLocation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "GPAlertView.h"

@implementation SystemPermission

+ (BOOL)cameraAuthorized {
    
    if ([UIDevice currentDevice].systemVersion.floatValue >= 7.0) {
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied)
        {
            [[[GPAlertView alloc] initWithTitle:@"需要访问您的相机。\n请启用设置-隐私-相机" message:nil buttons:@[@"确定"]] show];
            return NO;
        }
    }
    return YES;
}

+ (BOOL)assetsAuthorized {
    // iOS 6 and later
    ALAuthorizationStatus status = [ALAssetsLibrary authorizationStatus];
    if (status == ALAuthorizationStatusDenied || status == ALAuthorizationStatusRestricted) {
        [[[GPAlertView alloc] initWithTitle:@"需要访问您的相机。\n请启用设置-隐私-相机" message:nil buttons:@[@"确定"]] show];
        return NO;
    }
    return YES;
}

@end
