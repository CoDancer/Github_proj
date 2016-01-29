//
//  BYBaseVC.m
//  BYHelperCode
//
//  Created by CoDancer on 15/9/5.
//  Copyright (c) 2015年 CoDancer. All rights reserved.
//

#import "BYBaseVC.h"
#import "UIHelper.h"

@interface BYBaseVC ()

@end

@implementation BYBaseVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"f3f3f3"];
    self.navigationItem.leftBarButtonItem = [self leftBarButton];

}

- (UIBarButtonItem *)leftBarButton {
    
    if (self.navigationController.viewControllers.count > 1)
    {
        return [UIHelper navBackBarBtn:nil target:self action:@selector(leftNavButtonClicked:)];
        
    }
    else
        return nil;
}

- (void)leftNavButtonClicked:(UIButton *)button {
    
    [self.navigationController popViewControllerAnimated:YES];
    self.navigationController.delegate = nil;
    [self showBottomView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
