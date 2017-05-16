//
//  LoginViewController.h
//  HuiDian
//
//  Created by mac on 2017/5/4.
//  Copyright © 2017年 Huidian. All rights reserved.
//

#import "BaseViewController.h"

@interface LoginViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
- (IBAction)loginBtn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet UITextField *userTF;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
- (IBAction)registerBtn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *forgetBtn;

- (IBAction)forgetBtn:(UIButton *)sender;

+ (UINavigationController *)controller;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginBtnHeight;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topHeight;

@end
