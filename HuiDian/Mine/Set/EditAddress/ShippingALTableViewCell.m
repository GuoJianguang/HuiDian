//
//  ShippingALTableViewCell.m
//  HuiDian
//
//  Created by mac on 2017/5/12.
//  Copyright © 2017年 Huidian. All rights reserved.
//

#import "ShippingALTableViewCell.h"
#import "AdressListViewController.h"

@implementation ShippingAddressModel

+ (id)modelWithDic:(NSDictionary *)dic
{
    ShippingAddressModel *model = [[ShippingAddressModel alloc]init];
    model.addressId = NullToSpace(dic[@"id"]);
    model.addressDetail = NullToSpace(dic[@"addressDetail"]);
    model.name = NullToSpace(dic[@"name"]);
    model.phone = NullToSpace(dic[@"phone"]);
    model.address = NullToSpace(dic[@"address"]);
    model.province = NullToSpace(dic[@"province"]);
    model.defaultFlag = NullToSpace(dic[@"defaultFlag"]);
    model.zipCode = NullToSpace(dic[@"zipCode"]);
    model.city = NullToSpace(dic[@"city"]);
    model.zone = NullToSpace(dic[@"zone"]);
    model.createTime = NullToSpace(dic[@"createTime"]);
    model.modifyTime = NullToSpace(dic[@"modifyTime"]);
    
    return model;
}

@end

@implementation ShippingALTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.phoneLabel.adjustsFontSizeToFitWidth = self.shippingPerson.adjustsFontSizeToFitWidth = YES;
    [self.select_btn setImage:[UIImage imageNamed:@"icon_pickon"] forState:UIControlStateSelected];
    [self.select_btn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    self.item_view.layer.masksToBounds = YES;
    self.item_view.layer.cornerRadius = 10;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)select_btn:(UIButton *)sender
{
    if (sender.selected) {
        return;
    }
    UIAlertController *alertcontroller = [UIAlertController alertControllerWithTitle:@"提示" message:@"您确认要修改默认收货地址吗？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"点错了" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
    }];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSDictionary *parms = @{@"id":self.dataModel.addressId,
                                @"defaultFlag":@"1",
                                @"token":[HDUserInfo shareUserInfos].token,
                                @"userId":[HDUserInfo shareUserInfos].userid};
        [HttpClient POST:@"user/userInfo/address/update" parameters:parms success:^(NSURLSessionDataTask *operation, id jsonObject) {
            if (IsRequestTrue) {
                [((AdressListViewController *)self.viewController) addressRequest];
            }
            
        } failure:^(NSURLSessionDataTask *operation, NSError *error) {
            [[JAlertViewHelper shareAlterHelper]showTint:@"网路请求失败，请重试" duration:2.];
        }];
        
    }];
    [alertcontroller addAction:cancelAction];
    [alertcontroller addAction:sureAction];
    
    [self.viewController presentViewController:alertcontroller animated:YES completion:NULL];
}

- (void)setDataModel:(ShippingAddressModel *)dataModel
{
    _dataModel = dataModel;
    self.shippingPerson.text = _dataModel.name;
    self.shippingAddress.text = _dataModel.addressDetail;
    self.phoneLabel.text = _dataModel.phone;
    if ([_dataModel.defaultFlag isEqualToString:@"1"]) {
        self.select_btn.selected = YES;
    }else{
        self.select_btn.selected = NO;
    }
}


@end
