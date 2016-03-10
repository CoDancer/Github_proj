//
//  GPAlertView.m
//  GraduationProject
//
//  Created by onwer on 16/3/8.
//  Copyright © 2016年 onwer. All rights reserved.
//

#import "GPAlertView.h"

@interface GPAlertView()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, strong) UIButton *centerBtn;
@property (nonatomic, assign) CGRect messageRect;
@property (nonatomic, strong) UIView *coverView;
@property (nonatomic, assign) BOOL isOnlyOne;

@end

@implementation GPAlertView

- (instancetype)initWithTitle:(NSString *)title message:(id)message buttons:(NSArray *)array {
    
    CGSize lableSize = CGSizeMake(250 - 30, 0);
    
    if (array.count == 2 || array.count == 1) {
        self.titleLabel.text = title;
        if ([message isKindOfClass:[NSString class]]) {
            self.messageRect = [message boundingRectWithSize:lableSize
                                                     options:NSStringDrawingUsesLineFragmentOrigin
                                                  attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:16.0f],NSFontAttributeName, nil] context:nil];
            self.messageLabel.text = message;
        }else if ([message isKindOfClass:[NSMutableAttributedString class]]){
            self.messageRect = [((NSMutableAttributedString *)message).string boundingRectWithSize:lableSize
                                                                                           options:NSStringDrawingUsesLineFragmentOrigin
                                                                                        attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:16.0f],NSFontAttributeName, nil] context:nil];
            self.messageLabel.attributedText = message;
        }
        if (message == nil) {
            self.messageRect = CGRectZero;
        }
        if (array.count == 2) {
            self.isOnlyOne = NO;
            [self.leftBtn setTitle:[array firstObject] forState:UIControlStateNormal];
            [self.rightBtn setTitle:[array lastObject] forState:UIControlStateNormal];
        }else if (array.count == 1) {
            self.isOnlyOne = YES;
            [self.centerBtn setTitle:[array firstObject] forState:UIControlStateNormal];
        }
        return [self initWithFrame:CGRectMake(0, 0, 250, 130 + self.messageRect.size.height)];
    }
    return nil;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = 8.0;
        self.clipsToBounds = YES;
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.titleLabel];
        [self addSubview:self.messageLabel];
        [self addSubview:self.lineView];
        if (self.isOnlyOne) {
            [self addSubview:self.centerBtn];
        }else {
            [self addSubview:self.leftBtn];
            [self addSubview:self.rightBtn];
        }
    }
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    [self.titleLabel sizeToFit];
    self.titleLabel.top = 30;
    self.titleLabel.centerX = self.width/2.0;
    self.messageLabel.left = 12;
    self.messageLabel.width = self.width - 24;
    self.messageLabel.height = self.messageRect.size.height;
    self.messageLabel.top = self.titleLabel.bottom + 12.0f;
    self.messageLabel.centerX = self.titleLabel.centerX;
    self.lineView.size = CGSizeMake(self.width, 1.0);
    self.lineView.top = self.messageLabel.bottom + 15;
    
    self.leftBtn.size = CGSizeMake(80, 30);
    self.leftBtn.left = 25;
    self.leftBtn.bottom = self.height - 10;
    self.leftBtn.layer.cornerRadius = 3.0f;
    self.rightBtn.size = CGSizeMake(80, 30);
    self.rightBtn.layer.cornerRadius = 3.0f;
    self.rightBtn.right = self.width - 25;
    self.rightBtn.centerY = self.leftBtn.centerY;
    
    self.centerBtn.size = CGSizeMake(80, 30);
    self.centerBtn.centerX = self.width/2.0;
    self.centerBtn.bottom = self.height - 10;
}

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont boldSystemFontOfSize:20.0f];
    }
    return _titleLabel;
}

- (UILabel *)messageLabel {
    
    if (!_messageLabel) {
        _messageLabel = [UILabel new];
        _messageLabel.backgroundColor = [UIColor whiteColor];
        _messageLabel.textColor = [UIColor lightGrayColor];
        _messageLabel.textAlignment = NSTextAlignmentCenter;
        _messageLabel.font = [UIFont systemFontOfSize:16.0f];
        _messageLabel.numberOfLines = 0;
    }
    return _messageLabel;
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
        [_leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_leftBtn setBackgroundColor:[UIColor lightGrayColor]];
        [_leftBtn.titleLabel setFont:[UIFont systemFontOfSize:16.0f]];
        [_leftBtn addTarget:self action:@selector(ViewBtnDidTap:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftBtn;
}

- (UIButton *)rightBtn {
    
    if (!_rightBtn) {
        _rightBtn = [UIButton new];
        _rightBtn.tag = 1;
        [_rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_rightBtn setBackgroundColor:MainColor];
        [_rightBtn.titleLabel setFont:[UIFont systemFontOfSize:16.0f]];
        [_rightBtn addTarget:self action:@selector(ViewBtnDidTap:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightBtn;
}

- (UIButton *)centerBtn {
    
    if (!_centerBtn) {
        _centerBtn = [UIButton new];
        _centerBtn.tag = 2;
        [_centerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_centerBtn setBackgroundColor:MainColor];
        [_centerBtn.titleLabel setFont:[UIFont systemFontOfSize:16.0f]];
        [_centerBtn addTarget:self action:@selector(ViewBtnDidTap:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _centerBtn;
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

- (void)coverViewDidTap {
    
    [self dismiss];
}

- (void)dismiss {
    
    [UIView animateWithDuration:0.4 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0 options:0 animations:^{
        self.frame = CGRectMake(SCREEN_WIDTH/2.0 - self.self.width/2.0, self.centerY, self.width, 1.0);
        self.coverView.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [self.coverView removeFromSuperview];
    }];
}

- (void)show {
    
    [[[UIApplication sharedApplication].delegate window] addSubview:self.coverView];
    [[[UIApplication sharedApplication].delegate window] addSubview:self];
    self.center = self.coverView.center;
    self.frame = CGRectMake(SCREEN_WIDTH/2.0 - self.width/2.0, self.centerY, self.width, 1.0);
    [UIView animateWithDuration:0.4 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0 options:0 animations:^{
        self.frame = CGRectMake(self.left,
                                self.centerY - (130 + self.messageRect.size.height)/2.0,
                                self.width,
                                130 + self.messageRect.size.height);
        self.coverView.alpha = 0.7;
    } completion:^(BOOL finished) {
    }];
}

- (void)ViewBtnDidTap:(UIButton *)sender {
    
    [self dismiss];
    if (self.actionBlock) {
        self.actionBlock(sender.tag);
    }
}

@end
