//
//  GPPrepareLogin.m
//  GraduationProject
//
//  Created by onwer on 15/11/25.
//  Copyright © 2015年 onwer. All rights reserved.
//

#import "GPPrepareLogin.h"
#import "AppDelegate.h"
#import "GPUserDefaults.h"
#import "GPFirstLaunchViewController.h"
#import "GPSigninViewController.h"
#import "YALFoldingTabBarController.h"
#import "YALTabBarItem.h"
//helpers
#import "YALAnimatingTabBarConstants.h"

#import "GPFirstController.h"
#import "GPSecondController.h"
#import "GPThirdController.h"

@interface GPPrepareLogin()


@end

@implementation GPPrepareLogin

+ (void)run {
    id<UIApplicationDelegate> appDelegate = [UIApplication sharedApplication].delegate;
    appDelegate.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    appDelegate.window.backgroundColor = [UIColor blackColor];
    
    __weak typeof(self) weakSelf = self;
    if ([GPUserDefaults weatherCurrentVersionFirstLaunch]) {
        GPFirstLaunchViewController *fisrtLaunchController = [GPFirstLaunchViewController new];
        fisrtLaunchController.nextBlock = ^(){
            [weakSelf showMainTabBarViewController];
        };
        UIWindow *window = [UIApplication sharedApplication].delegate.window;
        window.rootViewController = fisrtLaunchController;
        [window makeKeyAndVisible];
        [GPUserDefaults setCurrentVersionAfterLaunch];
    }else{
        [self showMainTabBarViewController];
    }
}

+ (void)showLoginViewController {
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    window.rootViewController = GPNavRounded([GPSigninViewController new]);
    [window makeKeyAndVisible];
}

+ (void)showMainTabBarViewController {
    
    YALFoldingTabBarController *tabBarController = [[YALFoldingTabBarController alloc]
                                                        initWithViewControllers:[self getRootViewController]];

    //prepare leftBarItems
    YALTabBarItem *item1                         = [[YALTabBarItem alloc] initWithItemImage:[UIImage imageNamed:@"nearby_icon"]
                                                      leftItemImage:nil
                                                     rightItemImage:nil];


//    YALTabBarItem *item2                         = [[YALTabBarItem alloc] initWithItemImage:[UIImage imageNamed:@"profile_icon"]
//                                                      leftItemImage:[UIImage imageNamed:@"edit_icon"]
//                                                     rightItemImage:nil];
//
    tabBarController.leftBarItems                = @[item1];

    //prepare rightBarItems
    YALTabBarItem *item3                         = [[YALTabBarItem alloc] initWithItemImage:[UIImage imageNamed:@"meishi"]
                                                      leftItemImage:nil
                                                     rightItemImage:nil];


    YALTabBarItem *item4                         = [[YALTabBarItem alloc] initWithItemImage:[UIImage imageNamed:@"plus_icon"]
                                                      leftItemImage:nil
                                                     rightItemImage:[UIImage imageNamed:@"profile_icon"]];
    
    tabBarController.rightBarItems = @[item3];
    tabBarController.centerBarItems = @[item4];
    
    tabBarController.centerButtonImage = [UIImage imageNamed:@"plus_icon"];
    
    tabBarController.selectedIndex = 1;
    
    //customize tabBarView
    tabBarController.tabBarView.extraTabBarItemHeight = YALExtraTabBarItemsDefaultHeight;
    tabBarController.tabBarView.offsetForExtraTabBarItems = YALForExtraTabBarItemsDefaultOffset;
    tabBarController.tabBarView.backgroundColor = [UIColor colorWithRed:94.0/255.0 green:91.0/255.0 blue:149.0/255.0 alpha:1];
    tabBarController.tabBarView.tabBarColor = [UIColor colorWithRed:72.0/255.0 green:211.0/255.0 blue:178.0/255.0 alpha:1];
    tabBarController.tabBarViewHeight = YALTabBarViewDefaultHeight;
    tabBarController.tabBarView.tabBarViewEdgeInsets = YALTabBarViewHDefaultEdgeInsets;
    tabBarController.tabBarView.tabBarItemsEdgeInsets = YALTabBarViewItemsDefaultEdgeInsets;
    
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    window.backgroundColor = [UIColor whiteColor];
    window.rootViewController = tabBarController;
    [window makeKeyAndVisible];
}


+ (NSArray *)getRootViewController{
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    window.backgroundColor = [UIColor whiteColor];
    
    GPFirstController *firstViewController = [[GPFirstController alloc] init];
    UINavigationController *oneNavigationController = [[UINavigationController alloc] initWithRootViewController:firstViewController];
    oneNavigationController.navigationBar.barStyle = UIBarStyleDefault;
    
    
    GPSecondController *secondViewController = [[GPSecondController alloc] init];
    UINavigationController *secondNavigationController = [[UINavigationController alloc] initWithRootViewController:secondViewController];
    [secondNavigationController setNavigationBarHidden:YES];
    
    GPThirdController *thirdViewController = [[GPThirdController alloc] init];
    UINavigationController *thirdNavigationController = [[UINavigationController alloc] initWithRootViewController:thirdViewController];
    thirdNavigationController.navigationBar.barStyle = UIBarStyleDefault;
    
    NSArray *ctrlArr = [NSArray arrayWithObjects:oneNavigationController,secondNavigationController,thirdNavigationController,nil];
    
    return ctrlArr;
}

@end
