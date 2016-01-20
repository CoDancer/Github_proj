//
//  BookView.m
//  PopViewController
//
//  Created by onwer on 16/1/12.
//  Copyright © 2016年 onwer. All rights reserved.
//

#import "BookView.h"
#import "UIView+Category.h"
#import "UIImageView+WebCache.h"

@interface BookView()

@property (nonatomic, strong) UIImageView *bookPic;
@property (nonatomic, strong) UILabel *bookScore;
@property (nonatomic, strong) UILabel *bookName;
@property (nonatomic, strong) UILabel *anthor;

@end

@implementation BookView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        [self addSubview:self.bookPic];
        [self addSubview:self.bookName];
        [self addSubview:self.bookScore];
        [self addSubview:self.anthor];
    }
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    self.bookPic.size = CGSizeMake(85, 120);
    self.bookPic.origin = CGPointMake(0, 0);
    
    self.bookName.left = 5;
    self.bookName.width = self.width - 20;
    self.bookName.height = 20;
    self.bookName.top = self.bookPic.bottom;
    
    
    self.bookScore.left = self.bookName.right + 2;
    self.bookScore.width = 15;
    self.bookScore.height = 20;
    self.bookScore.top = self.bookPic.bottom;
    
    self.anthor.left = 5;
    self.anthor.width = self.width - 10;
    self.anthor.height = 20;
    self.anthor.top = self.bookName.bottom;
    
}

- (UIImageView *)bookPic {
    
    if (!_bookPic) {
        _bookPic = [UIImageView new];
        _bookPic.layer.shadowColor = [UIColor grayColor].CGColor;
        _bookPic.layer.shadowOffset = CGSizeMake(8, 4);
        _bookPic.layer.shadowOpacity = 0.7;
    }
    return _bookPic;
}

- (UILabel *)bookName {
    
    if (!_bookName) {
        _bookName = [UILabel new];
        _bookName.textColor = [UIColor blackColor];
        _bookName.font = [UIFont systemFontOfSize:10.0f];
    }
    return _bookName;
}

- (UILabel *)bookScore {
    
    if (!_bookScore) {
        _bookScore = [UILabel new];
        _bookScore.textColor = [UIColor blackColor];
        _bookScore.font = [UIFont systemFontOfSize:8.0f];
    }
    return _bookScore;
}

- (UILabel *)anthor {
    
    if (!_anthor) {
        _anthor = [UILabel new];
        _anthor.textColor = [UIColor blackColor];
        _anthor.font = [UIFont systemFontOfSize:10.0f];
    }
    return _anthor;
}

- (void)setBookModel:(BookListModel *)bookModel {
    
    _bookModel = bookModel;
    [self.bookPic sd_setImageWithURL:[NSURL URLWithString:bookModel.imageURL] placeholderImage:nil];
    self.bookName.text = bookModel.book_name;
    self.bookScore.text = bookModel.fav_count;
    self.anthor.text = bookModel.author;
}



@end
