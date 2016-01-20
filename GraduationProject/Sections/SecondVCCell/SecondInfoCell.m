//
//  SecondInfoCell.m
//  GraduationProject
//
//  Created by onwer on 16/1/20.
//  Copyright © 2016年 onwer. All rights reserved.
//

#import "SecondInfoCell.h"

//[[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:model.imageURL] options:SDWebImageDownloaderLowPriority|SDWebImageDownloaderContinueInBackground progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
//    self.BGImageView.width = image.size.width;
//    self.BGImageView.height = image.size.height;
//    self.BGImageView.image = image;
//}];

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
    
}

- (UIImageView *)dynamicIV {
    
    if (!_dynamicIV) {
        _dynamicIV = [UIImageView new];
        _dynamicIV.userInteractionEnabled = YES;
        _dynamicIV.contentMode = UIViewContentModeScaleToFill;
    }
    return _dynamicIV;
}

- (UILabel *)dynamicLabel {
    
    if (!_dynamicLabel) {
        _dynamicLabel = [UILabel new];
        _dynamicLabel.textColor = [UIColor blackColor];
        _dynamicLabel.font = [UIFont systemFontOfSize:14.0f];
    }
    return _dynamicLabel;
}

@end
