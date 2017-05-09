//
//  RegisterViewController.m
//  HuiDian
//
//  Created by mac on 2017/5/9.
//  Copyright © 2017年 Huidian. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()<UITextFieldDelegate>
@property (nonatomic,strong) NSTimer *timer;

@end

@implementation RegisterViewController
{
    int timeLefted;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.naviBar.title = @"注册";
    self.itemView.layer.cornerRadius = 20;
    self.itemView.layer.masksToBounds = YES;
    self.itemView.backgroundColor = MacoYellowColor;
    [self.view sendSubviewToBack:self.bgImageView];
    self.view1.backgroundColor = self.view2.backgroundColor = self.view3.backgroundColor = self.view4.backgroundColor = self.view5.backgroundColor = MacoTitleColor;
    [self.passwordTF setValue:MacoTitleColor forKeyPath:@"_placeholderLabel.textColor"];
    [self.phoneTF setValue:MacoTitleColor forKeyPath:@"_placeholderLabel.textColor"];
    [self.grapCodeTF setValue:MacoTitleColor forKeyPath:@"_placeholderLabel.textColor"];
    [self.phoneCodeTF setValue:MacoTitleColor forKeyPath:@"_placeholderLabel.textColor"];
    [self.surePasswordTF setValue:MacoTitleColor forKeyPath:@"_placeholderLabel.textColor"];
    
    self.passwordTF.textColor = self.phoneTF.textColor = self.grapCodeTF.textColor = self.phoneCodeTF.textColor = self.surePasswordTF.textColor = MacoTitleColor;
    
    self.sureBtn.backgroundColor = MacoBlueColor;
    [self.sureBtn setTitleColor:MacoYellowColor forState:UIControlStateNormal];
    self.sureBtn.layer.cornerRadius = 20;
    self.sureBtn.layer.masksToBounds = YES;
    [self.codeBtn setTitleColor:MacoTitleColor forState:UIControlStateNormal];
    self.codeBtn.layer.cornerRadius = 4;
    self.codeBtn.layer.borderWidth = 1;
    self.codeBtn.layer.borderColor = MacoTitleColor.CGColor;
    self.codeBtn.layer.masksToBounds = YES;
    self.codeBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    [self.getGraphBtn setTitleColor:MacoTitleColor forState:UIControlStateNormal];
    self.getGraphBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    
    self.phoneTF.delegate = self;
    timeLefted = 60;
    
    self.protocelLabel.adjustsFontSizeToFitWidth = YES;
    self.protocelLabel.userInteractionEnabled = YES;
    self.protocelLabel.textColor = MacoTitleColor;
    UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(protocolGes)];
    [self.protocelLabel addGestureRecognizer:ges];
    
}

- (void)protocolGes
{
    BaseHtmlViewController *htmlVC = [[BaseHtmlViewController alloc]init];
    htmlVC.htmlTitle = @"用户使用条款及服务协议";
    htmlVC.htmlUrl = @"https://www.tiantianxcn.com/html5/forapp/xy_user.html";
    [self.navigationController pushViewController:htmlVC animated:YES];
}

