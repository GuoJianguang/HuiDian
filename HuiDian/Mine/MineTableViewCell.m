//
//  MineTableViewCell.m
//  HuiDian
//
//  Created by mac on 2017/5/9.
//  Copyright © 2017年 Huidian. All rights reserved.
//

#import "MineTableViewCell.h"
#import "WalletDynamicViewController.h"
#import "SetViewController.h"
#import <QiniuSDK.h>
#import "LBXScanWrapper.h"
#import "LBXAlertAction.h"
#import "WithDrawViewController.h"
#import "RealNameSetViewController.h"
#import "BankCardManageViewController.h"

@interface MineTableViewCell()<UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic, strong)UILabel *waitFeedbackAmount;

@end

@implementation MineTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.withDrawBtn.layer.cornerRadius = 15;
    self.withDrawBtn.layer.borderWidth = 1;
    self.withDrawBtn.layer.masksToBounds = YES;
    self.withDrawBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    self.withDrawBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    self.yuELabel.adjustsFontSizeToFitWidth = YES;
    self.centerImageView.contentMode = UIViewContentModeCenter;
    self.centerImageView.layer.masksToBounds = YES;
    self.centerImageView.clipsToBounds = YES;
    self.goConsumeBtn.layer.cornerRadius = 15;
    self.goConsumeBtn.layer.masksToBounds = YES;
    self.xiaofeiLabel.adjustsFontSizeToFitWidth= YES;
    self.setLabel.textColor = self.walletLabel.textColor = [UIColor colorFromHexString:@"#aaaaaa"];
    self.xiaofeiLabel.textColor = self.waitfeedback.textColor =self.totalconsumptionAmount.textColor= MacoTitleColor;
    
    self.xiaofeiLabel.text = [NSString stringWithFormat:@"消费抵用金%.2f元",[[HDUserInfo shareUserInfos].consumeBalance doubleValue]];
    self.yuELabel.text = [NSString stringWithFormat:@"%.2f",[[HDUserInfo shareUserInfos].aviableBalance doubleValue]];
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:[HDUserInfo shareUserInfos].avatar] placeholderImage:LoadingErrorDefaultHearder completed:NULL];
    self.headImageView.layer.cornerRadius = (TWitdh*(128/375.) -30)/2.;
    self.headImageView.layer.masksToBounds = YES;
    self.nameLabel.text = [HDUserInfo shareUserInfos].idcardName;
    
    self.xiaofeiView.backgroundColor = MacoYellowColor;
    
    self.amountProgressView.reduceValue = 180;
    self.amountProgressView.increaseFromLast = NO;
    self.amountProgressView.pointImage = [UIImage imageNamed:@"pic_indicating_circle"];
    self.amountProgressView.showProgressText = NO;
    [self.progressSuperView addSubview:self.amountProgressView];
    
    self.lainAmountProgressView.reduceValue = 180;
    self.lainAmountProgressView.increaseFromLast = NO;
    self.lainAmountProgressView.progress = 1;
    self.lainAmountProgressView.showProgressText = NO;
    self.lainAmountProgressView.showPoint = NO;
    [self.progressSuperView addSubview:self.lainAmountProgressView];
    
    self.waitFeedbackAmount.bounds = CGRectMake(0, 0, TWitdh - 250, 50);
    self.waitFeedbackAmount.center = CGPointMake(self.lainAmountProgressView.center.x, self.lainAmountProgressView.center.y - 32) ;
    [self.progressSuperView addSubview:self.waitFeedbackAmount];
    
    [self searchUserInfor];

    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changeHead)];
    self.headImageView.userInteractionEnabled = YES;
    [self.headImageView addGestureRecognizer:tap];
}

- (UILabel *)waitFeedbackAmount
{
    if (!_waitFeedbackAmount) {
        _waitFeedbackAmount = [[UILabel alloc]init];
        _waitFeedbackAmount.adjustsFontSizeToFitWidth = YES;
        _waitFeedbackAmount.font = [UIFont systemFontOfSize:28];
        _waitFeedbackAmount.textColor = [UIColor colorFromHexString:@"#dd137b"];
        _waitFeedbackAmount.font = [UIFont boldSystemFontOfSize:28];
        _waitFeedbackAmount.textAlignment = NSTextAlignmentCenter;
    }
    return  _waitFeedbackAmount;
}

