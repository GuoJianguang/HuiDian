//
//  MerchantTableViewCell.m
//  TTXForConsumer
//
//  Created by ttx on 16/6/20.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import "MerchantTableViewCell.h"

@implementation MerchantTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.contentView.backgroundColor = [UIColor clearColor];
    self.reLabel.layer.cornerRadius = 3;
    self.reLabel.layer.masksToBounds = YES;
    self.reLabel.backgroundColor = MacoColor;
    self.name_label.textColor = [UIColor colorFromHexString:@"#3c3c3c"];
    self.kimter_label.textColor = MacoDetailColor;
    self.detail_label.textColor = MacoDetailColor;
    self.bussessImage.contentMode = UIViewContentModeScaleAspectFill;
    self.bussessImage.layer.masksToBounds = YES;
    
    self.bussessImage.layer.cornerRadius = 10;
    self.bussessImage.layer.masksToBounds = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDataModel:(MerchantDataModel *)dataModel
{
    _dataModel = dataModel;
    [self.bussessImage sd_setImageWithURL:[NSURL URLWithString:_dataModel.pic] placeholderImage:LoadingErrorDefaultImageSquare options:SDWebImageRefreshCached];
    self.name_label.text = _dataModel.name;
    self.detail_label.text = _dataModel.desc;
    if ([_dataModel.desc isEqualToString:@""]) {
        self.detail_label.text = @"暂无商家介绍";
    }
    if ([_dataModel.recommend isEqualToString:@"1"]) {
        self.reLabel.hidden = NO;
    }else{
        self.reLabel.hidden = YES;
    }
    self.kimter_label.text = [NSString stringWithFormat:@"%.2f km",[self Calculationofdistance:_dataModel]];
    if ([_dataModel.distance isEqualToString:@""]) {
        self.kmiterImage.hidden = YES;
    }
    self.kimter_label.text = _dataModel.distance;
    
//    if ([_dataModel.highQuality isEqualToString:@"1"] && !_dataModel.isSearchResult) {
////        self.sort_label.hidden = NO;
//        self.kimter_label.hidden = YES;
//        self.kmiterImage.hidden = YES;
//    }else{
//        if ([_dataModel.trade isEqualToString:@""]) {
////            self.sort_label.hidden = YES;
//        }
////        self.sort_label.text = _dataModel.trade;
//    }
}
- (double)Calculationofdistance:(MerchantDataModel *)model
{
    double startlattion = [model.latitude floatValue];
    double startlongtion = [model.longitude floatValue];
    
    CLLocation *orig=[[CLLocation alloc] initWithLatitude:startlattion  longitude:startlongtion];
    
    CLLocation* dist=[[CLLocation alloc] initWithLatitude:[HDUserInfo shareUserInfos].locationCoordinate.latitude longitude:[HDUserInfo shareUserInfos].locationCoordinate.longitude];
    
    CLLocationDistance kilometers=[orig distanceFromLocation:dist]/1000;
    return kilometers;
}

@end
