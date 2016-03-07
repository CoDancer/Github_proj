//
//  BYInputField.h
//  BYHelperCode
//
//  Created by onwer on 15/10/19.
//  Copyright © 2015年 CoDancer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GPInputField : UIView
@property (nonatomic, strong, readonly) UITextField *inputField;
@property (nonatomic, strong) UIImage *leftImage;
@property (nonatomic, strong) NSString *placeHolder;
@property (nonatomic) NSInteger textFont;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, assign) UIKeyboardType keyboardType;
@property (nonatomic, assign) BOOL securityType;

@end
