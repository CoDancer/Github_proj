//
//  EachItemDetailViewController.h
//  GraduationProject
//
//  Created by onwer on 16/1/19.
//  Copyright © 2016年 onwer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookListModel.h"
#import "SecondViewCellModel.h"

@interface EachItemDetailViewController : UIViewController

@property (nonatomic, strong) BookListModel *bookModel;
@property (nonatomic, strong) SecondViewCellModel *itemModel;
@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, strong) NSArray *infoCellArr;

@end
