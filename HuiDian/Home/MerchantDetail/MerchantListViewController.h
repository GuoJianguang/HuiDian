//
//  MerchantListViewController.h
//  HuiDian
//
//  Created by mac on 2017/5/16.
//  Copyright © 2017年 Huidian. All rights reserved.
//

#import "BaseViewController.h"

@interface MerchantListViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet SortButtonSwitchView *sortView;

//当前城市
@property (nonatomic, strong)NSString *currentCity;

//当前选择行业
@property (nonatomic, strong)NSString *currentIndustry;

//关键字
@property (nonatomic, strong)NSString *keyWord;
@end
