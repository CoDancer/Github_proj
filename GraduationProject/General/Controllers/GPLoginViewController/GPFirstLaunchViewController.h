//
//  GPFirstLaunchViewController.h
//  GraduationProject
//
//  Created by onwer on 15/11/25.
//  Copyright © 2015年 onwer. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^NextStepBlock)();
@interface GPFirstLaunchViewController : UIViewController

@property (nonatomic, strong) NextStepBlock nextBlock;

@end
