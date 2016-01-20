//
//  GPFirstLaunchViewController.m
//  GraduationProject
//
//  Created by onwer on 15/11/25.
//  Copyright © 2015年 onwer. All rights reserved.
//

#import "GPFirstLaunchViewController.h"
#import "GPFirstLaunchView.h"

@interface GPFirstLaunchViewController ()

@end

@implementation GPFirstLaunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    GPFirstLaunchView *view = [GPFirstLaunchView new];
    __weak typeof(self) weakSelf = self;
    view.dismissBlock = ^(){
        if (weakSelf.nextBlock) {
            weakSelf.nextBlock();
        }
    };
    [self.view addSubview:view];
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
