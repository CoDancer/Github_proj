//
//  UserLogoView.h
//  GraduationProject
//
//  Created by onwer on 16/3/14.
//  Copyright © 2016年 onwer. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^POPVCBlock)();
typedef void(^TapHeaderView)();

@interface UserLogoView : UIView

@property (nonatomic, strong) POPVCBlock popBlock;
@property (nonatomic, strong) TapHeaderView tapBlack;
@property (nonatomic, assign) BOOL isModifyInfo;

@end
