//
//  AddressPickerView.h
//  GraduationProject
//
//  Created by CoDancer on 16/1/2.
//  Copyright © 2016年 onwer. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kScreen_Width  [UIScreen mainScreen].bounds.size.width
#define kScreen_Height [UIScreen mainScreen].bounds.size.height
#define kScreen_Frame [UIScreen mainScreen].bounds

typedef void(^GetAddressBlock)(NSString *addressInfo);

@interface AddressPickerView : UIView

+ (void)showPickerViewWithAddressBlock:(GetAddressBlock )addressBlock;



@end
