//
//  DoWaysCell.m
//  GraduationProject
//
//  Created by onwer on 16/1/29.
//  Copyright © 2016年 onwer. All rights reserved.
//

#import "DoWaysCell.h"

@interface DoWaysCell()

@property (nonatomic, strong) UILabel *lineLabel;
@property (nonatomic, strong) UIImageView *timeImageView;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation DoWaysCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.lineLabel];
        [self.contentView addSubview:self.timeLabel];
        [self.contentView addSubview:self.timeImageView];
        [self.contentView addSubview:self.contentLabel];
    }
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    [self.lineLabel sizeToFit];
    self.lineLabel.centerX = self.contentView.centerX;
    
    [self.timeLabel sizeToFit];
    self.timeLabel.centerX = self.contentView.centerX;
    
    self.timeImageView.size = CGSizeMake(20, 20);
    self.timeImageView.right = self.timeLabel.left;
    self.timeImageView.centerY = self.timeLabel.centerY;
    
    [self.contentLabel sizeToFit];
    self.contentLabel.width = self.lineLabel.width;
    self.contentLabel.left = self.lineLabel.left;
    self.contentLabel.top = self.timeLabel.bottom + 10;
}

- (UILabel *)lineLabel {

    if (!_lineLabel) {
        _lineLabel = [UILabel new];
        _lineLabel.textColor = [UIColor blackColor];
        _lineLabel.textAlignment = NSTextAlignmentCenter;
        _lineLabel.font = [UIFont boldSystemFontOfSize:15.0f];
    }
    return _lineLabel;
}

- (UILabel *)timeLabel {
    
    if (!_timeLabel) {
        _timeLabel = [UILabel new];
        _timeLabel.textColor = MainColor;
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        _timeLabel.backgroundColor = [UIColor whiteColor];
        _timeLabel.font = [UIFont boldSystemFontOfSize:18.0f];
    }
    return _timeLabel;
}

- (UIImageView *)timeImageView {
    
    if (!_timeImageView) {
        _timeImageView = [UIImageView new];
        _timeImageView.backgroundColor = [UIColor whiteColor];
    }
    return _timeImageView;
}

- (UILabel *)contentLabel {
    
    if (!_contentLabel) {
        _contentLabel = [UILabel new];
        _contentLabel.textColor = [UIColor blackColor];
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.font = [UIFont boldSystemFontOfSize:14.0];
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}

- (void)setModel:(DoWaysModel *)model {
    
    _model = model;
    self.timeImageView.image = [UIImage imageNamed:@"InfoTime"];
    self.lineLabel.text = @"· · · · · · · · · · · · · · · · · · · · · · · · ·";
    self.timeLabel.text = model.time;
    self.contentLabel.text = model.howDo;
}

- (CGFloat)getCellHeightWithCellContent:(NSString *)content {
    
    CGRect rect=[content boundingRectWithSize:CGSizeMake(211, 0)
                                                options:NSStringDrawingUsesLineFragmentOrigin
                                             attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:14.0],NSFontAttributeName, nil] context:nil];
    return rect.size.height + 45;
}



@end
