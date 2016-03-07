//
//  GPSecondDetailListVC.h
//  GraduationProject
//
//  Created by onwer on 16/1/19.
//  Copyright © 2016年 onwer. All rights reserved.
//

#import "BYBaseVC.h"
#import "SecondViewModel.h"

@interface GPSecondDetailListVC : BYBaseVC

@property (nonatomic, strong) SecondViewModel *listModel;
@property (nonatomic, strong) NSString *sectionId;

@end
