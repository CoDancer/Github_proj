//
//  ShareButton.h
//  GraduationProject
//
//  Created by onwer on 16/3/11.
//  Copyright © 2016年 onwer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShareButton : UIButton

@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, copy) NSString *iconName;

@property (nonatomic, strong) NSString *platform;
@property (nonatomic, assign) short    shareType;

@end
