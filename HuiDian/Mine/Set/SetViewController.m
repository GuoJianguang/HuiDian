//
//  SetViewController.m
//  HuiDian
//
//  Created by mac on 2017/5/11.
//  Copyright © 2017年 Huidian. All rights reserved.
//

#import "SetViewController.h"
#import "RealNameSetViewController.h"

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
    
}
- (IBAction)addressBtn:(UIButton *)sender {
    
}
- (IBAction)editPasswordBtn:(UIButton *)sender {
    
}
- (IBAction)myRecommendBtn:(UIButton *)sender {
    
}
- (IBAction)ClearCacheBtn:(UIButton *)sender {
    
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

@end
