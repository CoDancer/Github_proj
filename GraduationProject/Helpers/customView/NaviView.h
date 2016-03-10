//
//  NaviView.h
//  GraduationProject
//
//  Created by onwer on 16/3/8.
//  Copyright © 2016年 onwer. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BackBlock)();

@interface NaviView : UIView

@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) UIColor *BGColor;
@property (nonatomic, strong) BackBlock backBlock;

@end
