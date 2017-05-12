//
//  EditShippingAddressViewController.h
//  HuiDian
//
//  Created by mac on 2017/5/12.
//  Copyright © 2017年 Huidian. All rights reserved.
//

#import "BaseViewController.h"
#import "ShippingALTableViewCell.h"


@interface EditShippingAddressViewController : BaseViewController


@property (weak, nonatomic) IBOutlet UITextField *shippingPersonTF;

@property (weak, nonatomic) IBOutlet UITextField *provincesTF;

@property (weak, nonatomic) IBOutlet UITextField *detailAddressTF;

@property (weak, nonatomic) IBOutlet UITextField *ZipCodeTF;

@property (weak, nonatomic) IBOutlet UITextField *phoneTF;


@property (nonatomic, strong)ShippingAddressModel *addressModel;


@property (nonatomic, assign)BOOL isAddAddress;

- (IBAction)sure_btn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;

- (IBAction)selectProBtn:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *label4;
@property (weak, nonatomic) IBOutlet UILabel *label5;
@property (weak, nonatomic) IBOutlet UIView *itmeView;

@end