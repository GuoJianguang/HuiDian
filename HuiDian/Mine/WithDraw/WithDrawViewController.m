//
//  WithDrawViewController.m
//  HuiDian
//
//  Created by mac on 2017/5/15.
//  Copyright © 2017年 Huidian. All rights reserved.
//

#import "WithDrawViewController.h"

@interface WithDrawViewController ()<UITextFieldDelegate>
@property (nonatomic,strong) NSTimer *timer;

@end

@implementation WithDrawViewController
{
    int timeLefted;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.naviBar.title = @"提现";
    self.label1.textColor = self.label2.textColor = MacoTitleColor;
    self.label1.adjustsFontSizeToFitWidth = self.label2.adjustsFontSizeToFitWidth = YES;
    timeLefted = 60;

    self.alerLabel.textColor = self.moneyLabel.textColor = [UIColor whiteColor];
    [self.sureBtn setTitleColor:MacoTitleColor forState:UIControlStateNormal];
    self.sureBtn.backgroundColor = MacoYellowColor;
    self.sureBtn.layer.cornerRadius = 20;
    self.sureBtn.layer.masksToBounds = YES;
    self.poundageLabel.textColor = MacoYellowColor;
    self.itemView.layer.cornerRadius = 10;
    self.itemView.backgroundColor = MacoYellowColor;
    self.itemView.layer.masksToBounds  = YES;
    
    [self.sendBtn setTitleColor:MacoTitleColor forState:UIControlStateNormal];
    self.sendBtn.layer.cornerRadius = 5;
    self.sendBtn.layer.borderWidth = 1;
    self.sendBtn.layer.borderColor = MacoTitleColor.CGColor;
    self.sendBtn.backgroundColor = MacoYellowColor;
    
    self.moneyLabel.text = [NSString stringWithFormat:@"%.2f",[[HDUserInfo shareUserInfos].aviableBalance doubleValue]];
    self.sendBtn.titleLabel.adjustsFontSizeToFitWidth = YES;

    
    self.moneyTF.delegate = self;
    self.codeTF.delegate = self;
    
    
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

- (IBAction)sureBtn:(UIButton *)sender {
    if ([self emptyTextOfTextField:self.moneyTF]) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"请输入提现金额" duration:1.];
        return;
    }else if ([self emptyTextOfTextField:self.codeTF]) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"请输入提现验证码" duration:1.5];
        return ;
    }else if ([[HDUserInfo shareUserInfos].aviableBalance doubleValue] < [self.moneyTF.text doubleValue]) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"您的可提现余额不足，请重新输入" duration:2.];
        return;
    }else if ([self.moneyTF.text integerValue]%10 !=0){
        [[JAlertViewHelper shareAlterHelper]showTint:@"您的提现金额必须是10的整数倍" duration:2.];
        return;
    }else if ([self.moneyTF.text doubleValue] < 100){
        [[JAlertViewHelper shareAlterHelper]showTint:@"您的提现金额不能小于100" duration:2.];
        return;
    }
    
    //提现的接口请求
    NSDictionary *parms = @{@"token":[HDUserInfo shareUserInfos].token,
                            @"verifyCode":self.codeTF.text,
                            @"withdrawAmount":self.moneyTF.text};
    [SVProgressHUD showWithStatus:@"正在提交申请"];
    [HttpClient POST:@"user/withdraw/add" parameters:parms success:^(NSURLSessionDataTask *operation, id jsonObject) {
        [SVProgressHUD dismiss];
        sender.enabled = YES;
        if (IsRequestTrue) {
            [[JAlertViewHelper shareAlterHelper]showTint:@"提现申请成功" duration:2.];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        sender.enabled = YES;
        [SVProgressHUD dismiss];
    }];
}
- (IBAction)sendBtn:(UIButton *)sender {
    
    if ([self emptyTextOfTextField:self.moneyTF]) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"请输入提现金额" duration:2.];
        return;
    }else if ([[HDUserInfo shareUserInfos].aviableBalance doubleValue] < [self.moneyTF.text doubleValue]) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"您的可提现余额不足，请重新输入" duration:2.];
        return;
    }else if ([self.moneyTF.text integerValue]%10 !=0){
        [[JAlertViewHelper shareAlterHelper]showTint:@"您的提现金额必须是10的整数倍" duration:2.];
        return;
    }else if ([self.moneyTF.text doubleValue] < 100){
        [[JAlertViewHelper shareAlterHelper]showTint:@"您的提现金额不能小于100" duration:2.];
        return;
    }
    sender.enabled = NO;
    [HttpClient POST:@"user/withdraw/sendVerifyCode" parameters:@{@"token":[HDUserInfo shareUserInfos].token} success:^(NSURLSessionDataTask *operation, id jsonObject) {
        sender.enabled = YES;
        self.sendBtn.enabled = NO;
        if (IsRequestTrue) {
            [self.sendBtn setTitle:@"重新获取(60)" forState:UIControlStateNormal];
            self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeLeft:) userInfo:nil repeats:YES];
            [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"验证码发送失败，请重试" duration:2.];
        sender.enabled = YES;
    }];

}

