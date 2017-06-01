//
//  FlagshipCollectionViewCell.m
//  TTXForConsumer
//
//  Created by Guo on 2017/2/23.
//  Copyright © 2017年 ttx. All rights reserved.
//

#import "FlagshipCollectionViewCell.h"

@implementation FlagShipDataModel

+ (id)modelWithDic:(NSDictionary *)dic
{
    FlagShipDataModel *model = [[FlagShipDataModel alloc]init];
    model.aviableBalance = NullToSpace(dic[@"aviableBalance"]);
    model.mchCode = NullToSpace(dic[@"mchCode"]);
    model.mchName = NullToSpace(dic[@"mchName"]);
    model.pic = NullToSpace(dic[@"pic"]);
    return model;
}

@end


@implementation FlagshipCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.shipName.textColor = MacoTitleColor;
    self.shipImageView.layer.cornerRadius = 3;
    self.shipImageView.layer.masksToBounds = YES;
}

- (void)setDataModel:(FlagShipDataModel *)dataModel
{
    _dataModel = dataModel;
    [self.shipImageView sd_setImageWithURL:[NSURL URLWithString:_dataModel.pic] placeholderImage:LoadingErrorDefaultImageSquare];
    self.shipName.text = _dataModel.mchName;
}


@end
