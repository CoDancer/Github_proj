//
//  GPLoginViewController.m
//  GraduationProject
//
//  Created by onwer on 15/11/25.
//  Copyright © 2015年 onwer. All rights reserved.
//

#import "GPSigninViewController.h"
#import "GPInputField.h"
#import "GPPrepareLogin.h"
#import "GPRegisterController.h"
#import "GPResetPasswordController.h"

#define offsetLeftHand      60

@interface GPSigninViewController ()<UITextFieldDelegate>
{
    BYLoginShowType showType;
}

@property (nonatomic, strong) UIImageView *imgLeftHand;
@property (nonatomic, strong) UIImageView *imgRightHand;
@property (nonatomic, strong) UIImageView *imgLeftHandGone;
@property (nonatomic, strong) UIImageView *imgRightHandGone;

@property (nonatomic, strong) NSString *telePhone;
@property (nonatomic, strong) NSString *password;

@end

@implementation GPSigninViewController

#pragma mark -- cycle and configView
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self config];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)config{
    self.hidesBottomBarWhenPushed = YES;
    self.title = @"登录";
    UIView *topContainer = [self topContainerView];
    UIView *bottomContainer = [UIView new];
    
    [self.view setBackgroundColor:[UIColor colorWithHexString:@"f3f3f3"]];
    [self.view addSubview:topContainer];
    
    bottomContainer = ({
        UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, topContainer.bottom, SCREEN_WIDTH, 0)];;
        bottomView.left = self.view.left;
        bottomView.right = self.view.right;
        bottomView.width = SCREEN_WIDTH;
        bottomView.height = self.view.size.height - topContainer.size.height - 64;
        
        UIView *loginBottomView = [UIView new];
        UIButton *qqButton = [UIButton new];
        [qqButton setImage:[UIImage imageNamed:@"gen_share_qq"] forState:UIControlStateNormal];
        [qqButton sizeToFit];
        qqButton.tag = qqLoginBtTag;
        loginBottomView.frame = CGRectMake(10, 0, SCREEN_WIDTH - 10*2, qqButton.size.height + 20);
        loginBottomView.bottom = bottomView.size.height - 40;
        
        UIButton *wechatButton = [UIButton new];
        [wechatButton setImage:[UIImage imageNamed:@"gen_share_wechat"] forState:UIControlStateNormal];
        [wechatButton sizeToFit];
        wechatButton.tag = wechatLoginBtTag;
        
        UIButton *weiboButton = [UIButton new];
        [weiboButton setImage:[UIImage imageNamed:@"gen_share_weibo"] forState:UIControlStateNormal];
        [weiboButton sizeToFit];
        weiboButton.tag = weiboLoginBtTag;
        
        UIButton *lookFirstBt = [UIButton new];
        lookFirstBt.tag = lookFirstTag;
        [lookFirstBt setTitle:@"先睹为快 >>" forState:UIControlStateNormal];
        [lookFirstBt setTitleColor:MainColor forState:UIControlStateNormal];
        [lookFirstBt.titleLabel setFont:[UIFont systemFontOfSize:16.0f]];
        [lookFirstBt addTarget:self action:@selector(loginViewButtonTap:) forControlEvents:UIControlEventTouchUpInside];
        [lookFirstBt sizeToFit];
        
        NSInteger margen = (SCREEN_WIDTH - 3*60 - 40*2)/2;
        qqButton.left = margen - 10;
        wechatButton.left = qqButton.right + 40;
        weiboButton.left = wechatButton.right + 40;
        qqButton.centerY = wechatButton.centerY = weiboButton.centerY = loginBottomView.size.height/2;
        
        lookFirstBt.top = loginBottomView.bottom + 5;
        lookFirstBt.right = bottomView.right - 10;
        
        [qqButton addTarget:self action:@selector(loginViewButtonTap:) forControlEvents:UIControlEventTouchUpInside];
        [wechatButton addTarget:self action:@selector(loginViewButtonTap:) forControlEvents:UIControlEventTouchUpInside];
        [weiboButton addTarget:self action:@selector(loginViewButtonTap:) forControlEvents:UIControlEventTouchUpInside];
        
        [loginBottomView addSubview:qqButton];
        [loginBottomView addSubview:wechatButton];
        [loginBottomView addSubview:weiboButton];
        [bottomView addSubview:loginBottomView];
        [bottomView addSubview:lookFirstBt];
        
        UILabel *thirdLabel = [UILabel new];
        thirdLabel.text = @"第三方登录";
        thirdLabel.font = [UIFont systemFontOfSize:17.0f];
        [thirdLabel sizeToFit];
        thirdLabel.bottom = loginBottomView.origin.y - 10;
        thirdLabel.centerX = topContainer.centerX;
        [bottomView addSubview:thirdLabel];
        
        bottomView;
    });
    [self.view addSubview:bottomContainer];
}
- (UIView *)topContainerView {
    UIView *topContainer = [UIView new];
    topContainer = ({
        UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 0)];
        topView.left = self.view.left;
        topView.right = self.view.right;
        topView.height = self.view.height * 2 /3.0 - 64;
        
        
        UIView *bottomView = [UIView new];
        GPInputField *teleNumInputField = [[GPInputField alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 40, 35)];
        teleNumInputField.inputField.delegate = self;
        teleNumInputField.inputField.tag = teleNumInputFieldTag;
        teleNumInputField.tag = teleNumFieldTag;
        teleNumInputField.placeHolder = @"请输入手机号码";
        teleNumInputField.leftImage = [UIImage imageNamed:@"login_tel"];
        teleNumInputField.textFont = 14.0f;
        teleNumInputField.keyboardType = UIKeyboardTypeNumberPad;
        teleNumInputField.left = self.view.left + 20;
        teleNumInputField.top = 0;
        
        GPInputField *passwordInField = [[GPInputField alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 40, 35)];
        passwordInField.tag = pwFieldTag;
        passwordInField.inputField.delegate = self;
        passwordInField.inputField.tag = pwInputFieldTag;
        passwordInField.placeHolder = @"请输入密码";
        passwordInField.leftImage = [UIImage imageNamed:@"login_password"];
        passwordInField.securityType = YES;
        passwordInField.textFont = 14.0f;
        passwordInField.left = self.view.left + 20;
        passwordInField.top = teleNumInputField.bottom + 10;
        
        UIButton *commitBt = [[UIButton alloc] initWithFrame:CGRectMake(20, 0, SCREEN_WIDTH - 40, [[UIImage imageNamed:@"gen_btn"] size].height)];
        [commitBt setTitle:@"提交" forState:UIControlStateNormal];
        commitBt.backgroundColor = MainColor;
        [commitBt setBackgroundImage:[UIImage imageNamed:@"gen_btn_cancel"] forState:UIControlStateHighlighted];
        commitBt.tag = commitBtTag;
        [commitBt addTarget:self action:@selector(loginViewButtonTap:) forControlEvents:UIControlEventTouchUpInside];
        commitBt.titleLabel.font = [UIFont systemFontOfSize:17.0f];
        [commitBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        commitBt.centerX = topView.centerX;
        commitBt.top = passwordInField.bottom + 10;
        
        UIButton *registerBt = [UIButton new];
        registerBt.tag = registerBtTag;
        [registerBt setTitle:@"注册" forState:UIControlStateNormal];
        [registerBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [registerBt addTarget:self action:@selector(loginViewButtonTap:) forControlEvents:UIControlEventTouchUpInside];
        [registerBt.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
        [registerBt sizeToFit];
        
        UIButton *forgetPwBt = [UIButton new];
        forgetPwBt.tag = forgetPwBtTag;
        [forgetPwBt setTitle:@"忘记密码？" forState:UIControlStateNormal];
        [forgetPwBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [forgetPwBt addTarget:self action:@selector(loginViewButtonTap:) forControlEvents:UIControlEventTouchUpInside];
        [forgetPwBt.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
        [forgetPwBt sizeToFit];
        
        bottomView.top = 20;
        bottomView.height = teleNumInputField.size.height * 2 + commitBt.size.height + forgetPwBt.size.height + (SCREEN_HEIGHT > 568 ? 20 * 3 :10 * 3);
        bottomView.width = SCREEN_WIDTH;
        if (SCREEN_HEIGHT >= 568) {
            bottomView.height = bottomView.size.height + 20;
            passwordInField.top = teleNumInputField.bottom + 20;
            commitBt.top = passwordInField.bottom + 20;
            bottomView.bottom = topView.size.height;
        }else{
            bottomView.bottom = topView.size.height;
        }
        
        UIView *imageViewBottom = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, topView.size.height - bottomView.size.height)];
        UIImageView* imgLogin = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"owl-login"]];
        imgLogin.bottom = imageViewBottom.size.height + 10;
        imgLogin.centerX = topView.centerX;
        imgLogin.layer.masksToBounds = YES;
        [imageViewBottom addSubview:imgLogin];
        
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
        
        registerBt.top = commitBt.bottom + 10;
        registerBt.left = topView.left + 20;
        forgetPwBt.top = registerBt.top;
        forgetPwBt.right = topView.right - 20;
        
        [topView addSubview:imageViewBottom];
        [bottomView addSubview:passwordInField];
        [bottomView addSubview:teleNumInputField];
        [bottomView addSubview:registerBt];
        [bottomView addSubview:forgetPwBt];
        [bottomView addSubview:commitBt];
        [bottomView setBackgroundColor:[UIColor clearColor]];
        
        [topView addSubview:bottomView];
        topView;
    });
    return topContainer;
}
#pragma custom Method
- (void)loginViewButtonTap:(UIButton *)sender{
    if (sender.tag == commitBtTag) {
        [self.view endEditing:YES];
        [self putDownHands];
        if ([self checkInputInfo]) {
            [self userLogin];
        }
    }else if (sender.tag == registerBtTag){
        //注册
        GPRegisterController *vc = [GPRegisterController new];
        [self initPhoneAndPWWithBlockController:vc];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (sender.tag == forgetPwBtTag){
        //忘记密码
        GPRegisterController *vc = [GPRegisterController new];
        vc.weatherResetPassword = YES;
        [self initPhoneAndPWWithBlockController:vc];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (sender.tag == qqLoginBtTag){
        //qq_login
    }else if (sender.tag == wechatLoginBtTag){
        //wechat_login
    }else if (sender.tag == weiboLoginBtTag){
        //weibo_login
    }else if (sender.tag == lookFirstTag){
        [GPPrepareLogin showMainTabBarViewController];
    }
    
}
- (void)userLogin {
    NSDictionary *params = @{@"phone":_telePhone,@"password":_password};
    __weak typeof(self) weakSelf = self;
    [UIHelper showHUDAddedTo:weakSelf.view animated:YES];
    [[GPSignInClient sharedClient] userLoginWithParam:params success:^(id responseObject) {
        [GPPrepareLogin showMainTabBarViewController];
    } failure:^(NSError *error) {
        [UIHelper showAutoHideErrorHUDforView:weakSelf.view error:error defaultNotice:@"登录失败"];
    }];
    
}
- (void)initPhoneAndPWWithBlockController:(GPRegisterController *)vc {
    vc.telePwBlock = ^(NSString *teleStr, NSString *password){
        _telePhone = teleStr;
        _password = password;
        UITextField *teleField = (UITextField *)[self.view viewWithTag:teleNumInputFieldTag];
        UITextField *pwField = (UITextField *)[self.view viewWithTag:pwInputFieldTag];
        teleField.text = teleStr;
        pwField.text = password;
    };
}

- (BOOL)checkInputInfo{
    if ([self checkTeleNum] && [self checkPassword]) {
        return YES;
    }
    return NO;
}
- (BOOL)checkTeleNum{
    GPInputField *teleField = (GPInputField *)[self.view viewWithTag:teleNumFieldTag];
    if(teleField.text.length > 0){
        if ([NSString CheckPhonenumberInput:teleField.text]) {
            _telePhone = teleField.text;
            return YES;
        }else{
            [self dismissLoadingHUDWithFailureText:@"请输入正规的手机号"];
        }
    }else{
        [self dismissLoadingHUDWithFailureText:@"请输入手机号"];
    }
    return NO;
}
- (BOOL)checkPassword{
    GPInputField *pwField = (GPInputField *)[self.view viewWithTag:pwFieldTag];
    if (pwField.text.length > 0) {
        if ([NSString CheckPasswordInput:pwField.text]) {
            _password = pwField.text;
            return YES;
        }else{
            [self dismissLoadingHUDWithFailureText:@"请输入6-12密码"];
        }
    }else{
        [self dismissLoadingHUDWithFailureText:@"请输入正确密码"];
    }
    return NO;
}

#pragma mark -- Delegate
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    //[[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    if([[self.view viewWithTag:pwInputFieldTag] resignFirstResponder]){
        [self putDownHands];
    }
    [[self.view viewWithTag:teleNumInputFieldTag] resignFirstResponder];
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    if ([textField isEqual:[self.view viewWithTag:teleNumInputFieldTag]]) {
        [self putDownHands];
    }
    else if ([textField isEqual:[self.view viewWithTag:pwInputFieldTag]]) {
        [self turnBackEyes];
    }
}
#pragma mark -- animation
- (void)putDownHands{
    if (showType != BYLoginShowType_PASS)
    {
        showType = BYLoginShowType_USER;
        return;
    }
    showType = BYLoginShowType_USER;
    [UIView animateWithDuration:0.5 animations:^{
        self.imgLeftHand.frame = CGRectMake(self.imgLeftHand.frame.origin.x - offsetLeftHand, self.imgLeftHand.frame.origin.y + 30, self.imgLeftHand.frame.size.width, self.imgLeftHand.frame.size.height);
        
        self.imgRightHand.frame = CGRectMake(self.imgRightHand.frame.origin.x + 52, self.imgRightHand.frame.origin.y + 30, self.imgRightHand.frame.size.width, self.imgRightHand.frame.size.height);
        
        
        self.imgLeftHandGone.frame = CGRectMake(self.imgLeftHandGone.frame.origin.x - 70, self.imgLeftHandGone.frame.origin.y, 40, 40);
        
        self.imgRightHandGone.frame = CGRectMake(self.imgRightHandGone.frame.origin.x + 30, self.imgRightHandGone.frame.origin.y, 40, 40);
        
        
    } completion:^(BOOL b) {
    }];
}
- (void)turnBackEyes{
    if (showType == BYLoginShowType_PASS)
    {
        showType = BYLoginShowType_PASS;
        return;
    }
    showType = BYLoginShowType_PASS;
    [UIView animateWithDuration:0.5 animations:^{
        self.imgLeftHand.frame = CGRectMake(self.imgLeftHand.frame.origin.x + offsetLeftHand, self.imgLeftHand.frame.origin.y - 30, self.imgLeftHand.frame.size.width, self.imgLeftHand.frame.size.height);
        self.imgRightHand.frame = CGRectMake(self.imgRightHand.frame.origin.x - 52, self.imgRightHand.frame.origin.y - 30, self.imgRightHand.frame.size.width, self.imgRightHand.frame.size.height);
        
        
        self.imgLeftHandGone.frame = CGRectMake(self.imgLeftHandGone.frame.origin.x + 70, self.imgLeftHandGone.frame.origin.y, 0, 0);
        
        self.imgRightHandGone.frame = CGRectMake(self.imgRightHandGone.frame.origin.x - 30, self.imgRightHandGone.frame.origin.y, 0, 0);
        
    } completion:^(BOOL b) {
    }];
}



@end
