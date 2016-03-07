//
//  BYInputField.m
//  BYHelperCode
//
//  Created by onwer on 15/10/19.
//  Copyright © 2015年 CoDancer. All rights reserved.
//

#import "GPInputField.h"

@interface GPInputField()<UITextFieldDelegate>
@property (nonatomic, strong) UIImageView *leftView;
@property (nonatomic, strong) UITextField *inputField;
@property (nonatomic, strong) UIImageView *backView;

@end

@implementation GPInputField
#pragma mark --life cycle
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.size.width, [[UIImage imageNamed:@"login_input"] size].height)];
        self.backView.image = [[UIImage imageNamed:@"login_input"] resizableImageWithCapInsets:UIEdgeInsetsMake(12, 12, 12, 12)];
        self.backView.userInteractionEnabled = YES;
        
        self.inputField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, self.size.width - self.leftView.size.width, frame.size.height)];
        self.inputField.delegate = self;
        self.leftView = [UIImageView new];
        
        [self addSubview:self.backView];
        [self.backView addSubview:self.inputField];
        [self.backView addSubview:self.leftView];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(inputFieldTextReceiveDidChange:) name:UITextFieldTextDidChangeNotification object:nil];
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.leftView.left = self.backView.left + 5;
    self.leftView.centerY = self.inputField.centerY = self.backView.centerY;
    [self.leftView sizeToFit];
    self.inputField.left = self.leftView.right + 5;
    self.inputField.width = self.size.width - self.leftView.size.width;
    self.inputField.top = 0;
    self.backView.left = 0;
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
# pragma mark -- setter and getter method
- (void)setLeftImage:(UIImage *)leftImage{
    _leftImage = leftImage;
    self.leftView.image = leftImage;
    self.inputField.width = self.size.width - self.leftView.size.width;
    
}
- (void)setPlaceHolder:(NSString *)placeHolder{
    _placeHolder = placeHolder;
    self.inputField.placeholder = placeHolder;
}
- (void)setTextFont:(NSInteger)textFont{
    _textFont = textFont;
    self.inputField.font = [UIFont systemFontOfSize:textFont];
}
- (NSString *)text{
    return self.inputField.text;
}
- (void)setKeyboardType:(UIKeyboardType)keyboardType{
    _keyboardType = keyboardType;
    self.inputField.keyboardType = keyboardType;
    self.inputField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.inputField.clearsOnBeginEditing = NO;
    self.inputField.autocapitalizationType = UITextAutocorrectionTypeNo;
}
- (void)setSecurityType:(BOOL)securityType{
    _securityType = securityType;
    self.inputField.secureTextEntry = securityType;
}

# pragma mark -- delegate
- (void)inputFieldTextReceiveDidChange:(NSNotification *)note{
    
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
}


@end
