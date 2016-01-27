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
@property (nonatomic, strong) SecondViewCellModel *cellModel;

@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, strong) NSArray *booksArr;
@property (nonatomic, strong) NSArray *infoCellArr;
@property (nonatomic, strong) NSDictionary *placeDic;

@property (nonatomic, assign) BOOL isBottomScro;
@property (nonatomic, assign) NSInteger whichRow;

@end
