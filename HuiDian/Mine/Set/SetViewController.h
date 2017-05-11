//
//  SetViewController.h
//  HuiDian
//
//  Created by mac on 2017/5/11.
//  Copyright © 2017年 Huidian. All rights reserved.
//

#import "BaseViewController.h"

@interface SetViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UIButton *realNameBtn;

- (IBAction)realNameBtn:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIButton *bankManageMentBtn;
- (IBAction)bankManageMentBtn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *addressBtn;
- (IBAction)addressBtn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *editPasswordBtn;
- (IBAction)editPasswordBtn:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIButton *myRecommendBtn;
- (IBAction)myRecommendBtn:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIButton *ClearCacheBtn;

- (IBAction)ClearCacheBtn:(UIButton *)sender;

- (IBAction)aboutsBtn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *aboutsBtn;

@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UIView *view3;
@property (weak, nonatomic) IBOutlet UIView *view4;
@property (weak, nonatomic) IBOutlet UIView *view5;
@property (weak, nonatomic) IBOutlet UIView *view6;
@property (weak, nonatomic) IBOutlet UIView *view7;

@property (weak, nonatomic) IBOutlet UIView *itemView;

@end
