//
//  MineTableViewCell.m
//  HuiDian
//
//  Created by mac on 2017/5/9.
//  Copyright © 2017年 Huidian. All rights reserved.
//

#import "MineTableViewCell.h"
#import "WalletDynamicViewController.h"

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
    
    self.xiaofeiLabel.text = [NSString stringWithFormat:@"消费抵用金%.2f元",[[HDUserInfo shareUserInfos].consumeBalance doubleValue]];
    self.yuELabel.text = [NSString stringWithFormat:@"%.2f",[[HDUserInfo shareUserInfos].aviableBalance doubleValue]];
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:[HDUserInfo shareUserInfos].avatar] placeholderImage:LoadingErrorDefaultHearder completed:NULL];
    [self searchUserInfor];
}


- (void)searchUserInfor
{
    NSString *token = [HDUserInfo shareUserInfos].token;
    //获取用户最新消息
    [HttpClient POST:@"user/userBaseInfo/get" parameters:@{@"token":token} success:^(NSURLSessionDataTask *operation, id jsonObject) {
        if (IsRequestTrue) {
            
            [[HDUserInfo shareUserInfos]setUserinfoWithdic:jsonObject[@"data"]];
            
//            if ([[HDUserInfo shareUserInfos].messageCount isEqualToString:@"0"]) {
//                [self.messageBtn setImage:[UIImage imageNamed:@"icon_news"] forState:UIControlStateNormal];
//                
//            }else{
//                [self.messageBtn setImage:[UIImage imageNamed:@"icon_haveNews"] forState:UIControlStateNormal];
//            };
            self.xiaofeiLabel.text = [NSString stringWithFormat:@"消费抵用金%.2f元",[[HDUserInfo shareUserInfos].consumeBalance doubleValue]];
            self.yuELabel.text = [NSString stringWithFormat:@"%.2f",[[HDUserInfo shareUserInfos].aviableBalance doubleValue]];
            [HDUserInfo shareUserInfos].token = token;
            
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
    }];

}
- (IBAction)withDrawBtn:(UIButton *)sender {
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)goConsumeBtn:(UIButton *)sender {
}

- (IBAction)setBtn:(UIButton *)sender {
}

- (IBAction)walletBtn:(UIButton *)sender {
    WalletDynamicViewController *walletVC = [[WalletDynamicViewController alloc]init];
    [self.viewController.navigationController pushViewController:walletVC animated:YES];
}
@end
