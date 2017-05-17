//
//  RootViewController.m
//  HuiDian
//
//  Created by mac on 2017/5/17.
//  Copyright © 2017年 Huidian. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()<UIAlertViewDelegate>

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(autoLogin) name:AutoLoginAfterGetDeviceToken object:nil];
    [self autoLogin];

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{

    //去登录
    if (buttonIndex == 1) {
        UINavigationController *logvc = [LoginViewController controller];
        [self presentViewController:logvc animated:YES completion:NULL];
    }
 
}

#pragma mark - 自动登录
- (void)autoLogin
{
    if ([[NSUserDefaults standardUserDefaults]objectForKey:LoginUserPassword]) {
        NSString *password = [[NSString stringWithFormat:@"%@%@",[[NSUserDefaults standardUserDefaults]objectForKey:LoginUserPassword],PasswordKey]md5_32];
        
        NSDictionary *parms = @{@"phone":[[NSUserDefaults standardUserDefaults]objectForKey:LoginUserName],
                                @"deviceToken":NullToSpace([HDUserInfo shareUserInfos].devicetoken),
                                @"deviceType":@"ios",
                                @"password":password};
        [HttpClient POST:@"user/login" parameters:parms success:^(NSURLSessionDataTask *operation, id jsonObject) {
            if (IsRequestTrue) {
                //设置用户信息
                [HDUserInfo shareUserInfos].currentLogined = YES;
                [[HDUserInfo shareUserInfos]setUserinfoWithdic:jsonObject[@"data"]];
                //统计新增用户
                //                [MobClick profileSignInWithPUID:[TTXUserInfo shareUserInfos].userid];
                if ([HDUserInfo shareUserInfos].islaunchFormNotifi) {
//                    [self notifica:[ShellCoinUserInfo shareUserInfos].notificationParms];
                    [HDUserInfo shareUserInfos].islaunchFormNotifi = NO;
                }
            }
        } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        }];
    }
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
