//
//  MineViewController.h
//  HuiDian
//
//  Created by mac on 2017/5/9.
//  Copyright © 2017年 Huidian. All rights reserved.
//

#import "BaseViewController.h"

@interface MineViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *yuELabel;

@property (weak, nonatomic) IBOutlet UIButton *withDrawBtn;
- (IBAction)withDrawBtn:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
