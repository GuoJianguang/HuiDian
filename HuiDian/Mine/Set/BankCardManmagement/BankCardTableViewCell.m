//
//  BankCardTableViewCell.m
//  HuiDian
//
//  Created by mac on 2017/5/12.
//  Copyright © 2017年 Huidian. All rights reserved.
//

#import "BankCardTableViewCell.h"
#import "BankPickView.h"


@interface BankCardTableViewCell()<BankPickViewDelegate,UITextFieldDelegate>
@property (strong, nonatomic) BankPickView *cityPicker;
@property (strong, nonatomic)BankPickView *bankPicker;
@property (strong, nonatomic)BankPickView *wangdianPicker;
@property (strong, nonatomic)BankPickView *kaihuhangPicker;
@property (copy,nonatomic)NSString *bank_id;

@property (copy,nonatomic)NSString *tempBankName;
@property (copy,nonatomic)NSString *tempProName;
@property (copy,nonatomic)NSString *tempKaihuwangdianName;
@property (copy,nonatomic)NSString *tempkaihuhangName;


@end

@implementation BankCardTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.phoneTF.delegate = self;
    self.provincesTF.delegate = self;
    self.bankLabel.delegate = self;
    self.kaihuhangTF.delegate = self;
    self.kaihuhangNumdTF.delegate = self;
    self.wangdianTF.delegate = self;
    self.inputKaihuhangTF.delegate = self;
    
    self.cityPicker.isAddressPicker = YES;
    self.provincesTF.inputView = self.cityPicker;
    self.bankPicker.isAddressPicker = NO;
    self.bankLabel.inputView = self.bankPicker;
    self.wangdianTF.inputView = self.wangdianPicker;
    self.kaihuhangTF.inputView = self.kaihuhangPicker;
    
    self.tempProName = self.cityPicker.dataSouceArray[0][@"bankName"];
    self.tempBankName = @"";
    self.bank_id = @"";
    self.bankCardNu.delegate = self;

    self.manualInputView.hidden = YES;
    
    self.alerLabel.textColor = MacoYellowColor;
    
    [self.bingdingBtn setTitleColor:MacoTitleColor forState:UIControlStateNormal];
    self.bingdingBtn.layer.cornerRadius = 20;
    self.bingdingBtn.layer.masksToBounds = YES;
    
    self.isMaual = NO;
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, TWitdh-24, (TWitdh-24)*(180/343.)) byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.itemView1.bounds;
    maskLayer.path = maskPath.CGPath;
    self.itemView1.layer.mask = maskLayer;
    
    UIBezierPath *maskPath1 = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, TWitdh-24, (TWitdh-24)*(240/343.))  byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer *maskLayer1 = [[CAShapeLayer alloc] init];
    maskLayer1.frame = self.itemView3.bounds;
    maskLayer1.path = maskPath1.CGPath;
    self.itemView1.layer.masksToBounds = YES;
    self.itemView3.layer.mask = maskLayer1;
}
- (void)setRealnameAuDic:(NSDictionary *)realnameAuDic
{
    _realnameAuDic = realnameAuDic;
    self.idCardNUTF.text = _realnameAuDic[@"idcardnumber"];
    self.idCardNUTF.enabled = NO;
    self.nameTF.enabled = NO;
    self.nameTF.text = _realnameAuDic[@"name"];
}

- (void)setIsMaual:(BOOL)isMaual
{
    _isMaual = isMaual;
    if (_isMaual) {
        self.manualInputView.hidden = NO;
        self.item2Height.constant = (TWitdh - 24)*(100/343.);

    }else{
        self.manualInputView.hidden = YES;
        self.item2Height.constant = (TWitdh - 24)*(170/343.);
    }
}

