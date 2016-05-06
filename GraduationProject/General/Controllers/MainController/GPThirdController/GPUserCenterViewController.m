//
//  GPUserCenterViewController.m
//  GraduationProject
//
//  Created by CoDancer on 15/12/20.
//  Copyright © 2015年 onwer. All rights reserved.
//

#import "GPUserCenterViewController.h"
#import "UIImageView+WebCache.h"
#import "UserLogoView.h"
#import "JGActionSheet+GPAddition.h"
#import "SystemPermission.h"
#import "MBProgressHUD.h"
#import "NSFileManager+Catrgory.h"
#import "UserCell.h"
#import "DisperseBtn.h"
#import "ModifyUserInfoView.h"
#import "GPAlertView.h"
#import "DrawAlertView.h"

@interface GPUserCenterViewController ()<UIImagePickerControllerDelegate,
                                        UINavigationControllerDelegate,
                                        UITableViewDelegate,
                                        UITableViewDataSource>

@property (nonatomic, strong) UserLogoView *logoView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *staticArr;
@property (nonatomic, strong) DisperseBtn *disperseBtn;
@property (nonatomic, assign) BOOL isModifyBGI;
@property (nonatomic, strong) NSArray *logoImageArr;
@property (nonatomic, strong) CADisplayLink *displayLink;

@end

@implementation GPUserCenterViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"f3f3f3"];
    self.logoView = [[UserLogoView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 220)];
    __weak typeof(self) weakSelf = self;
    self.logoView.popBlock = ^(){
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    self.logoView.tapBlack = ^(){
        weakSelf.isModifyBGI = YES;
        [weakSelf userPageHeaderViewDidTapedWithTitle:@"更改背景图片"];
    };
    
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(handleAction:)];
    self.displayLink.frameInterval = 3;
    [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    
    [self.tableView registerClass:[UserCell class] forCellReuseIdentifier:@"userCell"];
    [self.view addSubview:self.logoView];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.disperseBtn];
    [self setDisViewButtons];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(10, self.logoView.height + 10,
                                                                   SCREEN_WIDTH - 20, SCREEN_HEIGHT - 240 - 10)];
        _tableView.backgroundColor = [UIColor colorWithHexString:@"f3f3f3"];
        _tableView.layer.cornerRadius = 5.0;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.bounces = NO;
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (NSArray *)staticArr {
    
    if (!_staticArr) {
        _staticArr = @[@{@"image":[UIImage imageNamed:@"changImage"],@"content":@"自定义logo"},
                       @{@"image":[UIImage imageNamed:@"writeName"],@"content":@"修改称谓"},
                       @{@"image":[UIImage imageNamed:@"motto"],@"content":@"修改座右铭"},
                       @{@"image":[UIImage imageNamed:@"modifyGender"],@"content":@"性别"},
                       @{@"image":[UIImage imageNamed:@"writeAdvise"],@"content":@"我要吐槽"},
                       @{@"image":[UIImage imageNamed:@"clear"],@"content":@"清理缓存"},
                       @{@"image":[UIImage imageNamed:@"star"],@"content":@"星级评价"}];
    }
    return _staticArr;
}

- (DisperseBtn *)disperseBtn {
    
    if (!_disperseBtn) {
        _disperseBtn = [[DisperseBtn alloc] initWithFrame:CGRectMake(0, 0, 45, 45)];
        _disperseBtn.borderRect = self.view.frame;
        _disperseBtn.layer.cornerRadius = _disperseBtn.height/2.0;
        _disperseBtn.closeImage = [UIImage imageNamed:@"changImage"];
        _disperseBtn.openImage = [UIImage imageNamed:@"changImage"];
        _disperseBtn.right = SCREEN_WIDTH - 10;
        _disperseBtn.centerY = 42;
    }
    return _disperseBtn;
}

- (void)setDisViewButtons {
    
    [self.disperseBtn recoverBotton];
    
    for (UIView *btn in self.disperseBtn.btns) {
        [btn removeFromSuperview];
    }
    self.logoImageArr = @[@"mylogo1.jpg",@"mylogo2.jpg",@"mylogo3.jpg",@"mylogo4.jpg",@"mylogo5.jpg",];
    NSMutableArray *marr = [NSMutableArray array];
    for (int i = 0; i< self.logoImageArr.count; i++) {
        UIButton *btn = [UIButton new];
        [btn setBackgroundImage:[UIImage imageNamed:self.logoImageArr[i]] forState:UIControlStateNormal];
        [marr addObject:btn];
        btn.tag = i;
        [btn addTarget:self action:@selector(buttonTagget:) forControlEvents:UIControlEventTouchUpInside];
    }
    self.disperseBtn.btns = [marr copy];
}

