//
//  GPSecondDetailViewController.h
//  GraduationProject
//
//  Created by CoDancer on 16/1/2.
//  Copyright © 2016年 onwer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SecondViewCellModel.h"
#import "BookListModel.h"

@interface GPSecondDetailViewController : UIViewController<UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) BookListModel *bookModel;
@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, strong) SecondViewCellModel *cellModel;

@end
