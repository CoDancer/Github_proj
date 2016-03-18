//
//  ModifyUserInfoView.m
//  GraduationProject
//
//  Created by onwer on 16/3/15.
//  Copyright © 2016年 onwer. All rights reserved.
//

#import "ModifyUserInfoView.h"

@interface ModifyUserInfoView()<UITextFieldDelegate, UITextViewDelegate>

@property (nonatomic, strong) UIImageView *topImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextView *message;
@property (nonatomic, strong) UILabel *placeholderLabel;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, assign) BOOL canEdit;
@property (nonatomic, strong) UITextField *editField;
@property (nonatomic, strong) UIView *coverView;

@end

@implementation ModifyUserInfoView

- (instancetype)initWihtTitle:(NSString *)title message:(NSString *)message
                      leftStr:(NSString *)str rightStr:(NSString *)rightStr {
    
    self.titleLabel.text = title;
    if (message != nil) {
        self.message.text = message;
    }else {
        self.message.editable = YES;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tableViewWillShow:) name:UIKeyboardWillShowNotification object:nil];
    }
    [self.leftBtn setTitle:str forState:UIControlStateNormal];
    [self.rightBtn setTitle:rightStr forState:UIControlStateNormal];
    return [self initWithFrame:CGRectMake(0, 0, 250, 190)];
    
}

- (instancetype)initWihtCanEditTitle:(NSString *)title message:(NSString *)message
                             leftStr:(NSString *)str rightStr:(NSString *)rightStr {
    
    self.canEdit = YES;
    self.titleLabel.text = title;
    self.editField.placeholder = message;
    [self.leftBtn setTitle:str forState:UIControlStateNormal];
    [self.rightBtn setTitle:rightStr forState:UIControlStateNormal];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tableViewWillShow:) name:UIKeyboardWillShowNotification object:nil];
    return [self initWithFrame:CGRectMake(0, 0, 250, 150)];
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = 8.0;
        self.clipsToBounds = YES;
        self.backgroundColor = [UIColor colorWithHexString:@"f3f3f3"];
        [self addSubview:self.topImageView];
        [self addSubview:self.titleLabel];
        [self.message addSubview:self.placeholderLabel];
        [self addSubview:self.canEdit ? self.editField : self.message];
        [self addSubview:self.lineView];
        [self addSubview:self.leftBtn];
        [self addSubview:self.rightBtn];
    }
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    self.topImageView.size = CGSizeMake(25, 25);
    self.topImageView.left = 10;
    self.topImageView.top = 14;
    [self.titleLabel sizeToFit];
    self.titleLabel.left = self.topImageView.right + 5;
    self.titleLabel.centerY = self.topImageView.centerY;
    if (self.canEdit) {
        self.editField.left = 10;
        self.editField.size = CGSizeMake(self.width - 28, 33);
        self.editField.top = self.titleLabel.bottom + 14;
        self.editField.inputView.left = 5;
    }else {
        self.message.left = 14;
        self.message.size = CGSizeMake(self.width - 28, 90);
        self.message.top = self.titleLabel.bottom + 8;
        [self.placeholderLabel sizeToFit];
        self.placeholderLabel.left = 5;
        self.placeholderLabel.top = 8;
    }
    self.lineView.frame = CGRectMake(0,
                                     (self.canEdit ? self.editField.bottom + 17 : self.message.bottom + 10),
                                    self.width, 1.0);
    [self.leftBtn sizeToFit];
    self.leftBtn.left = 40;
    self.leftBtn.bottom = self.height - 8;
    [self.rightBtn sizeToFit];
    self.rightBtn.right = self.width - 40;
    self.rightBtn.centerY = self.leftBtn.centerY;
}

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = [UIColor grayColor];
        _titleLabel.font = [UIFont systemFontOfSize:18.0f];
    }
    return _titleLabel;
}

- (UITextView *)message {
    
    if (!_message) {
        _message = [UITextView new];
        _message.delegate = self;
        _message.backgroundColor = [UIColor whiteColor];
        _message.textColor = [UIColor lightGrayColor];
        _message.font = [UIFont systemFontOfSize:16.0f];
        _message.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _message.layer.borderWidth = 1.0f;
        _message.tintColor = [UIColor lightGrayColor];
        _message.editable = NO;
    }
    return _message;
}

- (UILabel *)placeholderLabel {
    
    if (!_placeholderLabel) {
        _placeholderLabel = [UILabel new];
        _placeholderLabel.textColor = [UIColor lightGrayColor];
        _placeholderLabel.font = [UIFont systemFontOfSize:16.0f];
    }
    return _placeholderLabel;
}

- (UITextField *)editField {
    
    if (!_editField) {
        _editField = [UITextField new];
        _editField.delegate = self;
        _editField.backgroundColor = [UIColor whiteColor];
        _editField.textColor = [UIColor lightGrayColor];
        _editField.tintColor = [UIColor lightGrayColor];
        _editField.font = [UIFont systemFontOfSize:18.0f];
        _editField.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _editField.layer.borderWidth = 1.0f;
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
        _editField.leftView = view;
        _editField.leftViewMode = UITextFieldViewModeAlways;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChanged:) name:UITextFieldTextDidChangeNotification object:nil];
    }
    return _editField;
}

- (UIView *)lineView {
    
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = [UIColor lightGrayColor];
    }
    return _lineView;
}

