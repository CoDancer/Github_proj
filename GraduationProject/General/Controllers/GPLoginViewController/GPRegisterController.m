//
//  GPRegisterController.m
//  GraduationProject
//
//  Created by onwer on 15/11/26.
//  Copyright © 2015年 onwer. All rights reserved.
//

#import "GPRegisterController.h"
#import "GPInputField.h"
#import "GPSigninViewController.h"
#import "TLAlertView.h"

#define offsetLeftHand      60
#define RegisterWithPhoneType 1

@interface GPRegisterController()<UITextFieldDelegate>
{
    RegisterShowType showType;
}

@property (nonatomic, strong) UIImageView *imgLeftHand;
@property (nonatomic, strong) UIImageView *imgRightHand;
@property (nonatomic, strong) UIImageView *imgLeftHandGone;
@property (nonatomic, strong) UIImageView *imgRightHandGone;

@property (nonatomic, strong) UIButton *codeBtn;
@property (nonatomic, strong) NSString *phone;


@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger time;

@end

@implementation GPRegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = _weatherResetPassword ? @"重置密码" : @"注册";
    [self configView];
}
- (void)configView {
    
    [self addDynamicImageView];
    [self addRegisterView];
}

#pragma mark -- configView
- (void)addDynamicImageView {
    _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, (SCREEN_HEIGHT - 64)/4.0)];
    
    UIImageView* imgLogin = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"owl-login"]];
    imgLogin.bottom = _topView.size.height + 10;
    imgLogin.centerX = _topView.centerX;
    imgLogin.layer.masksToBounds = YES;
    [_topView addSubview:imgLogin];
    
    self.imgLeftHand = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"owl-login-arm-left"]];
    self.imgLeftHand.left = 0;
    self.imgLeftHand.bottom = imgLogin.size.height + 45;
    [imgLogin addSubview:self.imgLeftHand];
    
    self.imgRightHand = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"owl-login-arm-right"]];
    self.imgRightHand.right = imgLogin.size.width;
    self.imgRightHand.bottom = self.imgLeftHand.bottom;
    [imgLogin addSubview:self.imgRightHand];
    
    self.imgLeftHandGone = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.imgLeftHand.size.width, 40)];
    self.imgLeftHandGone.image = [UIImage imageNamed:@"hands"];
    self.imgLeftHandGone.left = 0;
    self.imgLeftHandGone.bottom = imgLogin.size.height + 8;
    [imgLogin addSubview:self.imgLeftHandGone];
    
    self.imgRightHandGone = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.imgLeftHand.size.width, 40)];
    self.imgRightHandGone.image = [UIImage imageNamed:@"hands"];
    self.imgRightHandGone.right = imgLogin.size.width;
    self.imgRightHandGone.bottom = self.imgLeftHandGone.bottom;
    [imgLogin addSubview:self.imgRightHandGone];
    
    [self.view addSubview:_topView];
}

