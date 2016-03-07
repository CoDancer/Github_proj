//
//  DoWaysCell.h
//  GraduationProject
//
//  Created by onwer on 16/1/29.
//  Copyright © 2016年 onwer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DoWaysModel.h"

@interface DoWaysCell : UITableViewCell

@property (nonatomic, strong) DoWaysModel *model;

- (CGFloat)getCellHeightWithCellContent:(NSString *)content;

@end
