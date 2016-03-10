//
//  CustomAnnotationView.h
//  GraduationProject
//
//  Created by onwer on 16/3/9.
//  Copyright © 2016年 onwer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface CustomAnnotationView : MKAnnotationView

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subLabel;
@property (nonatomic, strong) UIImageView *leftImageView;


@end
