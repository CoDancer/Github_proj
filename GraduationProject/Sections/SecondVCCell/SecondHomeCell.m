//
//  SecondHomeCell.m
//  GraduationProject
//
//  Created by CoDancer on 16/1/2.
//  Copyright © 2016年 onwer. All rights reserved.
//

#import "SecondHomeCell.h"
#import "UIImageView+WebCache.h"
#import "StarLevelView.h"

@interface SecondHomeCell()

@property (nonatomic, strong) UIImageView *BGImageView;
@property (nonatomic, strong) UIImageView *labelImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIImageView *labelBaseView;
@property (nonatomic, strong) UILabel *addressLabel;
@property (nonatomic, strong) UILabel *praiseLabel;
@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UIImageView *addressImageView;
@property (nonatomic, strong) StarLevelView *praiseImageView;

@end

@implementation SecondHomeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.BGImageView];
        [self.contentView addSubview:self.labelImageView];
        
        [self.labelBaseView addSubview:self.nameLabel];
        [self.labelBaseView addSubview:self.addressLabel];
        [self.labelBaseView addSubview:self.praiseLabel];
        [self.labelBaseView addSubview:self.addressImageView];
        [self.labelBaseView addSubview:self.praiseImageView];
        [self.contentView addSubview:self.labelBaseView];
        [self.contentView addSubview:self.lineView];
        
    }
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    self.BGImageView.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.contentView.height - 10);
    self.labelImageView.left = 0;
    self.labelImageView.bottom = self.BGImageView.bottom;
    self.labelImageView.width = SCREEN_WIDTH;
    self.labelImageView.height = 100;
    
    self.labelBaseView.left = 0;
    self.labelBaseView.width = SCREEN_WIDTH;
    self.labelBaseView.height = 50;
    self.labelBaseView.bottom = self.labelImageView.bottom;
    [self.nameLabel sizeToFit];
    self.nameLabel.left = 15;
    self.nameLabel.top = 5;
    
    self.addressImageView.top = self.nameLabel.bottom + 5;
    self.addressImageView.size = CGSizeMake(15, 15);
    self.addressImageView.left = self.nameLabel.left;

    [self.addressLabel sizeToFit];
    self.addressLabel.left = self.addressImageView.right + 10;
    self.addressLabel.top = self.nameLabel.bottom + 5;
    
    CGFloat width = 13;
    CGFloat height = 16;
    self.praiseImageView.width = 5*width + (5 - 1)*3;
    self.praiseImageView.height = height;
    self.praiseImageView.right = self.labelBaseView.width - 15;
    self.praiseImageView.top = self.nameLabel.bottom + 5;
    
    [self.praiseLabel sizeToFit];
    self.praiseLabel.left = self.praiseImageView.right - 2;
    self.praiseLabel.top = self.praiseImageView.top + 2;
}

- (UIImageView *)BGImageView {
    
    if (!_BGImageView) {
        _BGImageView = [UIImageView new];
        _BGImageView.userInteractionEnabled = YES;
    }
    return _BGImageView;
}

- (UIImageView *)labelImageView {
    
    if (!_labelImageView) {
        _labelImageView = [UIImageView new];
        _labelImageView.userInteractionEnabled = YES;
    }
    return _labelImageView;
}

- (UILabel *)nameLabel {
    
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.font = [UIFont fontWithName:@"Verdana-Bold" size:14.0f];
        _nameLabel.textColor = [UIColor whiteColor];
    }
    return _nameLabel;
}

- (UIImageView *)labelBaseView {
    
    if (!_labelBaseView) {
        _labelBaseView = [UIImageView new];
        _labelBaseView.userInteractionEnabled = YES;
    }
    return _labelBaseView;
}

- (UILabel *)addressLabel {
    
    if (!_addressLabel) {
        
        _addressLabel = [UILabel new];
        _addressLabel.font = [UIFont systemFontOfSize:14.0f];
        _addressLabel.textColor = [UIColor whiteColor];
    }
    return _addressLabel;
}

- (UILabel *)praiseLabel {
    
    if (!_praiseLabel) {
        _praiseLabel = [UILabel new];
        _praiseLabel.font = [UIFont systemFontOfSize:8.0f];
        _praiseLabel.textColor = [UIColor colorWithRed:1.000 green:0.993 blue:0.184 alpha:1.000];
    }
    return _praiseLabel;
}

- (UIView *)lineView {
    
    if (!_lineView) {
        _lineView = [UIView new];
    }
    return _lineView;
}

- (UIImageView *)addressImageView {
    
    if (!_addressImageView) {
        _addressImageView = [UIImageView new];
    }
    return _addressImageView;
}

- (StarLevelView *)praiseImageView {
    
    if (!_praiseImageView) {
        _praiseImageView = [StarLevelView new];
    }
    return _praiseImageView;
}

- (void)setModel:(SecondViewCellModel *)model {
    
    [self.BGImageView sd_setImageWithURL:[NSURL URLWithString:model.imageURL]
                        placeholderImage:nil];
    [self.addressImageView setImage:[UIImage imageNamed:@"index_address_icon_6P"]];
    [self.labelBaseView setImage:[UIImage imageNamed:@"news_blacklayer"]];
    self.nameLabel.text = model.section_title;
    self.addressLabel.text = model.poi_name;
    self.praiseLabel.text = model.fav_count;
    self.praiseImageView.starLevel = [model.fav_count floatValue];
    
}

@end