#pragma mark - 当已绑定的时候进入该界面在情况
- (void)setBankcardinfo:(NSDictionary *)bankcardinfo
{
    
    _bankcardinfo = bankcardinfo;
    self.bank_id = NullToNumber(bankcardinfo[@"bankId"]);
    NSString *shengName = [NullToSpace(bankcardinfo[@"bankAccountPro"]) stringByReplacingOccurrencesOfString:@"省" withString:@""];
    shengName = [shengName stringByReplacingOccurrencesOfString:@"市" withString:@""];
    
    NSString *bankName = NullToSpace(bankcardinfo[@"bankName"]);
    if (![bankName isEqualToString:@"中国银行"]) {
        bankName = [bankName stringByReplacingOccurrencesOfString:@"中国" withString:@""];
    }
    if ([bankName isEqualToString:@"中国邮政储蓄银行"] || [bankName isEqualToString:@"邮政储蓄银行"]||[bankName isEqualToString:@"中国邮政储蓄"]||[bankName isEqualToString:@"邮政储蓄"]) {
        bankName =  @"邮储银行";
    }
    
    self.bankLabel.text = bankName;
    self.bankCardNu.text = NullToSpace(bankcardinfo[@"bankAccount"]);
    [self normalNumToBankNum: NullToSpace(bankcardinfo[@"bankAccount"])];
    self.provincesTF.text = shengName;
    self.nameTF.text = NullToSpace(bankcardinfo[@"realName"]);
    self.phoneTF.text = NullToSpace(bankcardinfo[@"bankPhone"]);
    self.idCardNUTF.text = [HDUserInfo shareUserInfos].idcard;
    self.kaihuhangNumdTF.text = NullToSpace(bankcardinfo[@"bankBranchNo"]);
    self.wangdianTF.text = NullToSpace(bankcardinfo[@"bankPoint"]);
    if ([self.wangdianTF.text isEqualToString:@""]) {
        self.inputKaihuhangTF.text = NullToSpace(bankcardinfo[@"bankBranch"]);
        self.isMaual = YES;
    }
    else{
        self.wangdianTF.text = NullToSpace(bankcardinfo[@"bankPoint"]);
        self.kaihuhangTF.text  = NullToSpace(bankcardinfo[@"bankPointBranch"]);
        self.isMaual = NO;
    }

}

- (NSString *)normalNumToBankNum:(NSString *)num
{
    if (num.length < 7) {
        return num;
    }
    NSNumber *number = @([num longLongValue]);
    NSNumberFormatter *formatter = [NSNumberFormatter new];
    [formatter setUsesGroupingSeparator:YES];
    [formatter setGroupingSize:4];
    [formatter setGroupingSeparator:@" "];
    return [formatter stringFromNumber:number];
}

- (NSString *)tempBankName
{
    if (!_tempBankName) {
        _tempBankName = [NSString string];
    }
    return _tempBankName;
}


- (NSString *)tempkaihuhangName
{
    if (!_tempkaihuhangName) {
        _tempkaihuhangName = [NSString string];
    }
    return _tempkaihuhangName;
}

- (NSString *)tempKaihuwangdianName
{
    if (!_tempKaihuwangdianName) {
        _tempKaihuwangdianName = [NSString string];
    }
    return _tempKaihuwangdianName;
}

- (NSString *)tempProName
{
    if (!_tempProName) {
        _tempProName   = [NSString string];
    }
    return _tempProName;
}
#pragma mark - BankPickerView

- (BankPickView *)bankPicker
{
    if (!_bankPicker) {
        _bankPicker = [[BankPickView alloc]init];
        _bankPicker.isAddressPicker = NO;
        _bankPicker.bankdelegate = self;
    }
    return _bankPicker;
}

- (BankPickView *)wangdianPicker
{
    if (!_wangdianPicker) {
        _wangdianPicker = [[BankPickView alloc]init];
        _wangdianPicker.bankdelegate = self;
    }
    return _wangdianPicker;
}

- (BankPickView *)kaihuhangPicker
{
    if (!_kaihuhangPicker) {
        _kaihuhangPicker = [[BankPickView alloc]init];
        _kaihuhangPicker.bankdelegate = self;
    }
    return _kaihuhangPicker;
    
}