- (void)addRegisterView {
    _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, _topView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT/3.0)];
    
    GPInputField *teleNumInputField = [[GPInputField alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 120, 35)];
    teleNumInputField.inputField.delegate = self;
    teleNumInputField.inputField.tag = registerTeleNumInputFieldTag;
    teleNumInputField.placeHolder = @"请输入手机号码";
    teleNumInputField.leftImage = [UIImage imageNamed:@"login_tel"];
    teleNumInputField.textFont = 14.0f;
    teleNumInputField.keyboardType = UIKeyboardTypeNumberPad;
    teleNumInputField.left = self.view.left + 20;
    teleNumInputField.top = 0;
    [_bottomView addSubview:teleNumInputField];
    
    _codeBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 35)];
    _codeBtn.centerY = teleNumInputField.centerY;
    [_codeBtn setTitle:@"验证码" forState:UIControlStateNormal];
    [_codeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_codeBtn addTarget:self action:@selector(getCodeWithPhone:) forControlEvents:UIControlEventTouchUpInside];
    [_codeBtn setBackgroundColor:MainColor];
    [_codeBtn.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
    _codeBtn.left = teleNumInputField.right + 5;
    [_bottomView addSubview:_codeBtn];
    
    GPInputField *codeInField = [[GPInputField alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 40, 35)];
    codeInField.inputField.tag = registerCodeInputFieldTag;
    codeInField.keyboardType = UIKeyboardTypeNumberPad;
    codeInField.inputField.delegate = self;
    codeInField.placeHolder = @"请输入手机验证码";
    codeInField.textFont = 14.0f;
    codeInField.left = self.view.left + 20;
    codeInField.top = teleNumInputField.bottom + 10;
    [_bottomView addSubview:codeInField];
    
    GPInputField *passwordInField = [[GPInputField alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 40, 35)];
    passwordInField.inputField.delegate = self;
    passwordInField.inputField.tag = registerPWInputFieldTag;
    passwordInField.placeHolder = _weatherResetPassword ? @"请输入新的密码" : @"请输入密码";
    passwordInField.leftImage = [UIImage imageNamed:@"login_password"];
    passwordInField.securityType = YES;
    passwordInField.textFont = 14.0f;
    passwordInField.left = self.view.left + 20;
    passwordInField.top = codeInField.bottom + 10;
    [_bottomView addSubview:passwordInField];
    
    UIButton *registerBt = [[UIButton alloc] initWithFrame:CGRectMake(20, 0, SCREEN_WIDTH - 40, [[UIImage imageNamed:@"gen_btn"] size].height)];
    [registerBt setTitle:_weatherResetPassword ? @"完成" : @"注册" forState:UIControlStateNormal];
    registerBt.backgroundColor = MainColor;
    registerBt.tag = registerBtnTag;
    [registerBt addTarget:self action:@selector(registerViewButtonTap:) forControlEvents:UIControlEventTouchUpInside];
    registerBt.titleLabel.font = [UIFont systemFontOfSize:17.0f];
    [registerBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    registerBt.centerX = _topView.centerX;
    registerBt.top = passwordInField.bottom + 10;
    [_bottomView addSubview:registerBt];
    
    [self.view addSubview:_bottomView];
}
#pragma mark -- buttonDidTap
- (void)registerViewButtonTap:(UIButton *)sender {
    
    if (![self checkTeleNum] || ![self checkPhoneCode] || ![self checkPassword]) {
        return;
    }
    NSDictionary *params = [self getParamsAfterTextFieldResignFirstResponder];
    [UIHelper showHUDAddedTo:self.view animated:YES];
    __weak typeof(self) weakSelf = self;
    [[GPSignInClient sharedClient] userRegisterWithParam:params success:^(id responseObject) {
        if (_weatherResetPassword) {
            [UIHelper showAutoHideHUDforView:weakSelf.view title:@"重置成功" subTitle:nil];
        }else {
            [UIHelper showAutoHideHUDforView:weakSelf.view title:@"注册成功" subTitle:nil];
        }
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSString *userID =[responseObject objectForKey:@"user_id"];
        [userDefaults setObject:_phone forKey:@"phone"];
        [userDefaults setObject:userID forKey:@"user_id"];
        [userDefaults synchronize];
        UIViewController *vc = nil;
        for (UIViewController *v in weakSelf.navigationController.viewControllers) {
            if ([v isKindOfClass:[GPSigninViewController class]]) {
                vc = v;
                break;
            }
        }
        if (vc) {
            if (weakSelf.telePwBlock) {
                weakSelf.telePwBlock(params[@"phone"],params[@"password"]);
            }
            [weakSelf.navigationController popToViewController:vc animated:YES];
        }
        
    } failure:^(NSError *error) {
        if (_weatherResetPassword) {
            [UIHelper showAutoHideErrorHUDforView:weakSelf.view error:error defaultNotice:@"重置失败"];
        }else {
            [UIHelper showAutoHideErrorHUDforView:weakSelf.view error:error defaultNotice:@"注册失败"];
        }
        
    }];
    
}
- (NSDictionary *)getParamsAfterTextFieldResignFirstResponder {
    UITextField *teleField = (UITextField *)[self.view viewWithTag:registerTeleNumInputFieldTag];
    UITextField *codeField = (UITextField *)[self.view viewWithTag:registerCodeInputFieldTag];
    UITextField *passwordField = (UITextField *)[self.view viewWithTag:registerPWInputFieldTag];
    [teleField resignFirstResponder];
    [codeField resignFirstResponder];
    [passwordField resignFirstResponder];
    _phone = teleField.text;
    
    return @{@"phone":teleField.text,
             @"code":codeField.text,
             @"password":passwordField.text};
}

- (void)getCodeWithPhone:(UIButton *)sender {
    if (![self checkTeleNum]) {
        return;
    }
    UITextField *teleField = (UITextField *)[self.view viewWithTag:registerTeleNumInputFieldTag];
    NSDictionary *params = @{@"phone" : teleField.text, @"type" : @(RegisterWithPhoneType)};
    __weak typeof(self) weakSelf = self;
    [[GPSignInClient sharedClient] fetchCodeWithPohoneWithParam:params success:^(id responseObject) {
        NSLog(@"ok");
        [UIHelper showAutoHideHUDforView:weakSelf.view title:@"发送成功" subTitle:nil];
        [weakSelf startTimer];
        [weakSelf getTestCode];
    } failure:^(NSError *error) {
        [UIHelper showAutoHideErrorHUDforView:weakSelf.view error:error defaultNotice:@"发送失败"];
    }];
}
- (void)getTestCode {
    [self.view endEditing:YES];
    TLAlertView *alert = [[TLAlertView alloc] initWithTitle:@"提示" message:@"为了测试的方便，手机验证码为：123456" buttonTitle:@"确定"];
    [alert show];
}
#pragma mark codeBtnTimeDiscount
- (void)startTimer {
    self.time = 60;
    if (self.timer.isValid) {
        [self.timer invalidate];
    }
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(refreshCodeText) userInfo:nil repeats:YES];
    [self.timer fire];
}

