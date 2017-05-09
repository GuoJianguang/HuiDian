//
//  LoginViewController.m
//  HuiDian
//
//  Created by mac on 2017/5/4.
//  Copyright © 2017年 Huidian. All rights reserved.
//

#import "LoginViewController.h"
#import "ForgetPasswordViewController.h"
#import "RegisterViewController.h"

@interface LoginViewController ()<BasenavigationDelegate>

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.hidden = YES;
    self.naviBar.title = @"登录";
    [self.view sendSubviewToBack:self.bgImageView];
    [self.userTF setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.passwordTF setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];

    self.loginBtn.layer.cornerRadius = 20;
    self.loginBtn.layer.masksToBounds = YES;
    
    self.naviBar.delegate = self;
    self.passwordTF.text = @"123456";
    self.userTF.text = @"18782027924";
}


- (void)backBtnClick
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - 登录
- (IBAction)loginBtn:(UIButton *)sender {
    [self.passwordTF resignFirstResponder];
    [self.userTF resignFirstResponder];
    if ([self valueValidated]) {
        [SVProgressHUD showWithStatus:@"正在登录..."];
        //登录接口请求操作
        NSString *password = [[NSString stringWithFormat:@"%@%@",self.passwordTF.text,PasswordKey]md5_32];
        NSDictionary *parms = @{@"phone":self.userTF.text,
                                @"deviceToken":NullToSpace([HDUserInfo shareUserInfos].devicetoken),
                                @"deviceType":@"ios",
                                @"password":password};
        [HttpClient POST:@"user/login" parameters:parms success:^(NSURLSessionDataTask *operation, id jsonObject) {
            [SVProgressHUD dismiss];
            if (IsRequestTrue) {
                //设置用户信息
                [SVProgressHUD showSuccessWithStatus:@"登录成功"];
                [[NSUserDefaults standardUserDefaults]setObject:self.userTF.text forKey:LoginUserName];
                [[NSUserDefaults standardUserDefaults]setObject:self.passwordTF.text forKey:LoginUserPassword];
                [[NSUserDefaults standardUserDefaults]synchronize];
                [HDUserInfo shareUserInfos].currentLogined = YES;
                [[HDUserInfo shareUserInfos]setUserinfoWithdic:jsonObject[@"data"]];
                //统计新增用户
                UINavigationController *homeVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"Main"];
                [self presentViewController:homeVC animated:YES completion:NULL];
//                [self dismissViewControllerAnimated:YES completion:NULL];
            }
        } failure:^(NSURLSessionDataTask *operation, NSError *error) {
            [SVProgressHUD dismiss];
        }];
    }

    
}
#pragma mark - 获取登录模块
+ (UINavigationController *)controller
{
    return [[UIStoryboard storyboardWithName:@"Login" bundle:nil] instantiateViewControllerWithIdentifier:@"Login"];
}

#pragma mark - 注册
- (IBAction)registerBtn:(UIButton *)sender {
    RegisterViewController *registerVC = [[RegisterViewController alloc]init];
    [self.navigationController pushViewController:registerVC animated:YES];
}
#pragma mark - 忘记密码
- (IBAction)forgetBtn:(UIButton *)sender {
    ForgetPasswordViewController *forgetVC = [[ForgetPasswordViewController alloc]init];
    [self.navigationController pushViewController:forgetVC animated:YES];
}



-(BOOL) valueValidated {
    // 判断电话号码是否合格
    if ([self emptyTextOfTextField:self.userTF]) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"请输入用户名" duration:1.];
        return NO;
    }else if ([self emptyTextOfTextField:self.passwordTF]) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"请输入密码" duration:1.];
        return NO;
    }
    return YES;
}

-(BOOL) emptyTextOfTextField:(UITextField*) textField {
    
    if ([textField.text isEqualToString:@""] || !textField.text) {
        return YES;
    }
    return NO;
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self.userTF resignFirstResponder];
    [self.passwordTF resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