- (void)bankPickerView:(BankPickView *)picker finishPickbankName:(NSString *)bankName bankId:(NSString *)bankId
{
    
    if (picker == self.bankPicker) {
        self.kaihuhangTF.text = @"";
        self.wangdianTF.text = @"";
        self.bankLabel.text = bankName;
        self.tempBankName = bankName;
        self.bank_id = bankId;
    }else if(picker == self.cityPicker){
        self.kaihuhangTF.text = @"";
        self.wangdianTF.text = @"";
        self.provincesTF.text = bankName;
        self.tempProName = bankName;
    }else if (picker == self.wangdianPicker){
        self.kaihuhangTF.text = @"";
        self.wangdianTF.text = bankName;
        self.tempKaihuwangdianName = bankName;
    }else if (picker == self.kaihuhangPicker){
        self.kaihuhangTF.text = bankName;
        self.tempkaihuhangName = bankName;
    }
}



#pragma mark - 获取所有银行卡
- (void)getAllBankRequest
{
    [HttpClient POST:@"user/banks/get" parameters:nil success:^(NSURLSessionDataTask *operation, id jsonObject) {
        if (IsRequestTrue) {
            NSArray *array = jsonObject[@"data"];
            NSMutableArray *datasoucearray = [NSMutableArray array];
            for (NSDictionary *dic in array) {
                NSDictionary *iteDic =  @{@"bankId":NullToNumber(dic[@"id"]),@"bankName":NullToSpace(dic[@"bankName"])};
                [datasoucearray addObject:iteDic];
            }
            self.bankPicker.dataSouceArray = datasoucearray;
            self.tempBankName = datasoucearray[0][@"bankName"];
            self.bank_id = datasoucearray[0][@"bankId"];
            self.bankPicker.isAddressPicker = NO;
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"抱歉,暂时获取不到银行信息" duration:2.0];
        [self.wangdianTF resignFirstResponder];
    }];
}

#pragma mark - 获取银行网点支行的网络请求
- (void)getBankPointRequest
{
    NSDictionary *parms = @{@"bank":NullToSpace(self.bankLabel.text),
                            @"province":NullToSpace(self.provincesTF.text)};
    
    [HttpClient POST:@"user/withdraw/bindBankcard/getBankPoint" parameters:parms success:^(NSURLSessionDataTask *operation, id jsonObject) {
        if (IsRequestTrue) {
            NSArray *array = jsonObject[@"data"][@"points"];
            NSMutableArray *datasoucearray = [NSMutableArray array];
            for (NSString *str in array) {
                NSDictionary *iteDic =  @{@"bankId":@"0",@"bankName":str};
                [datasoucearray addObject:iteDic];
            }
            self.tempkaihuhangName = @"";
            if (datasoucearray.count >0) {
                self.tempKaihuwangdianName = NullToSpace(datasoucearray[0][@"bankName"]);
            }
            
            self.wangdianPicker.wangdianArray = datasoucearray;
            //            if (datasoucearray.count == 0) {
            //                [[JAlertViewHelper shareAlterHelper]showTint:@"抱歉,暂时没有找到相关开户网点" duration:2.0];
            ////                [self.wangdianTF resignFirstResponder];
            //                return ;
            //            }
            
            //            [self.wangdianTF becomeFirstResponder];
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"抱歉,暂时没有找到相关开户网点" duration:2.0];
        [self.wangdianTF resignFirstResponder];
    }];
}

#pragma mark - 获取支行的网络请求
- (void)getBankRequest
{
    NSDictionary *parms = @{@"bank":NullToSpace(self.bankLabel.text),
                            @"province":NullToSpace(self.provincesTF.text),
                            @"point":NullToSpace(self.wangdianTF.text)};
    
    [HttpClient POST:@"user/withdraw/bindBankcard/getBankPoint" parameters:parms success:^(NSURLSessionDataTask *operation, id jsonObject) {
        if (IsRequestTrue) {
            NSArray *array = jsonObject[@"data"][@"childs"];
            NSMutableArray *datasoucearray = [NSMutableArray array];
            for (NSString *str in array) {
                NSDictionary *iteDic =  @{@"bankId":@"0",@"bankName":str};
                [datasoucearray addObject:iteDic];
            }
            self.tempkaihuhangName = @"";
            
            if (datasoucearray.count >0) {
                self.tempkaihuhangName = NullToSpace(datasoucearray[0][@"bankName"]);
            }
            self.kaihuhangPicker.wangdianArray = datasoucearray;
            if (datasoucearray.count == 0) {
                [[JAlertViewHelper shareAlterHelper]showTint:@"抱歉,暂时没有找到相关开户行" duration:2.0];
                //                [self.kaihuhangTF resignFirstResponder];
                return ;
            }
            //                        [self.kaihuhangTF becomeFirstResponder];
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"抱歉,暂时没有找到相关开户行" duration:2.0];
        [self.kaihuhangTF resignFirstResponder];
    }];
}

