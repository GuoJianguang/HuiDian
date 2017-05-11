//
//  WalletDynamicOtherTableViewCell.h
//  HuiDian
//
//  Created by mac on 2017/5/9.
//  Copyright © 2017年 Huidian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BillDataModel.h"

@interface WalletDynamicOtherTableViewCell : BaseTableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *markImageView;
@property (weak, nonatomic) IBOutlet UILabel *markLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;

@property (weak, nonatomic) IBOutlet UIImageView *sortImageview;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@property (nonatomic, strong)BillDataModel *xiaofeijiluModel;

@property (weak, nonatomic) IBOutlet UILabel *buyCardLabel;

@property (weak, nonatomic) IBOutlet UIView *itemView;



@end