-(void)buttonTagget:(UIButton *)sender{
    
    NSLog(@"%@",[NSString stringWithFormat:@"点击了第%ld个按钮",(long)sender.tag+1]);
    UIImage *logoImage = [UIImage imageNamed:self.logoImageArr[sender.tag]];
    NSData *imageData = UIImageJPEGRepresentation(logoImage, 0.8);
    [UserDefaults setObject:imageData forKey:@"logoImageData"];
    self.logoView.isModifyInfo = YES;
    [self.disperseBtn recoverBotton];
}

- (void)userPageHeaderViewDidTapedWithTitle:(NSString *)title {
    
    NSArray *titles = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] ? @[@"拍照", @"相册"] : @[@"相册"];
    __weak typeof(self) weakSelf = self;
    [JGActionSheet showActionSheetWithTitle:title buttonTitles:titles actionBlock:^(JGActionSheet *sheet, NSUInteger index) {
        JGActionSheetSection *section = sheet.sections.firstObject;
        NSString *title = [section.buttons[index] titleForState:UIControlStateNormal];
        UIImagePickerControllerSourceType sourceType = [title isEqualToString:@"拍照"] ? UIImagePickerControllerSourceTypeCamera : UIImagePickerControllerSourceTypePhotoLibrary;
        if ((sourceType == UIImagePickerControllerSourceTypeCamera && [SystemPermission cameraAuthorized]) ||
            (sourceType == UIImagePickerControllerSourceTypePhotoLibrary && [SystemPermission assetsAuthorized])) {
            UIImagePickerController *picker = [UIImagePickerController new];
            picker.delegate = weakSelf;
            picker.allowsEditing = YES;
            picker.mediaTypes = @[(NSString *)kUTTypeImage];
            picker.sourceType = sourceType;
            [weakSelf presentViewController:picker animated:YES completion:nil];
        }
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.staticArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UserCell *cell = [tableView dequeueReusableCellWithIdentifier:@"userCell"];
    if (cell == nil) {
        cell = [[UserCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:@"userCell"];
    }
    NSDictionary *dic = self.staticArr[indexPath.row];
    cell.dic = dic;
    if (indexPath.row == 3 || indexPath.row == 4) {
        cell.isSmallSize = YES;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        if ([UserDefaults objectForKey:@"iconImg"] != nil) {
            GPAlertView *alertView = [[GPAlertView alloc] initWithTitle:@"提示" message:@"您当前用第三方登录，不能修改logo!" buttons:@[@"确定"]];
            [alertView show];
        }else {
            self.isModifyBGI = NO;
            [self userPageHeaderViewDidTapedWithTitle:@"更换个人logo"];
        }
    }else if (indexPath.row == 1) {
        [self modifyUserName];
    }else if (indexPath.row == 2) {
        [self modifyUserMotto];
    }else if (indexPath.row == 4) {
        [self giveAdvice];
    }else if (indexPath.row == 5) {
        DrawAlertView *view = [[DrawAlertView alloc] initWithTitle:@"清理缓存成功!"];
        [view showInView:self.view];
    }
    
}

- (void)modifyUserName{
    
    if ([UserDefaults objectForKey:@"iconImg"] == nil) {
        ModifyUserInfoView *modifyView = [[ModifyUserInfoView alloc] initWihtCanEditTitle:@"修改名字:" message:@"请输入新的称谓" leftStr:@"取消" rightStr:@"确定"];
        modifyView.image = [UIImage imageNamed:@"writeName"];
        [modifyView show];
        __weak typeof(self) weakSelf = self;
        __weak typeof(modifyView) weakModifyView = modifyView;
        modifyView.actionBlock = ^(NSInteger idx){
            if (idx == 0) {
            }else {
                if (modifyView.fieldText.length != 0) {
                    [UserDefaults setObject:weakModifyView.fieldText forKey:@"userName"];
                    weakSelf.logoView.isModifyInfo = YES;
                }else {
                    GPAlertView *alertView = [[GPAlertView alloc] initWithTitle:@"提示" message:@"内容不能为空!" buttons:@[@"确定"]];
                    [alertView show];
                }
            }
        };
    }else {
        GPAlertView *alertView = [[GPAlertView alloc] initWithTitle:@"提示" message:@"您当前用第三方登录，不能修改名字!" buttons:@[@"确定"]];
        [alertView show];
    }
}

- (void)modifyUserMotto {
    
    if ([UserDefaults objectForKey:@"iconImg"] == nil) {
        ModifyUserInfoView *modifyView = [[ModifyUserInfoView alloc] initWihtTitle:@"修改座右铭" message:nil leftStr:@"取消" rightStr:@"确定"];
        modifyView.placeholder = @"请编辑您的宣言!";
        modifyView.image = [UIImage imageNamed:@"motto"];
        [modifyView show];
        __weak typeof(self) weakSelf = self;
        __weak typeof(modifyView) weakModifyView = modifyView;
        modifyView.actionBlock = ^(NSInteger idx){
            if (idx == 0) {
            }else {
                if (modifyView.text.length != 0) {
                    [UserDefaults setObject:weakModifyView.text forKey:@"motto"];
                    weakSelf.logoView.isModifyInfo = YES;
                }else {
                    GPAlertView *alertView = [[GPAlertView alloc] initWithTitle:@"提示" message:@"内容不能为空!" buttons:@[@"确定"]];
                    [alertView show];
                }
            }
        };
    }else {
        GPAlertView *alertView = [[GPAlertView alloc] initWithTitle:@"提示" message:@"您当前用第三方登录，不能修改名字!" buttons:@[@"确定"]];
        [alertView show];
    }
}

- (void)giveAdvice {
    
    ModifyUserInfoView *modifyView = [[ModifyUserInfoView alloc] initWihtTitle:@"我要吐槽" message:nil leftStr:@"取消" rightStr:@"提交"];
    modifyView.image = [UIImage imageNamed:@"writeAdvise"];
    modifyView.placeholder = @"请编辑您的旨意!";
    [modifyView show];
    modifyView.actionBlock = ^(NSInteger idx){
        if (idx == 0) {
        }else {
            if (modifyView.text.length != 0) {
                DrawAlertView *view = [[DrawAlertView alloc] initWithTitle:@"提交成功!"];
                [view showInView:self.view];
            }else {
                GPAlertView *alertView = [[GPAlertView alloc] initWithTitle:@"提示" message:@"内容不能为空!" buttons:@[@"确定"]];
                [alertView show];
            }
        }
    };
}

#pragma mark - UIImagePickerController Delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    NSData *imageData = UIImageJPEGRepresentation(editedImage, 0.8);
    if (self.isModifyBGI) {
        [UserDefaults setObject:imageData forKey:@"bgImageData"];
    }else {
        [UserDefaults setObject:imageData forKey:@"logoImageData"];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
    self.logoView.isModifyInfo = YES;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)navigationController:(UINavigationController *)navigationController
      willShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated {
    
    if ([navigationController isKindOfClass:[UIImagePickerController class]] && [UIDevice currentDevice].systemVersion.floatValue >= 7.0) {
    }
}

- (void)handleAction:(CADisplayLink *)displayLink {
    
    UIImage *image = [UIImage imageNamed:@"leaf"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    CGFloat scale = arc4random_uniform(70) / 100.0;
    imageView.transform = CGAffineTransformMakeScale(scale, scale);
    CGSize winSize = self.logoView.bounds.size;
    CGFloat x = arc4random_uniform(winSize.width);
    CGFloat y = - imageView.frame.size.height;
    imageView.center = CGPointMake(x, y);
    
    [self.view addSubview:imageView];
    [UIView animateWithDuration:arc4random_uniform(5) animations:^{
        CGFloat toX = arc4random_uniform(winSize.width);
        CGFloat toY = winSize.height - 10;
        
        imageView.center = CGPointMake(toX, toY);
        imageView.transform = CGAffineTransformRotate(imageView.transform, arc4random_uniform(M_PI * 2));
        
        imageView.alpha = 0.2;
    } completion:^(BOOL finished) {
        [imageView removeFromSuperview];
    }];
}

- (void)dealloc {
    
    [self.displayLink invalidate];
    self.displayLink = nil;
}

@end
