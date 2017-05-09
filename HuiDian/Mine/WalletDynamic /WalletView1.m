//
//  WalletView1.m
//  HuiDian
//
//  Created by mac on 2017/5/9.
//  Copyright © 2017年 Huidian. All rights reserved.
//

#import "WalletView1.h"
#import "WalletDynamicOtherTableViewCell.h"

@interface WalletView1()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, assign)NSInteger page;
@property (nonatomic, strong)NSMutableArray *dataSouceArray;

@end
@implementation WalletView1

- (void)reload
{
    [self.tableView.mj_header beginRefreshing];
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self = [[NSBundle mainBundle]loadNibNamed:@"WalletView1" owner:nil options:nil][0];
        self.tableView.backgroundColor  = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        __weak WalletView1 *weak_self = self;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            weak_self.page = 1;
//            [weak_self getxiaofeijiluRequest:YES];
        }];
        self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//            [weak_self getxiaofeijiluRequest:NO];
        }];
        [self.tableView noDataSouce];
        [self reload];
    }
    return self;
}
- (NSMutableArray *)dataSouceArray
{
    if (!_dataSouceArray) {
        _dataSouceArray = [NSMutableArray array];
    }
    return _dataSouceArray;
}

#pragma mark - TableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
    return  self.dataSouceArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return TWitdh*(190/750.);
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WalletDynamicOtherTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[WalletDynamicOtherTableViewCell indentify]];
    if (!cell) {
        cell = [WalletDynamicOtherTableViewCell newCell];
    }
//    cell.xiaofeijiluModel = self.dataSouceArray[indexPath.row];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}


@end
