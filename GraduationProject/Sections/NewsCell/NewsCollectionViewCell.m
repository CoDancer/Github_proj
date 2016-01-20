//
//  NewsCollectionViewCell.m
//  GraduationProject
//
//  Created by CoDancer on 15/12/26.
//  Copyright © 2015年 onwer. All rights reserved.
//

#import "NewsCollectionViewCell.h"
#import "UIView+Category.h"

@interface NewsCollectionViewCell()

@property (nonatomic, strong) UIImageView *cellImageView;

@end

@implementation NewsCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 5.0f;
        self.clipsToBounds = YES;
        self.layer.shadowColor = [UIColor lightGrayColor].CGColor;
        self.layer.shadowOffset = CGSizeMake(10.0, 4.0);
        self.layer.shadowOpacity = 0.4;
        self.layer.shadowRadius = 4.0f;
        [self addSubview:self.cellImageView];
    }
    return self;
}

- (UIImageView *)cellImageView {
    if (!_cellImageView) {
        _cellImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _cellImageView.layer.cornerRadius = 5.0;
        _cellImageView.clipsToBounds = YES;
    }
    return _cellImageView;
}

- (void)setModel:(id)model {
    _model = model;
    self.cellImageView.image = [UIImage imageNamed:model];
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

@end
