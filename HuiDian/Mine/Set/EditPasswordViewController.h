//
//  EditPasswordViewController.h
//  HuiDian
//
//  Created by mac on 2017/5/12.
//  Copyright © 2017年 Huidian. All rights reserved.
//

#import "BaseViewController.h"

@interface EditPasswordViewController : BaseViewController


@property (weak, nonatomic) IBOutlet UITextField *oldPassword_tf;

@property (weak, nonatomic) IBOutlet UITextField *pasword_tf;

@property (weak, nonatomic) IBOutlet UITextField *surePassword_tf;

@property (weak, nonatomic) IBOutlet UILabel *label1;

@property (weak, nonatomic) IBOutlet UILabel *label2;

@property (weak, nonatomic) IBOutlet UILabel *label3;

- (IBAction)sureBtn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;

@property (weak, nonatomic) IBOutlet UIView *itemView;

@end
