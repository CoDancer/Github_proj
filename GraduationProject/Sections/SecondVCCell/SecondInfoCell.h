//
//  SecondInfoCell.h
//  GraduationProject
//
//  Created by onwer on 16/1/20.
//  Copyright © 2016年 onwer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SecondInfoCellModel.h"

typedef void(^getImageBlock) (UIImageView *imageView);

@interface SecondInfoCell : UITableViewCell

@property (nonatomic, strong) SecondInfoCellModel *cellModel;
@property (nonatomic, strong) getImageBlock imageBlock;


- (void)setCellImage:(UIImage *)image contentInfo:(NSString *)content;

@end
