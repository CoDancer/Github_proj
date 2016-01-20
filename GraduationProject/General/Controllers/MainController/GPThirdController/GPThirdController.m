//
//  GPThirdController.m
//  GraduationProject
//
//  Created by onwer on 15/11/26.
//  Copyright © 2015年 onwer. All rights reserved.
//

#import "GPThirdController.h"
#import "GPPrepareLogin.h"
#import "YALTabBarInteracting.h"
#import "GPUserCenterViewController.h"

@interface GPThirdController()<YALTabBarInteracting>

@property (nonatomic, weak) id<YALTabBarInteracting> delegate;

@end

@implementation GPThirdController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"馔玉";
    [self configView];
    self.delegate = self;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
- (void)configView {
    
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [leftBtn setImage:[UIImage imageNamed:@"food"] forState:UIControlStateNormal];
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftBarItem;

}
- (void)extraRightItemDidPressed {
    GPUserCenterViewController *vc = [GPUserCenterViewController new];
    [vc dismissBottomView];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)rightBarItemDidTap {
    [GPPrepareLogin showLoginViewController];
}

@end
