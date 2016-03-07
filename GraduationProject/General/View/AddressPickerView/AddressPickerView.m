//
//  AddressPickerView.m
//  GraduationProject
//
//  Created by CoDancer on 16/1/2.
//  Copyright © 2016年 onwer. All rights reserved.
//

#import "AddressPickerView.h"
#import "UIView+Category.h"
#import "NSArray+category.h"

@interface AddressPickerView()<UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) UIView *baseView;
@property (nonatomic, strong) UIView *backgroudView;
@property (nonatomic, strong) UIPickerView *myPicker;
@property (nonatomic, strong) NSDictionary *pickerDic;
@property (nonatomic, strong) NSArray *selectedArray;

@property (nonatomic, strong) NSArray *provinceArray;
@property (nonatomic, strong) NSArray *cityArray;
@property (nonatomic, strong) NSArray *townArray;

@property (nonatomic, copy) GetAddressBlock addressBlock;


@end

@implementation AddressPickerView

+ (void)showPickerViewWithAddressBlock:(GetAddressBlock )addressBlock {
    AddressPickerView *picker = [AddressPickerView new];
    picker.addressBlock = addressBlock;
    [[UIApplication sharedApplication].keyWindow addSubview:picker];
    [picker showPickerView];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
    if (self) {
        [self getPickerData];
        [self addSubview:self.backgroudView];
        [self addSubview:self.baseView];
    }
    return self;
}

- (void)showPickerView {
    _baseView.frame = CGRectMake(0, kScreen_Height, kScreen_Height, 190);
    
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options:0
                     animations:^{
                         self.backgroudView.alpha = 0.3;
                         self.baseView.alpha = 1.0;
                         [_baseView setFrame:CGRectMake(0, kScreen_Height-190, kScreen_Width, 190)];
                     }
                     completion:^(BOOL finished) {
                         
                     }];
}

- (void)hideMyPicker {
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroudView.alpha = 0;
        self.baseView.top = kScreen_Height;
    } completion:^(BOOL finished) {
        [self.backgroudView removeFromSuperview];
        [self removeFromSuperview];
    }];
}

- (UIPickerView *)myPicker {
    if (!_myPicker) {
        _myPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 30, kScreen_Width, 160)];
        _myPicker.backgroundColor = [UIColor whiteColor];
        _myPicker.delegate = self;
        _myPicker.dataSource = self;
    }
    return _myPicker;
}

- (UIView *)baseView {
    if (!_baseView) {
        _baseView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 190)];
        _baseView.backgroundColor = [UIColor whiteColor];
        UIButton *confirmBtn = [UIButton new];
        [confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
        [confirmBtn.titleLabel setFont:[UIFont systemFontOfSize:18.0f]];
        [confirmBtn sizeToFit];
        [confirmBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [confirmBtn addTarget:self action:@selector(ensureBtn) forControlEvents:UIControlEventTouchUpInside];
        confirmBtn.left = 10;
        confirmBtn.top = 0;
        [_baseView addSubview:confirmBtn];
        
        UIButton *cancelBtn = [UIButton new];
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBtn.titleLabel setFont:[UIFont systemFontOfSize:18.0f]];
        [cancelBtn sizeToFit];
        [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(hideMyPicker) forControlEvents:UIControlEventTouchUpInside];
        cancelBtn.right = kScreen_Width - 10;
        cancelBtn.top = 0;
        [_baseView addSubview:cancelBtn];
        
        [_baseView addSubview:self.myPicker];
        
    }
    return _baseView;
}

- (UIView *)backgroudView {
    if (!_backgroudView) {
        _backgroudView = [[UIView alloc] initWithFrame:kScreen_Frame];
        _backgroudView.backgroundColor = [UIColor blackColor];
        _backgroudView.alpha = 0;
        [_backgroudView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideMyPicker)]];
    }
    return _backgroudView;
}

- (void)ensureBtn {
    NSString *provinceStr = [self.provinceArray objectOrNilAtIndex:[self.myPicker selectedRowInComponent:0]];
    NSString *cityStr = [self.cityArray objectOrNilAtIndex:[self.myPicker selectedRowInComponent:1]];
    NSString *townStr = [self.townArray objectOrNilAtIndex:[self.myPicker selectedRowInComponent:2]];
    if (!townStr) {
        townStr = @"";
    }
    NSString *selectedAddress = [NSString stringWithFormat:@"%@%@%@",provinceStr,cityStr,townStr];
    self.addressBlock(cityStr);
    [self hideMyPicker];
}

#pragma mark - get data

- (void)getPickerData {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Address" ofType:@"plist"];
    self.pickerDic = [[NSDictionary alloc] initWithContentsOfFile:path];
    self.provinceArray = [self.pickerDic allKeys];
    self.selectedArray = [self.pickerDic objectForKey:[[self.pickerDic allKeys] objectAtIndex:0]];
    
    if (self.selectedArray.count > 0) {
        self.cityArray = [[self.selectedArray objectAtIndex:0] allKeys];
    }
    
    if (self.cityArray.count > 0) {
        self.townArray = [[self.selectedArray objectAtIndex:0] objectForKey:[self.cityArray objectAtIndex:0]];
    }
    
}

#pragma mark - UIPicker Delegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return self.provinceArray.count;
    } else if (component == 1) {
        return self.cityArray.count;
    } else {
        return self.townArray.count;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {
        return [self.provinceArray objectAtIndex:row];
    } else if (component == 1) {
        return [self.cityArray objectAtIndex:row];
    } else {
        return [self.townArray objectAtIndex:row];
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    if (component == 0) {
        
        return 110;
    } else if (component == 1) {
        return 100;
    } else {
        return 110;
    }
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        if (component == 0) {
            [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        }else{
            [pickerLabel setTextAlignment:NSTextAlignmentLeft];
        }
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:20]];
        [pickerLabel setTextColor:[UIColor blackColor]];
    }
    // Fill the label text here
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        self.selectedArray = [self.pickerDic objectForKey:[self.provinceArray objectAtIndex:row]];
        if (self.selectedArray.count > 0) {
            self.cityArray = [[self.selectedArray objectAtIndex:0] allKeys];
        } else {
            self.cityArray = nil;
        }
        if (self.cityArray.count > 0) {
            self.townArray = [[self.selectedArray objectAtIndex:0] objectForKey:[self.cityArray objectAtIndex:0]];
        } else {
            self.townArray = nil;
        }
        [pickerView selectRow:0 inComponent:1 animated:NO];
    }
    [pickerView selectedRowInComponent:1];
    [pickerView reloadComponent:1];
    [pickerView selectedRowInComponent:2];
    if (component == 1) {
        if (self.selectedArray.count > 0 && self.cityArray.count > 0) {
            self.townArray = [[self.selectedArray objectAtIndex:0] objectForKey:[self.cityArray objectAtIndex:row]];
        } else {
            self.townArray = nil;
        }
        [pickerView selectRow:1 inComponent:2 animated:YES];
    }
    
    [pickerView reloadComponent:2];
}

@end
