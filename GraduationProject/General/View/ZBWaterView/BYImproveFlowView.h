//
//  BYImproveFlowView.h
//  BYHelperCode
//
//  Created by onwer on 15/10/28.
//  Copyright © 2015年 CoDancer. All rights reserved.
//

#import "ZBFlowView.h"
#import "ThirdWaterViewModel.h"

@interface BYImproveFlowView : ZBFlowView

@property (nonatomic, strong) ThirdWaterViewModel *model;

- (void)setImage:(UIImage *)image model:(ThirdWaterViewModel *)model;

@end
