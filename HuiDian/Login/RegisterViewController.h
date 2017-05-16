//
//  RegisterViewController.h
//  HuiDian
//
//  Created by mac on 2017/5/9.
//  Copyright © 2017年 Huidian. All rights reserved.
//

#import "BaseViewController.h"

@interface RegisterViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UIView *itemView;

@property (weak, nonatomic) IBOutlet UITextField *phoneTF;

@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UITextField *grapCodeTF;

@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UITextField *phoneCodeTF;

@property (weak, nonatomic) IBOutlet UIView *view3;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;

@property (weak, nonatomic) IBOutlet UIView *view4;
@property (weak, nonatomic) IBOutlet UITextField *surePasswordTF;

@property (weak, nonatomic) IBOutlet UIView *view5;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
- (IBAction)sureBtn:(UIButton *)sender;


@property (weak, nonatomic) IBOutlet UIButton *getGraphBtn;

- (IBAction)getGraphBtn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *codeBtn;
- (IBAction)codeBtn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *protocelLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rgiht;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *left;

@end
