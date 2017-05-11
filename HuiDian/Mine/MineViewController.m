//
//  MineViewController.m
//  HuiDian
//
//  Created by mac on 2017/5/9.
//  Copyright © 2017年 Huidian. All rights reserved.
//

#import "MineViewController.h"
#import "MineTableViewCell.h"

@interface MineViewController ()<BasenavigationDelegate,UITableViewDelegate,UITableViewDataSource>

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.naviBar.hiddenBackBtn = YES;
    self.naviBar.title = @"个人中心";
    self.naviBar.hiddenDetailBtn = NO;
    self.naviBar.hiddenDetailBtn = NO;
    self.naviBar.detailImage = [UIImage imageNamed:@"icon_scan"];
    self.naviBar.delegate = self;
    self.bgImageView.hidden = YES;
    self.withDrawBtn.layer.cornerRadius = 15;
    self.withDrawBtn.layer.borderWidth = 1;
    self.withDrawBtn.layer.masksToBounds = YES;
    self.withDrawBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    self.withDrawBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    self.yuELabel.adjustsFontSizeToFitWidth = YES;
    
    self.yuELabel.text = [NSString stringWithFormat:@"%.2f",[[HDUserInfo shareUserInfos].aviableBalance doubleValue]];
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:[HDUserInfo shareUserInfos].avatar] placeholderImage:LoadingErrorDefaultHearder completed:NULL];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(logout:) name:LogOutNSNotification object:nil];


}


#pragma mark - 退出登录的操作
- (void)logout:(NSNotification *)notification
{
    self.tabBarController.selectedIndex = 0;
}

#pragma mark - 扫一扫
- (void)detailBtnClick
{
    
}

#pragma mark - UITableView

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return THeight - 49 - 64;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[MineTableViewCell indentify]];
    if (!cell) {
        cell = [MineTableViewCell newCell];
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