- (UIButton *)leftBtn {
    
    if (!_leftBtn) {
        _leftBtn = [UIButton new];
        _leftBtn.tag = 0;
        [_leftBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_leftBtn.titleLabel setFont:[UIFont systemFontOfSize:16.0f]];
        [_leftBtn addTarget:self action:@selector(ViewBtnDidTap:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftBtn;
}

- (UIButton *)rightBtn {
    
    if (!_rightBtn) {
        _rightBtn = [UIButton new];
        _rightBtn.tag = 1;
        [_rightBtn setTitleColor:MainColor forState:UIControlStateNormal];
        [_rightBtn.titleLabel setFont:[UIFont systemFontOfSize:16.0f]];
        [_rightBtn addTarget:self action:@selector(ViewBtnDidTap:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightBtn;
}

- (UIView *)coverView {
    
    if (!_coverView) {
        _coverView = [[UIView alloc] initWithFrame:MAINSCREEN];
        _coverView.backgroundColor = [UIColor blackColor];
        _coverView.alpha = 0;
        _coverView.userInteractionEnabled = YES;
        UIGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                    initWithTarget:self
                                    action:@selector(coverViewDidTap)];
        [_coverView addGestureRecognizer:tap];
    }
    return _coverView;
}

- (UIImageView *)topImageView {
    
    if (!_topImageView) {
        _topImageView = [UIImageView new];
    }
    return _topImageView;
}

- (void)coverViewDidTap {
    
    [self dismiss];
}

- (void)show {
    
    [[[UIApplication sharedApplication].delegate window] addSubview:self.coverView];
    [[[UIApplication sharedApplication].delegate window] addSubview:self];
    self.center = self.coverView.center;
    CGFloat height = self.height;
    self.frame = CGRectMake(SCREEN_WIDTH/2.0 - self.width/2.0,
                            self.centerY, self.width, 1.0);
    [UIView animateWithDuration:0.4 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0 options:0 animations:^{
        self.frame = CGRectMake(self.left,
                                self.centerY - height/2.0,
                                self.width,
                                height);
        self.coverView.alpha = 0.7;
    } completion:^(BOOL finished) {
    }];
}

- (void)dismiss {
    
    [UIView animateWithDuration:0.4 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0 options:0 animations:^{
        self.frame = CGRectMake(SCREEN_WIDTH/2.0 - self.width/2.0,
                                self.centerY, self.width, 1.0);
        self.coverView.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [self.coverView removeFromSuperview];
    }];
}

- (void)ViewBtnDidTap:(UIButton *)sender {
    
    if (self.actionBlock) {
        self.actionBlock(sender.tag);
    }
    [self dismiss];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (range.location>= 8) {
        return NO;
    }
    return YES;
}

- (void)textFieldChanged:(UITextField *)textField {
    
    NSString *toBeString = self.editField.text;
    NSString *lang = [[self.editField textInputMode] primaryLanguage]; // 键盘输入模式
    if ([lang isEqualToString:@"zh-Hans"] || [lang isEqualToString:@"zh-Hant"]) {
        // 简体中文输入，包括简体拼音，简体五笔，简体手写(zh-Hans)
        // 繁体中文输入，包括繁体拼音，繁体五笔，繁体手写(zh-Hant)
        UITextRange *selectedRange = [self.editField markedTextRange];
        // 获取高亮部分（联想部分）
        UITextPosition *position = [self.editField positionFromPosition:selectedRange.start offset:0];
        // 没有联想，则对已输入的文字进行字数统计和限制
        if (!position) {
            if (toBeString.length > 8) {
                self.editField.text = [toBeString substringToIndex:8];
            }
        }
        // 有联想，则暂不对联想的文字进行统计
        else {
            
        }
    }
    // 中文输入法以外的直接对其统计限制即可，暂时不考虑其他语种情况
    else {
        if (toBeString.length > 8)
        {
            self.editField.text = [toBeString substringToIndex:8];
        }
    }
}

- (NSString *)text {
    
    return self.message.text;
}

- (NSString *)fieldText {
    
    return self.editField.text;
}

- (void)setPlaceholder:(NSString *)placeholder {
    
    _placeholder = placeholder;
    self.placeholderLabel.text = placeholder;
}

- (void)tableViewWillShow:(NSNotification *)aNotification {
    
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    [UIView animateWithDuration:0.4 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0 options:0 animations:^{
        self.bottom = SCREEN_HEIGHT - kbSize.height;
    } completion:^(BOOL finished) {
    }];
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)textViewDidChange:(UITextView *)textView {
    
    NSString *toBeString = self.message.text;
    [self hiddenThePlaceholderWithTextLength:toBeString.length];
    NSString *lang = [[self.message textInputMode] primaryLanguage]; // 键盘输入模式
    if ([lang isEqualToString:@"zh-Hans"] || [lang isEqualToString:@"zh-Hant"]) {
        // 简体中文输入，包括简体拼音，简体五笔，简体手写(zh-Hans)
        // 繁体中文输入，包括繁体拼音，繁体五笔，繁体手写(zh-Hant)
        UITextRange *selectedRange = [self.message markedTextRange];
        // 获取高亮部分（联想部分）
        UITextPosition *position = [self.message positionFromPosition:selectedRange.start offset:0];
        // 没有联想，则对已输入的文字进行字数统计和限制
        if (!position) {
            if (toBeString.length > 40) {
                self.message.text = [toBeString substringToIndex:40];
            }
        }
        // 有联想，则暂不对联想的文字进行统计
        else {
            
        }
    }
    // 中文输入法以外的直接对其统计限制即可，暂时不考虑其他语种情况
    else {
        if (toBeString.length > 40)
        {
            self.message.text = [toBeString substringToIndex:40];
        }
    }
}

- (void)hiddenThePlaceholderWithTextLength:(NSInteger)length {
    
    if (length == 0) {
        self.placeholderLabel.hidden = NO;
    }else{
        self.placeholderLabel.hidden = YES;
    }
}

- (void)setImage:(UIImage *)image {
    
    _image = image;
    self.topImageView.image = image;
}

@end