- (ZZCircleProgress *)amountProgressView
{
    if (!_amountProgressView) {
        _amountProgressView = [[ZZCircleProgress alloc] initWithFrame:CGRectMake(70, 0, TWitdh - 140, TWitdh - 140) pathBackColor:MacoTitleColor pathFillColor:[UIColor colorFromHexString:@"#dd137b"] startAngle:180 strokeWidth:13];
    }
    return _amountProgressView;
}
- (ZZCircleProgress *)lainAmountProgressView
{
    if (!_lainAmountProgressView) {
        _lainAmountProgressView = [[ZZCircleProgress alloc] initWithFrame:CGRectMake(90, 21, TWitdh - 180, TWitdh - 180) pathBackColor:MacoTitleColor pathFillColor:MacoTitleColor startAngle:180 strokeWidth:5];
    }
    return _lainAmountProgressView;
}

- (void)searchUserInfor
{
    NSString *token = [HDUserInfo shareUserInfos].token;
    //获取用户最新消息
    [HttpClient POST:@"user/userBaseInfo/get" parameters:@{@"token":token} success:^(NSURLSessionDataTask *operation, id jsonObject) {
        if (IsRequestTrue) {
            
            [[HDUserInfo shareUserInfos]setUserinfoWithdic:jsonObject[@"data"]];
            self.nameLabel.text = [HDUserInfo shareUserInfos].idcardName;
            self.totalconsumptionAmount.text = [NSString stringWithFormat:@"总消费金额¥%.2f",[[HDUserInfo shareUserInfos].totalConsumeAmount doubleValue]];
            self.waitFeedbackAmount.text = [NSString stringWithFormat:@"¥%.2f",[[HDUserInfo shareUserInfos].totalExpectAmount doubleValue] + [[HDUserInfo shareUserInfos].wiatJoinAmunt doubleValue]];
            self.xiaofeiLabel.text = [NSString stringWithFormat:@"消费抵用金%.2f元",[[HDUserInfo shareUserInfos].consumeBalance doubleValue]];
            self.yuELabel.text = [NSString stringWithFormat:@"%.2f",[[HDUserInfo shareUserInfos].aviableBalance doubleValue]];
            
            self.amountProgressView.progress = ([[HDUserInfo shareUserInfos].totalExpectAmount doubleValue] + [[HDUserInfo shareUserInfos].wiatJoinAmunt doubleValue]) /[[HDUserInfo shareUserInfos].totalConsumeAmount doubleValue];

            
            [HDUserInfo shareUserInfos].token = token;
            
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
    }];

}
- (IBAction)withDrawBtn:(UIButton *)sender {
    //首先判断用户时候已经实名认证
    if ([self gotRealNameRu:@"在您申请提现之前,请先进行实名认证"]){
        return;
    }
    //再判断是否绑定银行卡
    if (![HDUserInfo shareUserInfos].bindingFlag) {
        [self goBingdingBank:@"您还未绑定银行卡，请先绑定银行卡"];
    }
    WithDrawViewController *withDrawVC = [[WithDrawViewController alloc]init];
    [self.viewController.navigationController pushViewController:withDrawVC animated:YES];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - 去消费
- (IBAction)goConsumeBtn:(UIButton *)sender {
    
}

#pragma mark - 设置按钮
- (IBAction)setBtn:(UIButton *)sender {
    SetViewController *setVC = [[SetViewController alloc]init];
    [self.viewController.navigationController pushViewController:setVC animated:YES];
    
}

- (IBAction)walletBtn:(UIButton *)sender {
    WalletDynamicViewController *walletVC = [[WalletDynamicViewController alloc]init];
    [self.viewController.navigationController pushViewController:walletVC animated:YES];
}



#pragma mark - 改变头像
- (void)changeHead{
    NSLog(@"changeHead");
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"请选择头像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从手机选择",@"拍照", nil];
    [sheet showInView:self.viewController.view];
}


#pragma mark - 去进行实名认证
- (BOOL)gotRealNameRu:(NSString *)alerTitle
{
    if (![HDUserInfo shareUserInfos].identityFlag) {
        UIAlertController *alertcontroller = [UIAlertController alertControllerWithTitle:@"重要提示" message:alerTitle preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        }];
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"去认证" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            //去进行实名认证
            RealNameSetViewController *realNameVC = [[RealNameSetViewController alloc]init];
            realNameVC.isYetAut = NO;
            [self.viewController.navigationController pushViewController:realNameVC animated:YES];
        }];
        [alertcontroller addAction:cancelAction];
        [alertcontroller addAction:otherAction];
        [self.viewController presentViewController:alertcontroller animated:YES completion:NULL];
        return YES;
    }
    return NO;
}



#pragma mark - 去绑定银行卡
- (void)goBingdingBank:(NSString *)alerTitle
{
    UIAlertController *alertcontroller = [UIAlertController alertControllerWithTitle:@"重要提示" message:alerTitle preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
    }];
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"去绑定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //去绑定银行卡
        BankCardManageViewController *bankcardVC = [[BankCardManageViewController alloc]init];
        bankcardVC.isYetRealnameAuthentication = YES;
        bankcardVC.realnameAuDic = @{@"name":[HDUserInfo shareUserInfos].idcardName,
                                     @"idcardnumber":[HDUserInfo shareUserInfos].idcard};
        [self.viewController.navigationController pushViewController:bankcardVC animated:YES];
    }];
    [alertcontroller addAction:cancelAction];
    [alertcontroller addAction:otherAction];
    [self.viewController presentViewController:alertcontroller animated:YES completion:NULL];
}