-(BOOL) emptyTextOfTextField:(UITextField*) textField {
    
    if ([textField.text isEqualToString:@""] || !textField.text) {
        return YES;
    }
    return NO;
    
}

#pragma mark - 验证码计时器
-(void) timeLeft:(NSTimer*) timer {
    timeLefted--;
    if (timeLefted == 0) {
        [self verifyButtonNormal];
        return;
    }
    NSString *title = [NSString stringWithFormat:@"重新获取(%d)",timeLefted];
    self.sendBtn.titleLabel.text = title;
    [self.sendBtn setTitle:title forState:UIControlStateNormal];
    
}


-(void) verifyButtonNormal {
    [self.timer invalidate];
    timeLefted = 60;
    [self.sendBtn setTitle:@"重新获取" forState:UIControlStateNormal];
    self.sendBtn.enabled = YES;
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.moneyTF) {
        NSScanner      *scanner    = [NSScanner scannerWithString:string];
        NSCharacterSet *numbers;
        NSRange         pointRange = [textField.text rangeOfString:@"."];
        
        if ( (pointRange.length > 0) && (pointRange.location < range.location  || pointRange.location > range.location + range.length) )
        {
            numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
        }
        else
        {
            numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
        }
        
        if ( [textField.text isEqualToString:@""] && [string isEqualToString:@"."] )
        {
            return NO;
        }
        
        short remain = 2; //默认保留2位小数
        
        NSString *tempStr = [textField.text stringByAppendingString:string];
        NSUInteger strlen = [tempStr length];
        if(pointRange.length > 0 && pointRange.location > 0){ //判断输入框内是否含有“.”。
            if([string isEqualToString:@"."]){ //当输入框内已经含有“.”时，如果再输入“.”则被视为无效。
                return NO;
            }
            if(strlen > 0 && (strlen - pointRange.location) > remain+1){ //当输入框内已经含有“.”，当字符串长度减去小数点前面的字符串长度大于需要要保留的小数点位数，则视当次输入无效。
                return NO;
            }
        }
        
        NSRange zeroRange = [textField.text rangeOfString:@"0"];
        if(zeroRange.length == 1 && zeroRange.location == 0){ //判断输入框第一个字符是否为“0”
            if(![string isEqualToString:@"0"] && ![string isEqualToString:@"."] && [textField.text length] == 1){ //当输入框只有一个字符并且字符为“0”时，再输入不为“0”或者“.”的字符时，则将此输入替换输入框的这唯一字符。
                textField.text = string;
                return NO;
            }else{
                if(pointRange.length == 0 && pointRange.location > 0){ //当输入框第一个字符为“0”时，并且没有“.”字符时，如果当此输入的字符为“0”，则视当此输入无效。
                    if([string isEqualToString:@"0"]){
                        return NO;
                    }
                }
            }
        }
        NSString *buffer;
        if ( ![scanner scanCharactersFromSet:numbers intoString:&buffer] && ([string length] != 0) )
        {
            return NO;
        }
    }
    return YES;
}


@end
