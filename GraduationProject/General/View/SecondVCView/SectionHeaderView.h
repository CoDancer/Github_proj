//
//  SectionHeaderView.h
//  GraduationProject
//
//  Created by CoDancer on 16/1/3.
//  Copyright © 2016年 onwer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SecondViewModel.h"

@class SectionHeaderView;

@protocol SectionHeaderViewDelegate <NSObject>

- (void)sectionHeaderViewDidTap:(SectionHeaderView *)view;

@end

@interface SectionHeaderView : UIView

@property (nonatomic, strong) SecondViewModel *homeModel;
@property (nonatomic, weak) id<SectionHeaderViewDelegate> headerDelegate;

@end
