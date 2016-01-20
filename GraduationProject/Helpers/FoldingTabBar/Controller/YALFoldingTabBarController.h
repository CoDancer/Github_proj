// For License please refer to LICENSE file in the root of YALAnimatingTabBarController project

#import <UIKit/UIKit.h>

//view
#import "YALFoldingTabBar.h"
#import "YALTabBarItem.h"

@interface YALFoldingTabBarController : UITabBarController

@property (nonatomic, copy) NSArray *leftBarItems;
@property (nonatomic, copy) NSArray *rightBarItems;
@property (nonatomic, copy) NSArray *centerBarItems;

@property (nonatomic, strong) UIImage *centerButtonImage;

@property (nonatomic, assign) CGFloat tabBarViewHeight;
@property (nonatomic, strong) YALTabBarItem *tabBarItem;

@property (nonatomic, strong) YALFoldingTabBar *tabBarView;

- (id)initWithViewControllers:(NSArray *)vcs;

@end
