//
//  SecondInfoCell.h
//  GraduationProject
//
//  Created by onwer on 16/1/20.
//  Copyright © 2016年 onwer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SecondInfoCellModel.h"

typedef void(^getImageBlock) (UIImage *image);

@interface SecondInfoCell : UITableViewCell

@property (nonatomic, strong) SecondInfoCellModel *cellModel;
@property (nonatomic, strong) getImageBlock imageBlock;
@property (nonatomic, assign) BOOL flag;


@property (nonatomic, assign) CGFloat cellHeight;

@end
