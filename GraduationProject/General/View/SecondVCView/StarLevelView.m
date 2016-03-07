//
//  StarLevelView.m
//  GraduationProject
//
//  Created by onwer on 16/1/19.
//  Copyright © 2016年 onwer. All rights reserved.
//

#import "StarLevelView.h"

@implementation StarLevelView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = NO;
    }
    return self;
}

- (void)setStarLevel:(CGFloat)starLevel {
    
    _starLevel = starLevel;
    CGFloat width = 12;
    CGFloat height = 11;
    NSString *selected = @"grade_selected";
    NSString *selected_half = @"gen_star_selected_half";
    
    if (starLevel - (int)starLevel >= 0 && starLevel - (int)starLevel < 0.5) {
        for (int i = 0; i < (int)starLevel; i++) {
            UIImageView *star = [[UIImageView alloc] initWithImage:[UIImage imageNamed:selected]];
            star.frame = CGRectMake(i * (width+3), 0, width, height);
            [self addSubview:star];
        }
    }else if (starLevel - (int)starLevel < 1.0 && starLevel - (int)starLevel >= 0.5) {
        for (int i = 0; i < (int)starLevel; i++) {
            UIImageView *star = [[UIImageView alloc] initWithImage:[UIImage imageNamed:selected]];
            star.frame = CGRectMake(i * (width+3), 0, width, height);
            [self addSubview:star];
            if (i == (int)starLevel - 1) {
                UIImageView *half_star = [[UIImageView alloc]
                                     initWithImage:[UIImage imageNamed:selected_half]];
                half_star.frame = CGRectMake((i+1) * (width+3), 0, width, height);
                [self addSubview:half_star];
            }
        }
    }
}

@end
