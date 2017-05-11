//
//  WalletDynamicOtherTableViewCell.m
//  HuiDian
//
//  Created by mac on 2017/5/9.
//  Copyright © 2017年 Huidian. All rights reserved.
//

#import "WalletDynamicOtherTableViewCell.h"

@implementation WalletDynamicOtherTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.itemView.layer.cornerRadius = 10;
    self.itemView.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setXiaofeijiluModel:(BillDataModel *)xiaofeijiluModel
{
    _xiaofeijiluModel = xiaofeijiluModel;
    self.markLabel.text = _xiaofeijiluModel.mchName;
    self.timeLabel.text = _xiaofeijiluModel.tranTime;
    self.buyCardLabel.text = @"";
    NSString *statusStr = [NSString string];
    
    switch ([_xiaofeijiluModel.state integerValue]) {
        case 1:
        {
            statusStr = @"支付成功";
            self.statusLabel.textColor = self.moneyLabel.textColor = self.buyCardLabel.textColor = MacoYellowColor;
        }
            break;
        case 2:
        {
            statusStr = @"支付成功";
            self.statusLabel.textColor = self.moneyLabel.textColor = self.buyCardLabel.textColor = MacoYellowColor;
        }
            break;
        case 3:
        {
            self.statusLabel.textColor = self.moneyLabel.textColor = self.buyCardLabel.textColor = [UIColor colorFromHexString:@"#aaaaaa"];
            statusStr = @"冻结中";
        }
            break;
        default:
            break;
    }
    
    switch ([_xiaofeijiluModel.channel integerValue]) {
        case 1://线下现金支付
            self.sortImageview.image = [UIImage imageNamed:@"icon_cash_payment_nor"];
            break;
        case 3://`pay_type`     '0余额支付 1微信支付
        {
            if ([_xiaofeijiluModel.payType isEqualToString:@"0"]) {
                self.buyCardLabel.text = [NSString stringWithFormat:@"(含购物券%@)",_xiaofeijiluModel.consumeAmount];
                
                self.sortImageview.image = [UIImage imageNamed:@"icon_balance_payment_nor"];
            }else{
                self.sortImageview.image = [UIImage imageNamed:@"icon_wechat_payment_nor"];
            }
        }
            break;
        default:
            break;
    }
    self.moneyLabel.text = [NSString stringWithFormat:@"¥%.2f",[_xiaofeijiluModel.totalAmount doubleValue]];
    self.statusLabel.text = statusStr;
}


@end
