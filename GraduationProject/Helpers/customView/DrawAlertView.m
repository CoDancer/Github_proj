//
//  DrawAlertView.m
//  GraduationProject
//
//  Created by onwer on 16/3/16.
//  Copyright © 2016年 onwer. All rights reserved.
//

#import "DrawAlertView.h"

#define kWidth [[UIScreen mainScreen] bounds].size.width
#define kHeight [[UIScreen mainScreen] bounds].size.height
#define AUTOLAYTOU(a) ((a)*(kWidth/320))
#define WARN_WIDTH (self.frame.size.width-AUTOLAYTOU(120))

@implementation DrawAlertView{
    UIView *_backView;
    UILabel *_titleLabel;
    NSTimer *_timer;
    NSInteger _showTime;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 10;
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.layer.borderWidth = 1.0f;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake((self.width-WARN_WIDTH)/2, 8, WARN_WIDTH, WARN_WIDTH) cornerRadius:WARN_WIDTH/2];
    [path moveToPoint:CGPointMake((self.frame.size.width-WARN_WIDTH)/2+10, WARN_WIDTH/2)];
    [path addLineToPoint:CGPointMake(self.frame.size.width/2.0-10, WARN_WIDTH-20)];
    [path addLineToPoint:CGPointMake(self.frame.size.width/2.0 + WARN_WIDTH/2-15, AUTOLAYTOU(35))];
    
    [self setDrawAnimationWithPath:path StrokeColor:MainColor];
}

- (void)setDrawAnimationWithPath:(UIBezierPath *)path StrokeColor:(UIColor *)strokeColor {
    
    CAShapeLayer *lineLayer = [ CAShapeLayer layer];
    lineLayer. frame = CGRectZero;
    lineLayer. fillColor = [ UIColor clearColor ]. CGColor ;
    lineLayer. path = path. CGPath ;
    lineLayer. strokeColor = strokeColor. CGColor ;
    lineLayer.lineWidth = 8.0;
    lineLayer.cornerRadius = 5;
    
    CABasicAnimation *ani = [ CABasicAnimation animationWithKeyPath : NSStringFromSelector ( @selector (strokeEnd))];
    ani. fromValue = @0 ;
    ani. toValue = @1 ;
    ani. duration = 0.8 ;
    [lineLayer addAnimation :ani forKey : NSStringFromSelector (@selector(strokeEnd))];
    [self.layer addSublayer :lineLayer];
}

- (instancetype)initWithTitle:(NSString *)title {
    
    self = [super init];
    if (self) {
        self.frame = CGRectMake(50, 50, kWidth - AUTOLAYTOU(100), kWidth - AUTOLAYTOU(180));
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 10;
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.layer.borderWidth = 1.0f;
        self.clipsToBounds = YES;
        _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth ,kHeight)];
        _backView.backgroundColor = [UIColor colorWithRed:225/255.0 green:225/255.0 blue:225/255.0 alpha:0.8];
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, WARN_WIDTH + 16, self.frame.size.width-20, AUTOLAYTOU(20))];
        _titleLabel.textColor = [UIColor grayColor];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.text = title;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
        [_timer fireDate];
    }
    return self;
}

- (void)timeChange {
    static int time = 0;
    if (time == 2.0) {
        [UIView animateWithDuration:0.5 animations:^{
            _backView.alpha = 0;
            self.alpha = 0;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
            [_backView removeFromSuperview];
            _backView = nil;
        }];
        time = 0;
        [_timer invalidate];
        _timer = nil;
    }
    time ++;
}

- (void)showInView:(UIView *)superView {
    
    [self setPopAnimation];
    [superView addSubview:_backView];
    [_backView addSubview:self];
    self.center = _backView.center;
}

- (void)setPopAnimation {
    CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    popAnimation.duration = 0.4;
    popAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f, 0.01f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9f, 0.9f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DIdentity]];
    popAnimation.keyTimes = @[@0.2f, @0.5f, @0.75f, @1.0f];
    popAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:
                                      kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [self.layer addAnimation:popAnimation forKey:nil];
}

@end