#pragma mark - Getter and Setter
- (BankPickView *)cityPicker
{
    if (!_cityPicker)
    {   _cityPicker.isAddressPicker = YES;
        _cityPicker = [[BankPickView alloc] init];
        _cityPicker.bankdelegate = self;
    }
    return _cityPicker;
}

- (IBAction)banLabelBtn:(UIButton *)sender
{
    [self.bankLabel becomeFirstResponder];

}

- (IBAction)provincesBtn:(UIButton *)sender
{
    [self.provincesTF becomeFirstResponder];

}

- (IBAction)kaihuhangBtn:(UIButton *)sender
{
    if ([self emptyTextOfTextField:self.provincesTF]) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"请先选择开户地" duration:1.5];
        [self.kaihuhangTF resignFirstResponder];
        return;
    }else if ([self emptyTextOfTextField:self.bankLabel]){
        [[JAlertViewHelper shareAlterHelper]showTint:@"请先选择开户地" duration:1.5];
        [self.kaihuhangTF resignFirstResponder];
        return;
    }else if ([self emptyTextOfTextField:self.wangdianTF]){
        [[JAlertViewHelper shareAlterHelper]showTint:@"请先选择开户网点" duration:1.5];
        [self.kaihuhangTF resignFirstResponder];
        return;
    }
    
    [self getBankRequest];
    [self.kaihuhangTF becomeFirstResponder];
}

- (IBAction)kaihuwangdianBtn:(UIButton *)sender
{
    if ([self emptyTextOfTextField:self.provincesTF]) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"请先选择开户地" duration:1.5];
        [self.wangdianTF resignFirstResponder];
        return;
    }else if ([self emptyTextOfTextField:self.bankLabel]){
        [[JAlertViewHelper shareAlterHelper]showTint:@"请先选择开户地" duration:1.5];
        [self.wangdianTF resignFirstResponder];
        return;
    }
    [self getBankPointRequest];
    [self.wangdianTF becomeFirstResponder];
}

