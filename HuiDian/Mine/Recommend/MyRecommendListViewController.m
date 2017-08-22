//
//  MyRecommendListViewController.m
//  HuiDian
//
//  Created by mac on 2017/5/15.
//  Copyright © 2017年 Huidian. All rights reserved.
//

#import "MyRecommendListViewController.h"
#import "MyrecommendTableViewCell.h"
#import "MyRecommendDetailListViewController.h"

@interface MyRecommendListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)NSMutableArray *dataSouceArray;
@property (nonatomic, assign)NSInteger page;//页数

@end

@implementation MyRecommendListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.naviBar.lineVIew.hidden = YES;
    self.naviBar.title = @"我的推荐";
    self.itemView.backgroundColor = MacoYellowColor;
    self.recommendLabel.textColor = MacoTitleColor;
    self.isWhiteBg = YES;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page = 1;
        [self invitationRequest:YES andTargetMchCode:nil];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self invitationRequest:NO andTargetMchCode:nil];
    }];
    [self.tableView.mj_header beginRefreshing];
    [self.tableView noDataSouce];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSMutableArray *)dataSouceArray
{
    if (!_dataSouceArray) {
        _dataSouceArray = [NSMutableArray array];
    }
    return _dataSouceArray;
}
//我的邀请详情数据
- (void)invitationRequest:(BOOL)isHeader andTargetMchCode:(NSString *)targetMchCode
{
    NSDictionary *parms = @{@"pageNo":@(self.page),
                            @"pageSize":MacoRequestPageCount,
                            @"token":[HDUserInfo shareUserInfos].token};
    [HttpClient POST:@"user/recommendProfit/get" parameters:parms success:^(NSURLSessionDataTask *operation, id jsonObject) {
        if (IsRequestTrue) {
            if (isHeader) {
                [self.dataSouceArray removeAllObjects];
                [self.tableView.mj_header endRefreshing];
            }
            [self.tableView.mj_footer endRefreshing];
            NSArray *array = jsonObject[@"data"][@"data"];
            if (array.count > 0) {
                self.page ++;
            }
            for (NSDictionary *dic in array) {
                [self.dataSouceArray addObject:[InnitationModel modelWithDic:dic]];
            }
            //判断数据源有无数据
            [self.tableView judgeIsHaveDataSouce:self.dataSouceArray];
            
            [self.tableView reloadData];
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        if (isHeader) {
            [self.tableView.mj_header endRefreshing];
        }else{
            [self.tableView.mj_footer endRefreshing];
        }
        [self.tableView showNoDataSouceNoNetworkConnection];
    }];
}

#pragma mark - UITableview


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSouceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyrecommendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[MyrecommendTableViewCell indentify]];
    if (!cell) {
        cell = [MyrecommendTableViewCell newCell];
    }
    cell.dataModel = self.dataSouceArray[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (TWitdh-12)*(190/750.);
}

- (IBAction)checkRecommendBtn:(UIButton *)sender {
    MyRecommendDetailListViewController *listVC = [[MyRecommendDetailListViewController alloc]init];
    [self.navigationController pushViewController:listVC animated:YES];
}
@end
