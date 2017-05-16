//
//  HomeViewController.h
//  HuiDian
//
//  Created by mac on 2017/5/15.
//  Copyright © 2017年 Huidian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, copy)NSString *sortWay;


@property (weak, nonatomic) IBOutlet UIButton *cityBtn;
- (IBAction)cityBtn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIView *searchView;
@property (weak, nonatomic) IBOutlet UITextField *searchTF;

@property (weak, nonatomic) IBOutlet UIButton *searchBtn;
- (IBAction)searchBtn:(UIButton *)sender;

@end