- (void)refreshCodeText {
    [self refreshCodeTextWithSeconds:self.time];
    if (self.time == -1) {
        [self.timer invalidate];
    }
    self.time--;
}

- (void)refreshCodeTextWithSeconds:(NSInteger)seconds {
    
    if (seconds >= 0) {
        [self.codeBtn setTitle:[NSString stringWithFormat:@"%ld秒后重试", (long)seconds] forState:UIControlStateNormal];
        self.codeBtn.enabled = NO;
    } else {
        [self.codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        self.codeBtn.enabled = YES;
    }
}
#pragma mark -- checkTextFieldState
- (BOOL)checkTeleNum{
    UITextField *teleField = (UITextField *)[self.view viewWithTag:registerTeleNumInputFieldTag];
    if(teleField.text.length > 0){
        if ([NSString CheckPhonenumberInput:teleField.text]) {
            return YES;
        }else{
            [self dismissLoadingHUDWithFailureText:@"请输入正规的手机号"];
        }
    }else{
        [self dismissLoadingHUDWithFailureText:@"请输入手机号"];
    }
    return NO;
}
- (BOOL)checkPhoneCode {
    UITextField *codeField = (UITextField *)[self.view viewWithTag:registerCodeInputFieldTag];
    if(codeField.text.length == 0) {
        [self dismissLoadingHUDWithFailureText:@"请输入手机验证码"];
        return NO;
    }
    return YES;
}
- (BOOL)checkPassword {
    UITextField *passwordField = (UITextField *)[self.view viewWithTag:registerPWInputFieldTag];
    if(passwordField.text.length== 0) {
        [self dismissLoadingHUDWithFailureText:@"请输入密码"];
        return NO;
    }
    return YES;
}

#pragma mark -- Delegate
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    if([[self.view viewWithTag:registerPWInputFieldTag] resignFirstResponder] ||
       [[self.view viewWithTag:registerCodeInputFieldTag] resignFirstResponder]){
        [self putDownHands];
    }
    [[self.view viewWithTag:registerTeleNumInputFieldTag] resignFirstResponder];
    [[self.view viewWithTag:registerCodeInputFieldTag] resignFirstResponder];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    if ([textField isEqual:[self.view viewWithTag:registerTeleNumInputFieldTag]]) {
        [self putDownHands];
    }
    else if ([textField isEqual:[self.view viewWithTag:registerPWInputFieldTag]]) {
        [self turnBackEyes];
    } else if ([textField isEqual:[self.view viewWithTag:registerCodeInputFieldTag]]) {
        [self turnBackEyes];
    }
}

#pragma mark -- animation
- (void)putDownHands{
    if (showType != RegisterShowType_PASS)
    {
        showType = RegisterShowType_USER;
        return;
    }
    showType = RegisterShowType_USER;
    [UIView animateWithDuration:0.5 animations:^{
        self.imgLeftHand.frame = CGRectMake(self.imgLeftHand.frame.origin.x - offsetLeftHand, self.imgLeftHand.frame.origin.y + 30, self.imgLeftHand.frame.size.width, self.imgLeftHand.frame.size.height);
        
        self.imgRightHand.frame = CGRectMake(self.imgRightHand.frame.origin.x + 52, self.imgRightHand.frame.origin.y + 30, self.imgRightHand.frame.size.width, self.imgRightHand.frame.size.height);
        
        
        self.imgLeftHandGone.frame = CGRectMake(self.imgLeftHandGone.frame.origin.x - 70, self.imgLeftHandGone.frame.origin.y, 40, 40);
        
        self.imgRightHandGone.frame = CGRectMake(self.imgRightHandGone.frame.origin.x + 30, self.imgRightHandGone.frame.origin.y, 40, 40);
        
        
    } completion:^(BOOL b) {
    }];
}
- (void)turnBackEyes{
    if (showType == RegisterShowType_PASS)
    {
        showType = RegisterShowType_PASS;
        return;
    }
    showType = RegisterShowType_PASS;
    [UIView animateWithDuration:0.5 animations:^{
        self.imgLeftHand.frame = CGRectMake(self.imgLeftHand.frame.origin.x + offsetLeftHand, self.imgLeftHand.frame.origin.y - 30, self.imgLeftHand.frame.size.width, self.imgLeftHand.frame.size.height);
        self.imgRightHand.frame = CGRectMake(self.imgRightHand.frame.origin.x - 52, self.imgRightHand.frame.origin.y - 30, self.imgRightHand.frame.size.width, self.imgRightHand.frame.size.height);
        
        
        self.imgLeftHandGone.frame = CGRectMake(self.imgLeftHandGone.frame.origin.x + 70, self.imgLeftHandGone.frame.origin.y, 0, 0);
        
        self.imgRightHandGone.frame = CGRectMake(self.imgRightHandGone.frame.origin.x - 30, self.imgRightHandGone.frame.origin.y, 0, 0);
        
    } completion:^(BOOL b) {
    }];
}


@end
