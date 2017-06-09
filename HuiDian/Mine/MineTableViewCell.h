//
//  MineTableViewCell.h
//  HuiDian
//
//  Created by mac on 2017/5/9.
//  Copyright © 2017年 Huidian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZCircleProgress.h"
#import "RoundView.h"

@interface MineTableViewCell : BaseTableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *yuELabel;

@property (weak, nonatomic) IBOutlet UIButton *withDrawBtn;
- (IBAction)withDrawBtn:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIImageView *centerImageView;

@property (weak, nonatomic) IBOutlet UILabel *xiaofeiLabel;

@property (weak, nonatomic) IBOutlet UIButton *goConsumeBtn;

- (IBAction)goConsumeBtn:(UIButton *)sender;
- (IBAction)setBtn:(UIButton *)sender;

- (IBAction)walletBtn:(UIButton *)sender;

@property (strong, nonatomic) ZZCircleProgress *amountProgressView;
@property (strong, nonatomic) ZZCircleProgress *lainAmountProgressView;

@property (weak, nonatomic) IBOutlet RoundView *progressSuperView;

@property (weak, nonatomic) IBOutlet UIView *xiaofeiView;



@property (weak, nonatomic) IBOutlet UILabel *totalconsumptionAmount;
@property (weak, nonatomic) IBOutlet UILabel *waitfeedback;

@property (weak, nonatomic) IBOutlet UILabel *walletLabel;
@property (weak, nonatomic) IBOutlet UILabel *setLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomheight;

@end
