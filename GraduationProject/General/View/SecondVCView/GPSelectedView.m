//
//  GPSelectedView.m
//  PopViewController
//
//  Created by onwer on 16/1/18.
//  Copyright © 2016年 onwer. All rights reserved.
//

#import "GPSelectedView.h"

#define Color(r, g, b) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1]
#define GolbalSelectGreen Color(33, 197, 180)

@interface GPSelectedView()

@property (nonatomic, strong) UIButton *groomBtn;
@property (nonatomic, strong) UIButton *infoBtn;
@property (nonatomic, strong) UIButton *nowSelectedBtn;
@property (nonatomic, strong) UIView *slideLineView;

@end

@implementation GPSelectedView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}

//设置控件的frame
- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    CGFloat viewH = self.bounds.size.height;
    CGFloat viewW = self.bounds.size.width;
    CGFloat btnW = viewW * 0.3;
    CGFloat btnH = viewH;
    //计算间距
    CGFloat margin = (viewW - btnW * (self.subviews.count - 1)) / self.subviews.count;
    
    self.groomBtn.frame = CGRectMake(margin, 0, btnW, btnH);
    self.infoBtn.frame = CGRectMake(2 * margin + btnW , 0, btnW, btnH);
    self.slideLineView.frame = CGRectMake(margin, viewH - 4, btnW, 4);
}

- (void)setUp {
    
    self.backgroundColor = [UIColor whiteColor];
    self.layer.shadowOpacity = 0.1;
    self.layer.shadowOffset = CGSizeMake(0, 2);
    
    self.groomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addBtnToView:self.groomBtn image:[UIImage imageNamed:@"groom"] tag:0];
    self.infoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addBtnToView:self.infoBtn image:[UIImage imageNamed:@"info"] tag:1];
    
    self.slideLineView = [[UIView alloc] init];
    self.slideLineView.backgroundColor = GolbalSelectGreen;
    self.slideLineView.layer.masksToBounds = YES;
    self.slideLineView.layer.cornerRadius = 2;
    [self addSubview:self.slideLineView];
    
    [self.groomBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    [self.infoBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
}

//便利构造方法
+ (instancetype)selectView {
    
    GPSelectedView *selectView = [[self alloc] init];
    return selectView;
}

#pragma mark - 按钮的Action
- (void)btnClick:(UIButton *)sender {
    
    if (self.nowSelectedBtn == sender) return;
    //通知代理点击
    if ([self.delegate respondsToSelector:@selector(selectView:didSelectedButtonFrom:to:)]) {
        [self.delegate selectView:self didSelectedButtonFrom:self.nowSelectedBtn.tag to:sender.tag];
    }
    
    //给滑动小条做动画
    CGRect rect = self.slideLineView.frame;
    rect.origin.x = sender.frame.origin.x;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.slideLineView.frame = rect;
    }];
    
    self.nowSelectedBtn = sender;
}

//有代理时，点击按钮
- (void)setDelegate:(id<GPSelectedViewDelegate>)delegate {
    
    _delegate = delegate;
    [self btnClick:self.groomBtn];
}

- (void)lineToIndex:(NSInteger)index {
    
    switch (index) {
        case 0:
            if ([self.delegate respondsToSelector:@selector(selectView:didChangeSelectedView:)]) {
                [self.delegate selectView:self didChangeSelectedView:0];
            }
            self.nowSelectedBtn = self.groomBtn;
            break;
        case 1:
            if ([self.delegate respondsToSelector:@selector(selectView:didChangeSelectedView:)]) {
                [self.delegate selectView:self didChangeSelectedView:1];
            }
            self.nowSelectedBtn = self.infoBtn;
            break;
        default:
            break;
    }
    
    CGRect rect = self.slideLineView.frame;
    rect.origin.x = self.nowSelectedBtn.frame.origin.x;
    
    
    [UIView animateWithDuration:0.3 animations:^{
        self.slideLineView.frame = rect;
    }];
    
}

- (void)addBtnToView:(UIButton *)btn image:(UIImage *)image tag:(NSInteger)tag {
    [btn setAdjustsImageWhenHighlighted:NO];
    [btn setBackgroundColor:[UIColor whiteColor]];
    [btn setImage:image forState:UIControlStateNormal];
    btn.tag = tag;
    [self addSubview:btn];
}

@end
