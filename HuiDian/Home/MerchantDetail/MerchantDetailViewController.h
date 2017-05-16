//
//  MerchantDetailViewController.h
//  HuiDian
//
//  Created by mac on 2017/5/16.
//  Copyright © 2017年 Huidian. All rights reserved.
//

#import "BaseViewController.h"

@interface MerchantDetailViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong)NSString *merchantCode;

@end
