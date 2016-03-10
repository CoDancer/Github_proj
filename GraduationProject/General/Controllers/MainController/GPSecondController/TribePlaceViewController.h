//
//  TribePlaceViewController.h
//  GraduationProject
//
//  Created by onwer on 16/3/8.
//  Copyright © 2016年 onwer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SecondInfoPlaceModel.h"

@interface TribePlaceViewController : UIViewController

@property (nonatomic,strong) NSMutableArray *coordinates;
@property (nonatomic, strong) SecondInfoPlaceModel *placeModel;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSString *subTitle;

@end
