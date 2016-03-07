//
//  GroomView.h
//  GraduationProject
//
//  Created by onwer on 16/3/2.
//  Copyright © 2016年 onwer. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ActionBlock)(NSInteger idx);

@interface GroomView : UIView

@property (nonatomic, strong) ActionBlock actionBlock;

- (instancetype)initWithFrame:(CGRect )frame ModelArray:(NSArray *)array;

@end
