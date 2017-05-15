//
//  SetViewController.m
//  HuiDian
//
//  Created by mac on 2017/5/11.
//  Copyright © 2017年 Huidian. All rights reserved.
//

#import "SetViewController.h"
#import "RealNameSetViewController.h"
#import "EditPasswordViewController.h"
#import "AdressListViewController.h"
#import "MyRecommendListViewController.h"
#import "BankCardManageViewController.h"

@interface SetViewController ()<BasenavigationDelegate>

@end

@implementation SetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.naviBar.title = @"设置";
    self.naviBar.delegate = self;
    self.naviBar.hiddenDetailBtn = NO;
    self.naviBar.detailTitle = @"退出登录";
    [self.view sendSubviewToBack:self.bgImageView];
    
    self.itemView.layer.cornerRadius = 20;
    self.itemView.layer.masksToBounds = YES;
    self.itemView.backgroundColor = MacoYellowColor;
    self.view1.backgroundColor = self.view2.backgroundColor = self.view3.backgroundColor = self.view4.backgroundColor = self.view5.backgroundColor = self.view7.backgroundColor =self.view6.backgroundColor=MacoTitleColor;
    [self.aboutsBtn setTitleColor:MacoTitleColor forState:UIControlStateNormal];
    [self.realNameBtn setTitleColor:MacoTitleColor forState:UIControlStateNormal];
    [self.bankManageMentBtn setTitleColor:MacoTitleColor forState:UIControlStateNormal];
    [self.addressBtn setTitleColor:MacoTitleColor forState:UIControlStateNormal];
    [self.editPasswordBtn setTitleColor:MacoTitleColor forState:UIControlStateNormal];
    [self.myRecommendBtn setTitleColor:MacoTitleColor forState:UIControlStateNormal];
    [self.ClearCacheBtn setTitleColor:MacoTitleColor forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 退出登录
- (void)detailBtnClick
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"您确定要退出登录吗？" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    NSArray *titles = @[@"退出"];
    [self addActionTarget:alert titles:titles];
    [self addCancelActionTarget:alert title:@"取消"];
    // 会更改UIAlertController中所有字体的内容（此方法有个缺点，会修改所以字体的样式）
    UILabel *appearanceLabel = [UILabel appearanceWhenContainedIn:UIAlertController.class, nil];
    UIFont *font = [UIFont systemFontOfSize:15];
    [appearanceLabel setFont:font];
    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)realNameBtn:(UIButton *)sender {
    RealNameSetViewController *realNameVC = [[RealNameSetViewController alloc]init];
    if ([HDUserInfo shareUserInfos].identityFlag) {
        realNameVC.isYetAut = YES;
    }else{
        realNameVC.isYetAut = NO;
    }
    [self.navigationController pushViewController:realNameVC animated:YES];
}
- (IBAction)bankManageMentBtn:(UIButton *)sender {
    if ([self gotRealNameRu:@"在您管理您的银行卡之前，请先进行实名认证"]){
        return;
    }
    if ([HDUserInfo shareUserInfos].bindingFlag){
        sender.enabled = NO;
        NSDictionary *parms = @{@"token":[HDUserInfo shareUserInfos].token};
        [HttpClient GET:@"user/withdraw/bindBankcard/get" parameters:parms success:^(NSURLSessionDataTask *operation, id jsonObject) {
            if (IsRequestTrue) {
                BankCardManageViewController *bankcardVC = [[BankCardManageViewController alloc]init];
                bankcardVC.isYetBingdingCard = YES;
                bankcardVC.bankcardInfo = jsonObject[@"data"];
                [self.navigationController pushViewController:bankcardVC animated:YES];
            }
            sender.enabled = YES;
        }failure:^(NSURLSessionDataTask *operation, NSError *error) {
            sender.enabled = YES;
        }];
        return;
    }
    BankCardManageViewController *bankcardVC = [[BankCardManageViewController alloc]init];
    bankcardVC.isYetRealnameAuthentication = YES;
    bankcardVC.realnameAuDic = @{@"name":[HDUserInfo shareUserInfos].idcardName,
                                 @"idcardnumber":[HDUserInfo shareUserInfos].idcard};
    [self.navigationController pushViewController:bankcardVC animated:YES];
}
- (IBAction)addressBtn:(UIButton *)sender {
    AdressListViewController *addressVC = [[AdressListViewController alloc]init];
    [self.navigationController pushViewController:addressVC animated:YES];
    
}
- (IBAction)editPasswordBtn:(UIButton *)sender {
    EditPasswordViewController *passwordVC = [[EditPasswordViewController alloc]init];
    [self.navigationController pushViewController:passwordVC animated:YES];
    
}
- (IBAction)myRecommendBtn:(UIButton *)sender {
    MyRecommendListViewController *recommendVC = [[MyRecommendListViewController alloc]init];
    [self.navigationController pushViewController:recommendVC animated:YES];
}
- (IBAction)ClearCacheBtn:(UIButton *)sender {
    [SVProgressHUD showWithStatus:@"正在清除..."];
    [[SDImageCache sharedImageCache]clearDisk];
    [[SDImageCache sharedImageCache]clearMemory];
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
        [SVProgressHUD showSuccessWithStatus:@"清除完毕"];
        
    }];
}

- (IBAction)aboutsBtn:(UIButton *)sender {
    
}

#pragma mark - 退出登录的方法

// 添加其他按钮
- (void)addActionTarget:(UIAlertController *)alertController titles:(NSArray *)titles
{
    for (NSString *title in titles) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [HttpClient POST:@"user/logout" parameters:@{@"token":[HDUserInfo shareUserInfos].token} success:^(NSURLSessionDataTask *operation, id jsonObject) {
                
            } failure:^(NSURLSessionDataTask *operation, NSError *error) {
            }];
            [HDUserInfo shareUserInfos].currentLogined = NO;
            [self.navigationController popToRootViewControllerAnimated:YES];
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:LoginUserPassword];
            //统计新增用户
            //            [MobClick profileSignOff];
            [[NSUserDefaults standardUserDefaults]synchronize];
            [[NSNotificationCenter defaultCenter]postNotificationName:LogOutNSNotification object:nil userInfo:nil];
        }];
        [action setValue:MacoColor forKey:@"_titleTextColor"];
        [alertController addAction:action];
    }
}

// 取消按钮
- (void)addCancelActionTarget:(UIAlertController *)alertController title:(NSString *)title
{
    UIAlertAction *action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }];
    [action setValue:MacoTitleColor forKey:@"_titleTextColor"];
    [alertController addAction:action];
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
            [self.navigationController pushViewController:realNameVC animated:YES];
        }];
        [alertcontroller addAction:cancelAction];
        [alertcontroller addAction:otherAction];
        [self presentViewController:alertcontroller animated:YES completion:NULL];
        return YES;
    }
    return NO;
}



@end
