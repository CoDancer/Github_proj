//
//  DisperseBtn.h
//  GraduationProject
//
//  Created by onwer on 16/3/15.
//  Copyright © 2016年 onwer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DisperseBtn : UIView

//边界
@property (assign, nonatomic) CGRect borderRect;
@property (strong, nonatomic) UIImage *closeImage;
@property (strong, nonatomic) UIImage *openImage;
@property (nonatomic ,copy)NSArray *btns;
//回收按钮
-(void)recoverBotton;

@end
