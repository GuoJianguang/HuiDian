//
//  RealNameSetViewController.m
//  HuiDian
//
//  Created by mac on 2017/5/11.
//  Copyright © 2017年 Huidian. All rights reserved.
//

#import "RealNameSetViewController.h"

@interface RealNameSetViewController ()

@end

@implementation RealNameSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.naviBar.title = @"实名认证";
    self.sureBtn.backgroundColor = MacoYellowColor;
    self.sureBtn.layer.cornerRadius = 20;
    self.sureBtn.layer.masksToBounds = YES;
    
    self.itemView.layer.cornerRadius = 10;
    self.itemView.backgroundColor = MacoYellowColor;
    self.itemView.layer.masksToBounds = YES;
    [self.view sendSubviewToBack:self.bgImageView];
    self.nameLabel.textColor = self.idCardLabel.textColor = MacoTitleColor;
    [self.sureBtn setTitleColor:MacoTitleColor forState:UIControlStateNormal];
    
    self.alerLabel.textColor = MacoYellowColor;
    
    if (self.isYetAut) {
        self.nameTF.text = [HDUserInfo shareUserInfos].idcardName;
        self.idcardTF.text = [HDUserInfo shareUserInfos].idcard;
        self.nameTF.enabled  = NO;
        self.idcardTF.enabled  = NO;
        self.alerLabel.hidden = YES;
        self.sureBtn.hidden = YES;
        [self hideIDCardNum];
        return;
    }
    
    UIAlertController *alertcontroller = [UIAlertController alertControllerWithTitle:@"重要提示" message:@"您每天有3次机会可以进行实名认证，请仔细核实您的实名认证信息" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
    }];
    [alertcontroller addAction:cancelAction];
    [self presentViewController:alertcontroller animated:YES completion:NULL];

}


- (void)hideIDCardNum
{
    if (self.idcardTF.text.length == 18) {
        self.idcardTF.text = [self.idcardTF.text stringByReplacingCharactersInRange:NSMakeRange(1, 16) withString:@"****************"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 认证成功
- (void)success{
    self.nameTF.text = [HDUserInfo shareUserInfos].idcardName;
    self.idcardTF.text = [HDUserInfo shareUserInfos].idcard;
    self.nameTF.enabled  = NO;
    self.idcardTF.enabled  = NO;
    self.alerLabel.hidden = YES;
    self.sureBtn.hidden = YES;
    [self hideIDCardNum];
}


- (IBAction)sureBtn:(UIButton *)sender {
    [self.idcardTF resignFirstResponder];
    [self.nameTF resignFirstResponder];
    
    if (![self valueValidated]) {
        return;
    }
    
    NSDictionary *parms = @{@"token":[HDUserInfo shareUserInfos].token,
                            @"cardNo":self.idcardTF.text,
                            @"idcardName":self.nameTF.text};
    AFHTTPSessionManager *manager = [self defaultManager];
    NSMutableDictionary *mutalbleParameter = [NSMutableDictionary dictionaryWithDictionary:parms];
    NSString *url = [NSString stringWithFormat:@"%@%@",HttpClient_BaseUrl,@"user/verifyIdcard"];
    [SVProgressHUD showWithStatus:@"正在请求..." maskType:SVProgressHUDMaskTypeBlack];
    
    [manager POST:url parameters:mutalbleParameter progress:NULL success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        @try {
            NSError *error = nil;
            //    id jsonObject = [responseObject objectFromJSONData];//
            id jsonObject=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
            NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:ResponseSerializerEncoding];
            NSString *err_string = [NSString stringWithFormat:@"json 格式错误.返回字符串：%@",responseString];
            NSAssert(error==nil, err_string);
            //token过期
            if ([jsonObject isKindOfClass:[NSDictionary class]]) {
                if ([NullToNumber(jsonObject[@"code"]) isEqualToString:@"-300"]) {
                    [HDUserInfo shareUserInfos].currentLogined = NO;
                    UIAlertView *aler = [[UIAlertView alloc]initWithTitle:@"提醒" message:@"您的登录信息已过期，请重新登录" delegate:[UIApplication sharedApplication].keyWindow.rootViewController cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                    [aler show];
                    
                    UIAlertController *alertcontroller = [UIAlertController alertControllerWithTitle:@"提醒" message:@"您的登录信息已过期，请重新登录" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                    }];
                    UIAlertAction *surelAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                        UINavigationController *logvc = [LoginViewController controller];
                        [self presentViewController:logvc animated:YES completion:NULL];
                        
                    }];
                    [alertcontroller addAction:cancelAction];
                    [alertcontroller addAction:surelAction];
                    [self presentViewController:alertcontroller animated:YES completion:NULL];
                    return;
                }if ([NullToNumber(jsonObject[@"code"]) isEqualToString:@"0"]) {
                    [HDUserInfo shareUserInfos].idcardName = self.nameTF.text;
                    [HDUserInfo shareUserInfos].idcard = self.idcardTF.text;
                    [HDUserInfo shareUserInfos].identityFlag = YES;
                    [[JAlertViewHelper shareAlterHelper]showTint:@"实名认证成功" duration:1.5];
                    [self success];
                    return;
                }
                //                    2037,"未绑卡，现在去绑定银行卡吗？"
                else if ([NullToNumber(jsonObject[@"code"]) isEqualToString:@"2037"]) {
                    [HDUserInfo shareUserInfos].idcardName = self.nameTF.text;
                    [HDUserInfo shareUserInfos].idcard = self.idcardTF.text;
                    [HDUserInfo shareUserInfos].identityFlag = YES;
                    [[JAlertViewHelper shareAlterHelper]showTint:@"实名认证成功" duration:1.5];
                    [self success];
                    return;
                }
                //2039,"实名认证信息与之前绑定银行卡信息不一致，银行卡信息已清空，是否现在去重新绑定？"
                else if ([NullToNumber(jsonObject[@"code"]) isEqualToString:@"2039"]) {
                    
                    [HDUserInfo shareUserInfos].identityFlag = YES;
                    [HDUserInfo shareUserInfos].idcardName = self.nameTF.text;
                    [HDUserInfo shareUserInfos].idcard = self.idcardTF.text;
                    [[JAlertViewHelper shareAlterHelper]showTint:@"实名认证成功" duration:1.5];
                    [self success];
                    return;
                    //2047,"三次机会用完"
                }else{

                    [[JAlertViewHelper shareAlterHelper]showTint:jsonObject[@"message"] duration:2.5];
                    return;
                }
            }
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        [[JAlertViewHelper shareAlterHelper]showTint:@"网络请求失败，请重试" duration:2.];
    }];
}

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

-(BOOL) valueValidated {
    // 判断电话号码是否合格
    if ([self emptyTextOfTextField:self.nameTF]) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"请输入姓名" duration:1.5];
        return NO;
    }else if ([self emptyTextOfTextField:self.idcardTF]) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"请输入身份证号码" duration:1.5];
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


@end
