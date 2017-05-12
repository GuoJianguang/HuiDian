//
//  EditPasswordViewController.m
//  HuiDian
//
//  Created by mac on 2017/5/12.
//  Copyright © 2017年 Huidian. All rights reserved.
//

#import "EditPasswordViewController.h"

@interface EditPasswordViewController ()<UITextFieldDelegate>

@end

@implementation EditPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.naviBar.title = @"修改密码";
    
    self.label1.textColor = self.label2.textColor =  self.label3.textColor=MacoTitleColor;
    [self.sureBtn setTitleColor:MacoTitleColor forState:UIControlStateNormal];
    self.sureBtn.backgroundColor = MacoYellowColor;
    self.sureBtn.layer.cornerRadius = 20;
    self.sureBtn.layer.masksToBounds = YES;
    [self.view sendSubviewToBack:self.bgImageView];

    self.itemView.layer.cornerRadius = 10;
    self.itemView.backgroundColor = MacoYellowColor;
    self.itemView.layer.masksToBounds = YES;
    
    self.pasword_tf.delegate = self.oldPassword_tf.delegate = self.surePassword_tf.delegate = self;
}


- (IBAction)sureBtn:(UIButton *)sender
{
    if ([self valueValidated]) {
        sender.enabled = NO;
        NSString *oldPassword = [[NSString stringWithFormat:@"%@%@",self.oldPassword_tf.text,PasswordKey]md5_32];
        NSString *newPassword = [[NSString stringWithFormat:@"%@%@",self.pasword_tf.text,PasswordKey]md5_32];
        
        [SVProgressHUD showWithStatus:@"正在提交请求..."];
        NSDictionary *parms = @{@"oldPassword":oldPassword,
                                @"token":[HDUserInfo shareUserInfos].token,
                                @"newPassword":newPassword};
        [HttpClient POST:@"user/updatePassword" parameters:parms success:^(NSURLSessionDataTask *operation, id jsonObject) {
            sender.enabled = YES;
            [SVProgressHUD dismiss];
            if (IsRequestTrue) {
                //设置用户信息
                [[JAlertViewHelper shareAlterHelper]showTint:@"修改成功" duration:1.5];
                [[NSUserDefaults standardUserDefaults]setObject:self.pasword_tf.text forKey:LoginUserPassword];
                [self.navigationController popViewControllerAnimated:YES];
            }
        } failure:^(NSURLSessionDataTask *operation, NSError *error) {
            sender.enabled = YES;
            [SVProgressHUD dismiss];
        }];
    }
    

}

-(BOOL) valueValidated {
    // 判断电话号码是否合格
    if ([self emptyTextOfTextField:self.oldPassword_tf]) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"请输入旧密码" duration:1.];
        return NO;
    }else if ([self emptyTextOfTextField:self.pasword_tf]) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"请输入新密码" duration:1.];
        return NO;
    }else if (self.pasword_tf.text.length<6 || self.pasword_tf.text.length > 18){
        [[JAlertViewHelper shareAlterHelper]showTint:@"您的密码必须在6-18位之间" duration:1.];
        return NO;
    }else if ([self emptyTextOfTextField:self.surePassword_tf]) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"请重复新密码" duration:1.];
        return NO;
    }else if (![self.pasword_tf.text isEqualToString:self.surePassword_tf.text]){
        [[JAlertViewHelper shareAlterHelper]showTint:@"两次输入的密码不一致" duration:1.];
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

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@" "]) {
        return NO;
    }
    return YES;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
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
