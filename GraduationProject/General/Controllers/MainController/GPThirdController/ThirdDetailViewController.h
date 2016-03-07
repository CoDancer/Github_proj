//
//  ThirdDetailViewController.h
//  GraduationProject
//
//  Created by onwer on 16/1/28.
//  Copyright © 2016年 onwer. All rights reserved.
//

#import "BYBaseVC.h"
#import "ThirdWaterViewModel.h"

@interface ThirdDetailViewController : BYBaseVC<UIViewControllerTransitioningDelegate, UINavigationControllerDelegate, UITabBarControllerDelegate>

@property (nonatomic, strong) NSArray *waysArr;
@property (nonatomic, strong) NSArray *ingredientsArr;
@property (nonatomic, strong) ThirdWaterViewModel *model;

@end
