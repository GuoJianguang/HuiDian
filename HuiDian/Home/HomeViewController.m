//
//  HomeViewController.m
//  HuiDian
//
//  Created by mac on 2017/5/15.
//  Copyright © 2017年 Huidian. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeBannerTableViewCell.h"
#import "LocationManager.h"
#import "HomeIndustryTableViewCell.h"
#import "MerchantDataModel.h"
#import "MerchantTableViewCell.h"
#import "HomeSortTableViewCell.h"

@interface HomeViewController ()
@property (nonatomic, assign)BOOL isAlreadyRefrefsh;
@property (nonatomic, strong)NSMutableArray *dataSouceArray;;
@property (nonatomic, assign)NSInteger page;



//当前城市
@property (nonatomic, strong)NSString *currentCity;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.backgroundColor = [UIColor clearColor];
    __weak HomeViewController *weak_self = self;
    self.sortWay = @"1";
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weak_self.isAlreadyRefrefsh = YES;
        weak_self.page = 1;
        [self detailReqest:YES andCity:self.currentCity andsortingWay:self.sortWay];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self detailReqest:NO andCity:self.currentCity andsortingWay:self.sortWay];
    }];
    [self.tableView noDataSouce];
    
    [self loadDataUseLocation];

}

- (NSMutableArray *)dataSouceArray
{
    if (!_dataSouceArray) {
        _dataSouceArray = [NSMutableArray array];
    }
    return _dataSouceArray;
}
#pragma mark -使用当前位置加载数据
- (BOOL)myContainsString:(NSString*)string and:(NSString *)otherString {
    NSRange range = [string rangeOfString:otherString];
    return range.length != 0;
}

-(void) loadDataUseLocation {
    [HDUserInfo shareUserInfos].locationCity = @"成都";
    NSString *currentCity = [LocationManager sharedLocationManager].currentCity;
    __weak typeof(HomeViewController *) weak_self = self;
    
    if (!currentCity) {
        [[LocationManager sharedLocationManager] startLocationWithGDManager];
        [LocationManager sharedLocationManager].finishLocation = ^(NSString *city,NSString *areaName,NSError *error ,BOOL success){
            if (city) {
                if ([self myContainsString:city and:@"市"]) {
                    city =  [city stringByReplacingOccurrencesOfString:@"市" withString:@""];
                }
                [HDUserInfo shareUserInfos].locationCity = city;
//                [weak_self.cityBtn setTitle:city forState:UIControlStateNormal];
                self.currentCity = city;
//                self.locationCity = city;
                
                [self.tableView.mj_header beginRefreshing];
            }else{
                self.currentCity = @"成都";
                [HDUserInfo shareUserInfos].locationCity = @"成都";
//                [weak_self.cityBtn setTitle:@"成都" forState:UIControlStateNormal];
                [self.tableView.mj_header beginRefreshing];
            }
        };
    }else {
        self.currentCity = @"成都";
        [HDUserInfo shareUserInfos].locationCity = @"成都";
//        [weak_self.cityBtn setTitle:@"成都" forState:UIControlStateNormal];
        [self.tableView.mj_header beginRefreshing];
    }
}


#pragma mark - UITableView
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.row == 0) {
        HomeBannerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[HomeBannerTableViewCell indentify]];
        if (!cell) {
            cell = [HomeBannerTableViewCell newCell];
        }
        cell.isAlreadyRefrefsh = self.isAlreadyRefrefsh;
        return cell;
    }else if (indexPath.row == 1){
        HomeIndustryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[HomeIndustryTableViewCell indentify]];
        if (!cell) {
            cell = [HomeIndustryTableViewCell newCell];
        }
        cell.isAlreadyRefrefsh = self.isAlreadyRefrefsh;
        return cell;
    }else if (indexPath.row == 2){
        HomeSortTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[HomeSortTableViewCell indentify]];
        if (!cell) {
            cell = [HomeSortTableViewCell newCell];
        }
        cell.sortWay = self.sortWay;
        return cell;
    }else{
        MerchantTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[MerchantTableViewCell indentify]];
        if (!cell) {
            cell = [MerchantTableViewCell newCell];
        }
        cell.dataModel = self.dataSouceArray[indexPath.row - 3];
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return TWitdh*(35/75.);
    }else if (indexPath.row == 1){
        CGFloat intervalX = 50.0;/**<横向间隔*/
        CGFloat intervalY = 15.0;/**<纵向间隔*/
        NSInteger columnNum = 4;/**<九宫格列数*/
        CGFloat widthAndHeightRatio = 2.0/3.0;/**<宽高比*/
        CGFloat buttonWidth = (TWitdh - 40 - intervalX * (columnNum - 1))/(CGFloat)columnNum;/**<button的宽度*/
        CGFloat buttonHeight = buttonWidth/widthAndHeightRatio;/**<button的高度*/
        return buttonHeight * 2 + intervalY*2 + 18;
    }else if (indexPath.row == 2){

        return TWitdh*(70/750.);
    }
    return TWitdh*(220/750.);
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSouceArray.count + 3;
    //    return 3;
}
#pragma mark - 获取商家列表
- (void)detailReqest:(BOOL)isHeader andCity:(NSString *)city andsortingWay:(NSString *)sortingWay
{
    NSString *searchcity = [self.currentCity substringToIndex:2];

    NSDictionary *parms = @{@"pageNo":@(self.page),
                            @"pageSize":MacoRequestPageCount,
                            @"trade":@"",
                            @"mchCity":searchcity,
                            @"keyword":@"",
                            @"longitude":@([HDUserInfo shareUserInfos].locationCoordinate.longitude),
                            @"latitude":@([HDUserInfo shareUserInfos].locationCoordinate.latitude),
                            @"seqId":NullToNumber(sortingWay)};
    
    [HttpClient GET:@"mch/highQuality" parameters:parms success:^(NSURLSessionDataTask *operation, id jsonObject) {
        self.tableView.scrollEnabled = YES;
        if (IsRequestTrue) {
            if (isHeader) {
                [self.dataSouceArray removeAllObjects];
                [self.tableView.mj_header endRefreshing];
            }else{
                [self.tableView.mj_footer endRefreshing];
            }
            NSArray *array = jsonObject[@"data"][@"data"];
            if (array.count > 0) {
                self.page ++;
            }
            for (NSDictionary *dic in array) {
                [self.dataSouceArray addObject:[MerchantDataModel modelWithDic:dic]];
            }
            [self.tableView reloadData];
        }
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        self.isAlreadyRefrefsh = NO;
        self.tableView.scrollEnabled = NO;
        if (isHeader) {
            [self.tableView.mj_header endRefreshing];
        }else{
            [self.tableView.mj_footer endRefreshing];
        }
        [self.tableView showRereshBtnwithALerString:@"网络连接不好"];
    }];
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
