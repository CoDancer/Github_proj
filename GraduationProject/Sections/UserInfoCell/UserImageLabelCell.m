//
//  UserImageLabelCell.m
//  GraduationProject
//
//  Created by CoDancer on 15/12/27.
//  Copyright © 2015年 onwer. All rights reserved.
//

#import "UserImageLabelCell.h"

@interface UserImageLabelCell()

@property (nonatomic, strong) UIImageView *leftImageView;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *subTitleLabel;
@property (nonatomic, strong) UIImageView *rightImageView;

@end

@implementation UserImageLabelCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

- (UIImageView *)leftImageView {
    if(!_leftImageView) {
        _leftImageView = [UIImageView new];
    }
    return _leftImageView;
}

@end
