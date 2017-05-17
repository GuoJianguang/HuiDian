//
//  MerchantDetailTableViewCell.h
//  HuiDian
//
//  Created by mac on 2017/5/16.
//  Copyright © 2017年 Huidian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BussessDetailModel.h"

@interface MerchantDetailTableViewCell : BaseTableViewCell

@property (weak, nonatomic) IBOutlet SwipeView *swipeView;

@property (weak, nonatomic) IBOutlet UIPageControl *pageCongtrol;

@property(nonatomic, strong)BussessDetailModel *dataModel;
- (IBAction)backBtn:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *mchantName;
- (IBAction)callPhoneBtn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *addressBtn;
- (IBAction)addressBtn:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIView *imageSuperView;


@end