- (IBAction)sureBtn:(UIButton *)sender {
    [self.phoneTF resignFirstResponder];
    [self.passwordTF resignFirstResponder];
    [self.phoneCodeTF resignFirstResponder];
    [self.surePasswordTF resignFirstResponder];
    [self.grapCodeTF resignFirstResponder];
    
    if ([self valueValidated]) {
        //忘记密码接口请求
        NSString *password = [[NSString stringWithFormat:@"%@%@",self.passwordTF.text,PasswordKey]md5_32];
        NSDictionary *parms = @{@"phone":self.phoneTF.text,
                                @"verifyCode":self.phoneCodeTF.text,
                                @"password":password};
        [HttpClient POST:@"user/register" parameters:parms success:^(NSURLSessionDataTask *operation, id jsonObject) {
            [SVProgressHUD dismiss];
            if (IsRequestTrue) {
                //设置用户信息
                [SVProgressHUD showSuccessWithStatus:@"注册成功,请重新登录"];
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
        } failure:^(NSURLSessionDataTask *operation, NSError *error) {
            
        }];
    }
    
}

- (IBAction)getGraphBtn:(UIButton *)sender
{
    if ([self emptyTextOfTextField:self.phoneTF]) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"请输入手机号码" duration:1.];
        return;
    }
    sender.enabled = NO;
    Verify *veri = [[Verify alloc]init];
    [veri verifyPhoneNumber:self.phoneTF.text callBack:^(BOOL success, NSError *error) {
        if (success) {
            NSDictionary *parms = @{@"phone":self.phoneTF.text,
                                    @"key":@"register"};
            AFHTTPSessionManager *manager = [self defaultManager];
            NSMutableDictionary *mutalbleParameter = [NSMutableDictionary dictionaryWithDictionary:parms];
            NSString *url = [NSString stringWithFormat:@"%@%@",HttpClient_BaseUrl,@"verifyCode/getImageVerifyCode"];
            [manager POST:url parameters:mutalbleParameter success:^(NSURLSessionDataTask *operation, id responseObject) {
                [SVProgressHUD dismiss];
                UIImage *image = [[UIImage alloc]initWithData:responseObject];
                [self.getGraphBtn setBackgroundImage:image forState:UIControlStateNormal];
                [self.getGraphBtn setTitle:@"" forState:UIControlStateNormal];
                sender.enabled = YES;
            } failure:^(NSURLSessionDataTask *operation, NSError *error) {
                [[JAlertViewHelper shareAlterHelper]showTint:@"图形验证码获取失败，请重试" duration:2.];
                sender.enabled = YES;
            }];
            return ;
        }
        [[JAlertViewHelper shareAlterHelper]showTint:@"请输入正确的手机号" duration:1.5];
        sender.enabled = YES;
    }];
    
}
- (IBAction)codeBtn:(UIButton *)sender
{
    if ([self emptyTextOfTextField:self.grapCodeTF]) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"请输入图形验证码" duration:1.5];
        return;
    }
    sender.enabled = NO;
    Verify *veri = [[Verify alloc]init];
    [veri verifyPhoneNumber:self.phoneTF.text callBack:^(BOOL success, NSError *error) {
        if (success) {
            //获取验证码
            NSDictionary *parms = @{@"phone":self.phoneTF.text,
                                    @"imageVerifyCode":self.grapCodeTF.text};
            [HttpClient POST:@"sms/sendCommonCode" parameters:parms success:^(NSURLSessionDataTask *operation, id jsonObject) {
                sender.enabled = YES;
                if (IsRequestTrue) {
                    [self.codeBtn setTitle:@"重新获取(60)" forState:UIControlStateNormal];
                    self.codeBtn.layer.borderColor = MacoIntrodouceColor.CGColor;
                    [self.codeBtn setTitleColor:MacoIntrodouceColor forState:UIControlStateNormal];
                    self.codeBtn.enabled = NO;
                    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeLeft:) userInfo:nil repeats:YES];
                    [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
                }
                
            } failure:^(NSURLSessionDataTask *operation, NSError *error) {
                sender.enabled = YES;
            }];
            
            return ;
        }
        [[JAlertViewHelper shareAlterHelper]showTint:@"请输入正确的手机号" duration:1.5];
    }];
    
    
}
#pragma mark - 验证码计时器
//static int timeLefted = 60;
-(void) timeLeft:(NSTimer*) timer {
    
    timeLefted--;
    if (timeLefted == 0) {
        [self verifyButtonNormal];
        return;
    }
    
    NSString *title = [NSString stringWithFormat:@"重新获取(%d)",timeLefted];
    self.codeBtn.titleLabel.text = title;
    [self.codeBtn setTitle:title forState:UIControlStateNormal];
    
}

-(void) verifyButtonNormal {
    [self.timer invalidate];
    timeLefted = 60;
    self.codeBtn.layer.borderColor = MacoTitleColor.CGColor;
    [self.codeBtn setTitle:@"重新获取" forState:UIControlStateNormal];
    self.codeBtn.enabled = YES;
}

-(BOOL) valueValidated {
    if ([self emptyTextOfTextField:self.phoneTF]) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"请输入手机号码" duration:1.];
        return NO;
    }else if ([self emptyTextOfTextField:self.phoneCodeTF]) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"请输入验证码" duration:1.];
        return NO;
    }else if ([self emptyTextOfTextField:self.passwordTF]) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"请输入密码" duration:1.];
        return NO;
    }else if ([self emptyTextOfTextField:self.surePasswordTF]) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"请确认密码" duration:1.];
        return NO;
    }else if (![self.passwordTF.text isEqualToString:self.surePasswordTF.text]){
        [[JAlertViewHelper shareAlterHelper]showTint:@"两次输入的密码不一致" duration:1.];
        return NO;
    }else if (self.passwordTF.text.length < 6 || self.surePasswordTF.text.length < 6){
        [[JAlertViewHelper shareAlterHelper]showTint:@"您的密码长度不能小于6位" duration:1.];
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

#pragma mark - UITextFiledDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.phoneTF) {
        if (textField.text.length > 10 && ![string isEqualToString:@""]) {
            return NO;
        }
        [self.getGraphBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [self.getGraphBtn setTitle:@"点击获取" forState:UIControlStateNormal];
        
        self.grapCodeTF.text = @"";
    }
    if ([string isEqualToString:@" "]) {
        return NO;
    }
    return YES;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self.phoneTF resignFirstResponder];
    [self.passwordTF resignFirstResponder];
    [self.surePasswordTF resignFirstResponder];
    [self.grapCodeTF resignFirstResponder];
    [self.phoneCodeTF resignFirstResponder];
    
}

#pragma mark - 网络请求
-(AFHTTPSessionManager*) defaultManager {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    AFHTTPRequestSerializer *requestSerializer = [AFHTTPRequestSerializer serializer];
    requestSerializer.stringEncoding = RequestSerializerEncoding;
    requestSerializer.timeoutInterval = TimeoutInterval;
    AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
    responseSerializer.stringEncoding = ResponseSerializerEncoding;
    
    manager.requestSerializer = requestSerializer;
    manager.responseSerializer = responseSerializer;
    
    return manager;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