- (IBAction)bingdingBtn:(UIButton *)sender
{
    self.nameTF.text =  [self.nameTF.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if ([self valueValidated]) {
        //绑定的请求
        Verify *ver = [[Verify alloc]init];
        if (![ver verifyPhoneNumber:self.phoneTF.text]) {
            [[JAlertViewHelper shareAlterHelper]showTint:@"您的电话号码格式不正确" duration:1.5];
            return;
        }
        NSString *bankNum = [self.bankCardNu.text stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSString *kaihuhNum = [self.kaihuhangNumdTF.text stringByReplacingOccurrencesOfString:@" " withString:@""];
        if (self.isMaual) {
            self.wangdianTF.text = @"";
            self.kaihuhangTF.text = @"";
        }else{
            self.inputKaihuhangTF.text = @"";
        }
        NSDictionary *parms = @{@"bankId":self.bank_id,
                                @"bankAccount":bankNum,
                                @"realName":self.nameTF.text,
                                @"bankPhone":self.phoneTF.text,
                                @"bankAccountPro":self.provincesTF.text,
                                @"token":[HDUserInfo shareUserInfos].token,
                                @"identity":NullToSpace(self.idCardNUTF.text),
                                @"bankPoint":NullToSpace(self.wangdianTF.text),
                                @"bankPointBranch":NullToSpace(self.kaihuhangTF.text),
                                @"bankBranch":NullToSpace(self.inputKaihuhangTF.text),
                                @"bankBranchNo":NullToSpace(kaihuhNum)};
        if (self.isYetBingdingCard) {
            [SVProgressHUD showWithStatus:@"正在提交..." maskType:SVProgressHUDMaskTypeBlack];
            [HttpClient POST:@"user/withdraw/bindBankcard/update" parameters:parms success:^(NSURLSessionDataTask *operation, id jsonObject) {
                [SVProgressHUD dismiss];
                if (IsRequestTrue) {
                    [[JAlertViewHelper shareAlterHelper]showTint:@"修改成功" duration:1.5];
                    [HDUserInfo shareUserInfos].bankAccount = bankNum;
                    [HDUserInfo shareUserInfos].bankAccountRealName = self.nameTF.text;
                    [HDUserInfo shareUserInfos].bindingFlag = @"1";
                    [HDUserInfo shareUserInfos].bankname= self.bank_id;
                    [self.viewController.navigationController popViewControllerAnimated:YES];
                }
            } failure:^(NSURLSessionDataTask *operation, NSError *error) {
                [SVProgressHUD dismiss];
                
            }];
            return;
        }
        [SVProgressHUD showWithStatus:@"正在提交..." maskType:SVProgressHUDMaskTypeBlack];
        
        [HttpClient POST:@"user/withdraw/bindBankcard/add" parameters:parms success:^(NSURLSessionDataTask *operation, id jsonObject) {
            [SVProgressHUD dismiss];
            if (IsRequestTrue) {
                [HDUserInfo shareUserInfos].bankname= self.bank_id;
                [[JAlertViewHelper shareAlterHelper]showTint:@"绑定成功" duration:1.5];
                [HDUserInfo shareUserInfos].bankAccount = bankNum;
                [HDUserInfo shareUserInfos].bankAccountRealName = self.nameTF.text;
                [HDUserInfo shareUserInfos].bindingFlag = @"1";
                [self.viewController.navigationController popViewControllerAnimated:YES];
            }
        } failure:^(NSURLSessionDataTask *operation, NSError *error) {
            [SVProgressHUD dismiss];
            
        }];
    }
}

-(BOOL) valueValidated {
    
    NSString *kaihuhNum = [self.kaihuhangNumdTF.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    // 判断电话号码是否合格
    if ([self emptyTextOfTextField:self.bankCardNu]) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"请输入银行卡号" duration:1.];
        return NO;
    }else if ([self emptyTextOfTextField:self.provincesTF]) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"请选择开户地址" duration:1.];
        return NO;
    }else if ([self emptyTextOfTextField:self.bankLabel]) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"请选择发卡银行" duration:1.];
        return NO;
    }else if ([self emptyTextOfTextField:self.nameTF]) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"请输入持卡人姓名" duration:1.];
        return NO;
    }else if ([self emptyTextOfTextField:self.phoneTF]) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"请输入银行预留手机号码" duration:1.];
        return NO;
    }else if (kaihuhNum.length !=0 && kaihuhNum.length !=12){
        [[JAlertViewHelper shareAlterHelper]showTint:@"您输入的开户行号只能是12位的数字" duration:1.];
        return NO;
    }
    if (!self.isMaual) {
        if ([self emptyTextOfTextField:self.wangdianTF]) {
            [[JAlertViewHelper shareAlterHelper]showTint:@"请选择开户网点" duration:1.];
            return NO;
        }else if ([self emptyTextOfTextField:self.kaihuhangTF]) {
            [[JAlertViewHelper shareAlterHelper]showTint:@"请输入开户银行" duration:1.];
            return NO;
        }
        else if ([self emptyTextOfTextField:self.wangdianTF]) {
            [[JAlertViewHelper shareAlterHelper]showTint:@"请选择开户网点" duration:1.];
            return NO;
        }
    }else{
        if ([self emptyTextOfTextField:self.inputKaihuhangTF]) {
            [[JAlertViewHelper shareAlterHelper]showTint:@"请手动输入对应支行" duration:1.];
            return NO;
        }
    }
    
    return YES;
}





-(BOOL) emptyTextOfTextField:(UITextField*) textField {
    
    if ([textField.text isEqualToString:@""] || !textField.text) {
        return YES;
    }
    return NO;
    
}

#pragma mark - UItextFileDelegate

