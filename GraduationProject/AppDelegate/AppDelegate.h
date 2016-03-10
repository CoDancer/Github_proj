//
//  AppDelegate.h
//  GraduationProject
//
//  Created by onwer on 15/11/25.
//  Copyright © 2015年 onwer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Base/BMKBaseComponent.h>

@interface AppDelegate : NSObject <UIApplicationDelegate>{
    BMKMapManager *_mapManager;
}

@property (strong, nonatomic) UIWindow *window;



@end

