//
//  WalletDynammicTableViewCell.m
//  HuiDian
//
//  Created by mac on 2017/5/9.
//  Copyright © 2017年 Huidian. All rights reserved.
//

#import "WalletDynammicTableViewCell.h"

@implementation WalletDynammicTableViewCell

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

- (void)setTixianModel:(TixianModel *)tixianModel
{
    _tixianModel = tixianModel;
    NSString *markStr = [NSString string];
    switch ([_tixianModel.state integerValue]) {
        case 0:
        {
            markStr = @"提现中";
            self.moneyLabel.textColor = self.markLabel.textColor = [UIColor colorFromHexString:@"#aaaaaa"];
        }
            break;
        case 1:
        {
            markStr = @"提现中";
            self.moneyLabel.textColor = self.markLabel.textColor = [UIColor colorFromHexString:@"#aaaaaa"];
        }
            break;
        case 2:
        {
            markStr = @"提现中";
            self.moneyLabel.textColor = self.markLabel.textColor = [UIColor colorFromHexString:@"#aaaaaa"];
        }
            break;
        case 3:
        {
            self.moneyLabel.textColor = self.markLabel.textColor = MacoYellowColor;
            markStr = @"成功";
        }
            break;
        case 4:
        {
            self.moneyLabel.textColor = self.markLabel.textColor =  [UIColor colorFromHexString:@"#dd137b"];
            markStr = @"失败";
        }
            break;
        default:
            break;
    }
    
    self.moneyLabel.text = markStr;
    self.timeLabel.text = _tixianModel.successTime;
    self.markLabel.text = [NSString stringWithFormat:@"¥%.2f", [_tixianModel.withdrawAmout doubleValue]];
    
}

- (void)setFanxianModel:(FanxianModel *)fanxianModel
{
    _fanxianModel = fanxianModel;
    self.markLabel.textColor = self.moneyLabel.textColor = MacoYellowColor;
    self.timeLabel.text =_fanxianModel.tranTime;
    self.moneyLabel.text = [NSString stringWithFormat:@"+¥%.2f",[_fanxianModel.amount doubleValue]];
    self.markLabel.text = [NSString stringWithFormat:@"抵用金%.2f",[_fanxianModel.consumeBalance doubleValue]];
}

@end
