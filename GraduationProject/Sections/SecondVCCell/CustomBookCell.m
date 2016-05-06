//
//  CustomBookCell.m
//  PopViewController
//
//  Created by onwer on 16/1/11.
//  Copyright © 2016年 onwer. All rights reserved.
//

#import "CustomBookCell.h"
#import "UIView+Category.h"
#import "NSArray+category.h"

@interface CustomBookCell()

@property (nonatomic, strong) CAGradientLayer *baseLayer;

@end

@implementation CustomBookCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView.layer addSublayer:self.baseLayer];
        [self.contentView addSubview:self.leftBookView];
        [self.contentView addSubview:self.centerBookView];
        [self.contentView addSubview:self.rightBookView];
    }
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    self.baseLayer.frame = self.contentView.bounds;
    
    self.centerBookView.centerX = self.contentView.centerX;
    self.centerBookView.bottom = self.contentView.bottom;
    self.centerBookView.size = CGSizeMake(85, 160);
    
    self.leftBookView.right = self.centerBookView.left - 20;
    self.leftBookView.bottom = self.contentView.bottom;
    self.leftBookView.size = self.centerBookView.size;
    
    self.rightBookView.left = self.centerBookView.right + 20;
    self.rightBookView.bottom = self.contentView.bottom;
    self.rightBookView.size = self.centerBookView.size;
}

- (CAGradientLayer *)baseLayer {
    
    if (!_baseLayer) {
        _baseLayer = [CAGradientLayer new];
        _baseLayer.colors = @[(__bridge id)[UIColor whiteColor].CGColor,
                         (__bridge id)[UIColor lightGrayColor].CGColor];
        _baseLayer.startPoint = CGPointMake(0, 0);
        _baseLayer.endPoint = CGPointMake(0, 1);
        _baseLayer.locations = @[@(0.7)];
    }
    return _baseLayer;
}

- (BookView *)leftBookView {
    
    if (!_leftBookView) {
        _leftBookView = [BookView new];
        [self addTapGesToBookView:_leftBookView];
    }
    return _leftBookView;
}

- (BookView *)centerBookView {
    
    if (!_centerBookView) {
        _centerBookView = [BookView new];
        [self addTapGesToBookView:_centerBookView];
    }
    return _centerBookView;
}

- (BookView *)rightBookView {
    
    if (!_rightBookView) {
        _rightBookView = [BookView new];
        [self addTapGesToBookView:_rightBookView];
    }
    return _rightBookView;
}

- (void)addTapGesToBookView:(BookView *)bookView {
    
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bookViewDidTap:)];
    [bookView addGestureRecognizer:tapGes];
}

- (void)bookViewDidTap:(UITapGestureRecognizer *)ges {
    
    BookView *bookView = (BookView *)ges.view;
    if ([self.bookDelegate respondsToSelector:@selector(bookViewDidTapBookView:)]) {
        [self.bookDelegate bookViewDidTapBookView:bookView];
    }
}

- (void)setBookModels:(NSArray *)bookModels {
    
    _bookModels = bookModels;
    self.leftBookView.bookModel = [bookModels objectOrNilAtIndex:0];
    self.centerBookView.bookModel = [bookModels objectOrNilAtIndex:1];
    self.rightBookView.bookModel = [bookModels objectOrNilAtIndex:2];
    
    if (self.leftBookView.bookModel.bookId == nil) {
        self.leftBookView.userInteractionEnabled = NO;
    }
    if (self.centerBookView.bookModel.bookId == nil) {
        self.centerBookView.userInteractionEnabled = NO;
    }
    if (self.rightBookView.bookModel.bookId == nil) {
        self.rightBookView.userInteractionEnabled = NO;
    }
}

@end
