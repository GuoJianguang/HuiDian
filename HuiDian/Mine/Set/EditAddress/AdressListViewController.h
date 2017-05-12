//
//  AdressListViewController.h
//  HuiDian
//
//  Created by mac on 2017/5/12.
//  Copyright © 2017年 Huidian. All rights reserved.
//

#import "BaseViewController.h"

@interface AdressListViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
//地址的列表请求
- (void)addressRequest;
@end