//字数限制
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (self.bankCardNu == textField || self.kaihuhangNumdTF == textField) {
        //格式化银行卡号
        NSString *text = [textField text];
        NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789\b"];
        string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
        if ([string rangeOfCharacterFromSet:[characterSet invertedSet]].location != NSNotFound)
        {
            return NO;
        }
        text = [text stringByReplacingCharactersInRange:range withString:string];
        text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSString *newString = @"";
        while (text.length > 0)
        {
            NSString *subString = [text substringToIndex:MIN(text.length, 4)];
            newString = [newString stringByAppendingString:subString];
            if (subString.length == 4)
            {
                newString = [newString stringByAppendingString:@" "];
            }
            text = [text substringFromIndex:MIN(text.length, 4)];
        }
        newString = [newString stringByTrimmingCharactersInSet:[characterSet invertedSet]];
        
        if (textField == self.kaihuhangNumdTF && newString.length >=16) {
            [textField resignFirstResponder];
            return NO;
        }
        
        if (newString.length >= 24)
        {
            [textField resignFirstResponder];
            return NO;
        }
        [textField setText:newString];
        return NO;
    }
    if (textField == self.phoneTF) {
        if (self.phoneTF.text.length >10 && ![string isEqualToString:@""]) {
            return NO;
        }
    }
    if (textField == self.kaihuhangTF ) {
        if (self.kaihuhangTF.text.length >49 && ![string isEqualToString:@""]) {
            return NO;
        }
    }
    if (textField == self.kaihuhangNumdTF ) {
        if (self.kaihuhangNumdTF.text.length >49 && ![string isEqualToString:@""]) {
            return NO;
        }
    }
    if (textField == self.inputKaihuhangTF ) {
        if (self.inputKaihuhangTF.text.length >49 && ![string isEqualToString:@""]) {
            return NO;
        }
    }
    return YES;
}



- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == self.bankLabel) {
        self.tempkaihuhangName = @"";
        self.tempKaihuwangdianName = @"";
        self.kaihuhangTF.text = @"";
        self.wangdianTF.text = @"";
        [self getAllBankRequest];
    }
    if (textField == self.wangdianTF) {
        self.kaihuhangTF.text = @"";
        self.tempkaihuhangName = @"";
        if ([self emptyTextOfTextField:self.provincesTF]) {
            [[JAlertViewHelper shareAlterHelper]showTint:@"请先选择开户地" duration:1.5];
            [self.wangdianTF resignFirstResponder];
            return;
        }else if ([self emptyTextOfTextField:self.bankLabel]){
            [[JAlertViewHelper shareAlterHelper]showTint:@"请先选择开户地" duration:1.5];
            [self.wangdianTF resignFirstResponder];
            return;
        }
        [self getBankPointRequest];
    }
    
    if (textField == self.kaihuhangTF) {
        self.tempKaihuwangdianName = @"";
        if ([self emptyTextOfTextField:self.provincesTF]) {
            [[JAlertViewHelper shareAlterHelper]showTint:@"请先选择开户地" duration:1.5];
            [self.kaihuhangTF resignFirstResponder];
            return;
        }else if ([self emptyTextOfTextField:self.bankLabel]){
            [[JAlertViewHelper shareAlterHelper]showTint:@"请先选择开户地" duration:1.5];
            [self.kaihuhangTF resignFirstResponder];
            return;
        }else if ([self emptyTextOfTextField:self.wangdianTF]){
            [[JAlertViewHelper shareAlterHelper]showTint:@"请先选择开户网点" duration:1.5];
            [self.kaihuhangTF resignFirstResponder];
            return;
        }
        [self getBankRequest];
    }
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == self.provincesTF) {
        [self.provincesTF setText:[NSString stringWithFormat:@"%@",self.tempProName]];
    }
    if (textField == self.bankLabel) {
        [self.bankLabel setText:[NSString stringWithFormat:@"%@",self.tempBankName]];
    }
    if (textField == self.kaihuhangTF) {
        [self.kaihuhangTF setText:[NSString stringWithFormat:@"%@",self.tempkaihuhangName]];
    }
    if (textField == self.wangdianTF) {
        [self.wangdianTF setText:[NSString stringWithFormat:@"%@",self.tempKaihuwangdianName]];
    }
}



#pragma mark - 选择手动输入或者选择输入
- (IBAction)selcetInPutBtn:(UIButton *)sender {
    
    self.isMaual = YES;
}
- (IBAction)selectKahuhangBtn:(UIButton *)sender {
    
    self.isMaual = NO;

}
@end
