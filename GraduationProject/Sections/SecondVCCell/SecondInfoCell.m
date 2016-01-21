//
//  SecondInfoCell.m
//  GraduationProject
//
//  Created by onwer on 16/1/20.
//  Copyright © 2016年 onwer. All rights reserved.
//

#import "SecondInfoCell.h"
#import "UIImageView+WebCache.h"

@interface SecondInfoCell()

@property (nonatomic, strong) UIImageView *dynamicIV;
@property (nonatomic, strong) UILabel *dynamicLabel;


@end

@implementation SecondInfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.dynamicIV];
        [self.contentView addSubview:self.dynamicLabel];
    }
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    self.dynamicIV.left = 0;
    self.dynamicIV.top = 0;
}

- (UIImageView *)dynamicIV {
    
    if (!_dynamicIV) {
        _dynamicIV = [UIImageView new];
        _dynamicIV.userInteractionEnabled = YES;
        _dynamicIV.contentMode = UIViewContentModeScaleToFill;
        [_dynamicIV addGestureRecognizer:[[UITapGestureRecognizer alloc]
                                          initWithTarget:self
                                          action:@selector(imageViewDidTap)]];
    }
    return _dynamicIV;
}

- (UILabel *)dynamicLabel {
    
    if (!_dynamicLabel) {
        _dynamicLabel = [UILabel new];
        _dynamicLabel.textColor = [UIColor blackColor];
        _dynamicLabel.font = [UIFont systemFontOfSize:16.0f];
        _dynamicLabel.numberOfLines = 0;
    }
    return _dynamicLabel;
}

- (void)setCellImage:(UIImage *)image contentInfo:(NSString *)content {
    
    self.dynamicIV.size = [UIHelper getAppropriateImageSizeWithSize:image.size];
    self.dynamicIV.image = image;
    self.dynamicLabel.text = content;
    self.dynamicLabel.top = self.dynamicIV.bottom + 10;
    self.dynamicLabel.left = 10;
    self.dynamicLabel.width = self.contentView.width - 10 * 2;
    [self.dynamicLabel sizeToFit];
}

- (void)imageViewDidTap {
    
    
}

@end
