//
//  GPFirstLaunchView.h
//  GraduationProject
//
//  Created by onwer on 15/11/25.
//  Copyright © 2015年 onwer. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^dismissBlock)();
@interface GPFirstLaunchView : UIView

@property (nonatomic, strong) dismissBlock dismissBlock;

@end