#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
        {
            [self presentAlbum];
        }
            break;
            //进入照相界面
        case 1:
        {
            
            [self prsentCamera];
        }
            break;
            
        default:
            break;
    }
}
#pragma mark - 进入照相机
- (void)prsentCamera
{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        NSLog(@"该设备不支持照相");
        return;
    }
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    
    imagePickerController.delegate = self;
    
    imagePickerController.allowsEditing = YES;
    
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self.viewController presentViewController:imagePickerController animated:YES completion:^{}];
}
#pragma mark - 打开本地相册
- (void)presentAlbum
{
    if ([LBXScanWrapper isGetPhotoPermission])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        picker.delegate = self;
        
        
        picker.allowsEditing = YES;
        
        
        [self.viewController presentViewController:picker animated:YES completion:nil];
    }else
    {
        [self showError:@"      请到设置->隐私中开启本程序相册权限     "];
    }
}

#pragma mark -- UIImagePickerControllerDelegate

-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    __block UIImage* image = [info objectForKey:UIImagePickerControllerEditedImage];
    
    if (!image){
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    
    __weak __typeof(self) weakSelf = self;
    
    [HttpClient POST:@"user/getQiniuToken" parameters:nil success:^(NSURLSessionDataTask *operation, id jsonObject) {
        NSString *qiniuToken = jsonObject[@"data"];
        [self upLoadImage:image withToken:qiniuToken];
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"cancel");
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}


- (void)showError:(NSString*)str
{
    [LBXAlertAction showAlertWithTitle:@"提示" msg:str chooseBlock:nil buttonsStatement:@"知道了",nil];
}

#pragma mark - 上传照片
- (void)upLoadImage:(UIImage *)image withToken:(NSString *)qiniuToken
{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:DateFormatterString];
    NSString *string = [formatter stringFromDate:date];
    NSString *strRandom = @"";
    for(int i=0; i< 6; i++)
    {
        strRandom = [strRandom stringByAppendingFormat:@"%i",(arc4random() % 9)];
    }
    
    NSString *imageSuffix = @"jpg";
    NSData *imageData = UIImageJPEGRepresentation(image, 0.4f);
    if (!imageData) {
        imageData = UIImagePNGRepresentation(image);
        imageSuffix = @"png";
    }
    
    QNConfiguration *config = [QNConfiguration build:^(QNConfigurationBuilder *builder) {
        QNServiceAddress *s1 = [[QNServiceAddress alloc] init:@"https://upload.qbox.me" ips:@[@"183.136.139.16"]];
        QNServiceAddress *s2 = [[QNServiceAddress alloc] init:@"https://up.qbox.me" ips:@[@"183.136.139.16"]];
        builder.zone = [[QNFixedZone alloc] initWithUp:s1 upBackup:s2];
    }];
    QNUploadManager *upManager = [[QNUploadManager alloc] initWithConfiguration:config];
    NSString *randomDkey = [NSString stringWithFormat:@"%@.%@",[string stringByAppendingString:strRandom],imageSuffix];
    [SVProgressHUD showWithStatus:@"正在上传头像"];
    [upManager putData:imageData key:randomDkey token:qiniuToken
              complete: ^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                  [SVProgressHUD dismiss];
                  if (info.error) {
                      [SVProgressHUD dismiss];
                      [[JAlertViewHelper shareAlterHelper]showTint:@"头像上传失败,请稍后重试" duration:1.5];
                      return;
                  }
                  NSDictionary *prams = @{@"avatar":resp[@"key"],
                                          @"token":[HDUserInfo shareUserInfos].token};
                  [HttpClient POST:@"user/userInfo/update" parameters:prams success:^(NSURLSessionDataTask *operation, id jsonObject) {
                      if (IsRequestTrue) {
                          [HDUserInfo shareUserInfos].avatar = jsonObject[@"data"][@"avatar"];
                          [self.headImageView sd_setImageWithURL:[NSURL URLWithString:[HDUserInfo shareUserInfos].avatar] placeholderImage:LoadingErrorDefaultHearder completed:NULL];
                          
                          [SVProgressHUD showSuccessWithStatus:@"头像修改成功"];
                          
                          
                      }
                      
                  } failure:^(NSURLSessionDataTask *operation, NSError *error) {
                      [SVProgressHUD dismiss];
                  }];
                  
              } option:nil];
}

@end
