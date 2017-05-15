//
//  MyrecommendTableViewCell.m
//  HuiDian
//
//  Created by mac on 2017/5/15.
//  Copyright © 2017年 Huidian. All rights reserved.
//

#import "MyrecommendTableViewCell.h"



@implementation InnitationModel

+ (id)modelWithDic:(NSDictionary *)dic
{
    InnitationModel *model = [[InnitationModel alloc]init];
    model.tranTime = NullToSpace(dic[@"tranTime"]);
    model.tranAmount = NullToNumber(dic[@"tranAmount"]);
    model.type = NullToNumber(dic[@"type"]);
    model.targetPersonName = NullToSpace(dic[@"targetPersonName"]);
    
    return model;
}

@end
@implementation MyrecommendTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.itemView.layer.cornerRadius = 10;
    self.itemView.layer.masksToBounds= YES;
    self.moneLabel.textColor = self.remmendLabel.textColor = MacoYellowColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDataModel:(InnitationModel *)dataModel
{
    _dataModel = dataModel;
    self.timeLabel.text = _dataModel.tranTime;
    self.moneLabel.text = [NSString stringWithFormat:@"+¥%.2f",[_dataModel.tranAmount doubleValue]];
    switch ([_dataModel.type integerValue]) {
        case 1:
            self.remmendLabel.text = _dataModel.targetPersonName;;

            break;
        case 2:
            self.remmendLabel.text = [NSString stringWithFormat:@"%@消费者",_dataModel.targetPersonName];

            break;
            
        default:
            break;
    }
}

@end
