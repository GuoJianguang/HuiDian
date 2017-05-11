//
//  WalletDynammicTableViewCell.h
//  HuiDian
//
//  Created by mac on 2017/5/9.
//  Copyright © 2017年 Huidian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BillDataModel.h"

@interface WalletDynammicTableViewCell : BaseTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *markLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;

@property (weak, nonatomic) IBOutlet UIView *itemView;


@property (nonatomic, strong)TixianModel *tixianModel;

@property (nonatomic, strong)FanxianModel *fanxianModel;

@end
