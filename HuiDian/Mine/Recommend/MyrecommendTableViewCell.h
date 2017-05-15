//
//  MyrecommendTableViewCell.h
//  HuiDian
//
//  Created by mac on 2017/5/15.
//  Copyright © 2017年 Huidian. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - 邀请的Model

@interface InnitationModel : BaseModel
/**
 * 时间
 */
@property (nonatomic,copy)NSString *tranTime;
/**
 * 收益金额
 */
@property (nonatomic,copy)NSString *tranAmount;

//1商户  2用户
@property (nonatomic,copy)NSString *type;
//手机号或商户名
@property (nonatomic,copy)NSString *targetPersonName ;

@end

@interface MyrecommendTableViewCell : BaseTableViewCell

@property (weak, nonatomic) IBOutlet UIView *itemView;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneLabel;
@property (weak, nonatomic) IBOutlet UILabel *remmendLabel;

@property (nonatomic, strong)InnitationModel *dataModel;

@end
