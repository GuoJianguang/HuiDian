//
//  WalletView1.h
//  HuiDian
//
//  Created by mac on 2017/5/9.
//  Copyright © 2017年 Huidian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WalletView1 : UIView

@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (void)reload;
@end
