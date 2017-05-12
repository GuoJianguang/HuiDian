//
//  BankCardTableViewCell.h
//  HuiDian
//
//  Created by mac on 2017/5/12.
//  Copyright © 2017年 Huidian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BankCardTableViewCell : BaseTableViewCell

@property (weak, nonatomic) IBOutlet UITextField *bankCardNu;
@property (weak, nonatomic) IBOutlet UITextField *bankLabel;
- (IBAction)banLabelBtn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITextField *provincesTF;
- (IBAction)provincesBtn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *idCardNUTF;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *kaihuhangTF;
@property (weak, nonatomic) IBOutlet UITextField *kaihuhangNumdTF;
@property (weak, nonatomic) IBOutlet UITextField *wangdianTF;
- (IBAction)kaihuhangBtn:(UIButton *)sender;
- (IBAction)kaihuwangdianBtn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITextField *inputKaihuhangTF;

@property (weak, nonatomic) IBOutlet UIButton *bingdingBtn;

- (IBAction)bingdingBtn:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIView *itemView1;
@property (weak, nonatomic) IBOutlet UIView *itemView2;
@property (weak, nonatomic) IBOutlet UIView *itemView3;

@property (weak, nonatomic) IBOutlet UIView *manualInputView;
@property (nonatomic, assign)BOOL isEdit;
#pragma mark - 已绑定时候的数据
@property (nonatomic, strong)NSDictionary *bankcardinfo;
//是否已经绑定银行卡
@property (nonatomic, assign)BOOL isYetBingdingCard;
@property (nonatomic, strong)NSDictionary *realnameAuDic;

@property (weak, nonatomic) IBOutlet UIButton *selcetInPutBtn;
- (IBAction)selcetInPutBtn:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIButton *selectKahuhangBtn;

- (IBAction)selectKahuhangBtn:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UILabel *alerLabel;


@property (nonatomic, assign)BOOL isMaual;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *item2Height;

@end
