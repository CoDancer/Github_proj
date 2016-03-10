//
//  BYGlobal.h
//  BYHelperCode
//
//  Created by CoDancer on 15/9/4.
//  Copyright (c) 2015年 CoDancer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "NSDictionary+Category.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件

#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件

#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件

#import <BaiduMapAPI_Cloud/BMKCloudSearchComponent.h>//引入云检索功能所有的头文件

#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件

#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>//引入计算工具所有的头文件

#import <BaiduMapAPI_Radar/BMKRadarComponent.h>//引入周边雷达功能所有的头文件

#import <BaiduMapAPI_Map/BMKMapView.h>//只引入所需的单个头文件


#define MAINSCREEN [UIScreen mainScreen].bounds
//当前设备的屏幕宽度
#define SCREEN_WIDTH   [[UIScreen mainScreen] bounds].size.width
//当前设备的屏幕高度
#define SCREEN_HEIGHT   [[UIScreen mainScreen] bounds].size.height
#define MainColor [UIColor colorWithRed:72.0/255.0 green:211.0/255.0 blue:178.0/255.0 alpha:1]
#define RGB(r,g,b) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1.0]
#define COLOR_LINE RGB(241, 241, 241)

#define kTabBarHeight 53
#define IMAGEWIDTH 120
#define IMAGEHEIGHT 160

#define k_IOS_Scale [[UIScreen mainScreen] bounds].size.width/320
#define UserDefaults [NSUserDefaults standardUserDefaults]

#define URL_ADD @"http://test.xbcx.com.cn/qiuchangapi"


@protocol BYGlobalDelegate;

@interface GPGlobal : NSObject

@property (nonatomic, weak) id<BYGlobalDelegate> globalDelegate;

AppDelegate *FindAppDelegate();

@end

@protocol BYGlobalDelegate <NSObject>


@end
