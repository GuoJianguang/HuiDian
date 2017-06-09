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
#import "MerchantDetailViewController.h"
#import "CityListViewController.h"
#import "MerchantSearchViewController.h"
#import "MerchantSearchResultViewController.h"
#import "MineViewController.h"
#import "MerchantListViewController.h"
#import "HomeActivityTableViewcell.h"
#import "FlagshipCollectionViewCell.h"

@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,CityListViewDelegate,MerchantSearchViewDelegate,UITabBarControllerDelegate>
@property (nonatomic, assign)BOOL isAlreadyRefrefsh;
@property (nonatomic, strong)NSMutableArray *dataSouceArray;

@property(nonatomic,strong)NSMutableArray *activityArray;

@property (nonatomic, strong)NSMutableArray *popularArray;
@property (nonatomic, assign)NSInteger page;

@property (nonatomic, strong)NSString *locationCity;

@property (nonatomic, strong)MerchantSearchViewController *searchVC;

//当前城市
@property (nonatomic, strong)NSString *currentCity;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.backgroundColor = [UIColor clearColor];
    __weak HomeViewController *weak_self = self;
    self.tabBarController.delegate = self;
    self.searchView.layer.cornerRadius = 18;
    self.searchView.layer.masksToBounds = YES;
    self.searchTF.delegate = self;
    self.sortWay = @"2";
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weak_self.isAlreadyRefrefsh = YES;
        weak_self.page = 1;
        
        [weak_self getActivityRequest];
//        [self detailReqest:YES andCity:self.currentCity andsortingWay:self.sortWay];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self detailReqest:NO andCity:self.currentCity andsortingWay:self.sortWay];
    }];
    [self.tableView addNoDatasouceWithCallback:^{
        [self.tableView.mj_header beginRefreshing];
    } andAlertSting:@"网络连接失败" andErrorImage:@"pic_4" andRefreshBtnHiden:NO];
    self.locationCity = @"成都";
    self.currentCity = @"成都";

    [self loadDataUseLocation];

    UIColor *itemSelectTintColor = MacoTitleColor;
    [[UITabBar appearance] setBarTintColor:MacoYellowColor];
    [[UITabBarItem appearance] setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      itemSelectTintColor,
      NSForegroundColorAttributeName,
      [UIFont boldSystemFontOfSize:15],
      NSFontAttributeName
      ,nil] forState:UIControlStateSelected];
    self.tabBarController.tabBar.tintColor = itemSelectTintColor;
    [[UITabBar appearance] setShadowImage:[[UIImage alloc]init]];
    [[UITabBar appearance] setShadowImage:[UIImage imageWithColor:itemSelectTintColor frame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 1)]];
    
}
#pragma mark -懒加载
- (MerchantSearchViewController *)searchVC
{
    if (!_searchVC) {
        _searchVC = [[MerchantSearchViewController alloc]init];
        _searchVC.delegate = self;
        _searchVC.view.frame = CGRectMake(0, 0, TWitdh, THeight);
    }
    return _searchVC;
}

- (NSMutableArray *)dataSouceArray
{
    if (!_dataSouceArray) {
        _dataSouceArray = [NSMutableArray array];
    }
    return _dataSouceArray;
}

- (NSMutableArray *)activityArray
{
    if (!_activityArray) {
        _activityArray = [NSMutableArray array];
    }
    return _activityArray;
}

- (NSMutableArray *)popularArray
{
    if (!_popularArray) {
        _popularArray = [NSMutableArray array];
    }
    return _popularArray;
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
                [weak_self.cityBtn setTitle:city forState:UIControlStateNormal];
                self.currentCity = city;
                self.locationCity = city;
                
                [self.tableView.mj_header beginRefreshing];
            }else{
                self.currentCity = @"成都";
                [HDUserInfo shareUserInfos].locationCity = @"成都";
                [weak_self.cityBtn setTitle:@"成都" forState:UIControlStateNormal];
                [self.tableView.mj_header beginRefreshing];
            }
        };
    }else {
        self.currentCity = @"成都";
        [HDUserInfo shareUserInfos].locationCity = @"成都";
        [weak_self.cityBtn setTitle:@"成都" forState:UIControlStateNormal];
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
        HomeActivityTableViewcell *cell = [tableView dequeueReusableCellWithIdentifier:[HomeActivityTableViewcell indentify]];
        if (!cell) {
            cell = [HomeActivityTableViewcell newCell];
        }
        cell.activityAarray = self.activityArray;
        cell.flagShipArray = self.popularArray;
        cell.merchantArray = self.dataSouceArray;
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
        return TWitdh*(382/750.);
    }else if (indexPath.row == 1){
        CGFloat intervalX = 50.0;/**<横向间隔*/
        CGFloat intervalY = 15.0;/**<纵向间隔*/
        NSInteger columnNum = 4;/**<九宫格列数*/
        CGFloat widthAndHeightRatio = 2.0/3.0;/**<宽高比*/
        CGFloat buttonWidth = (TWitdh - 40 - intervalX * (columnNum - 1))/(CGFloat)columnNum;/**<button的宽度*/
        CGFloat buttonHeight = buttonWidth/widthAndHeightRatio;/**<button的高度*/
        return buttonHeight * 2 + intervalY*2 + 18;
    }else if (indexPath.row == 2){

        return TWitdh*(590/750.);
    }
    return TWitdh*(220/750.);
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return self.dataSouceArray.count + 3;
    //    return 3;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MerchantDetailViewController *merchantDVC = [[MerchantDetailViewController alloc]init];
    MerchantDataModel *model = self.dataSouceArray[indexPath.row -3];
    merchantDVC.merchantCode = model.code;
    [self.navigationController pushViewController:merchantDVC animated:YES];
}
#pragma mark - 活动接口

- (void)getActivityRequest
{
    [HttpClient POST:@"activity/index/list" parameters:nil success:^(NSURLSessionDataTask *operation, id jsonObject) {
        if (IsRequestTrue) {
            if ([jsonObject[@"data"] isKindOfClass:[NSArray class]]) {
                NSArray *array = jsonObject[@"data"];
                [self.activityArray removeAllObjects];
                for (NSDictionary *dic in array) {
                    [self.activityArray addObject:[ActivityModel modelWithDic:dic]];
                }
                
            }
            [self getPopularMRequest];
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
    
}

#pragma mark - 人气商家
- (void)getPopularMRequest{
    NSDictionary *parms = @{@"city":[HDUserInfo shareUserInfos].locationCity};
    [HttpClient POST:@"mch/hotMchs" parameters:parms success:^(NSURLSessionDataTask *operation, id jsonObject) {
        if (IsRequestTrue) {
            if ([jsonObject[@"data"] isKindOfClass:[NSArray class]]) {
                NSArray *array = jsonObject[@"data"];
                [self.popularArray removeAllObjects];
                for (NSDictionary *dic in array) {
                    [self.popularArray addObject:[FlagShipDataModel modelWithDic:dic]];
                }
            }
            
            [self detailReqest:YES andCity:self.currentCity andsortingWay:self.sortWay];
        }
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
    
}

#pragma mark - 获取商家列表
- (void)detailReqest:(BOOL)isHeader andCity:(NSString *)city andsortingWay:(NSString *)sortingWay
{
    NSString *searchcity = [NullToSpace(self.currentCity) substringToIndex:2];

    NSDictionary *parms = @{@"pageNo":@(self.page),
                            @"pageSize":MacoRequestPageCount,
                            @"trade":@"",
                            @"mchCity":NullToSpace(searchcity),
                            @"keyword":@"",
                            @"longitude":@([HDUserInfo shareUserInfos].locationCoordinate.longitude),
                            @"latitude":@([HDUserInfo shareUserInfos].locationCoordinate.latitude),
                            @"seqId":NullToNumber(sortingWay)};
    
    [HttpClient GET:@"mch/search" parameters:parms success:^(NSURLSessionDataTask *operation, id jsonObject) {
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
//            [self.tableView judgeIsHaveDataSouce:self.dataSouceArray andBannerArray:@[@"1"]];
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


#pragma mark - 选取定位

- (IBAction)cityBtn:(UIButton *)sender
{
    CityListViewController *cityListView = [[CityListViewController alloc]init];
    cityListView.delegate = self;
    //热门城市列表
    cityListView.arrayHotCity = [NSMutableArray arrayWithObjects:@"成都",@"重庆",@"昆明",@"德阳",@"资阳", nil];
    //历史选择城市列表
    NSMutableArray *historicalCity = [[NSUserDefaults standardUserDefaults]objectForKey:CommonlyUsedCity];
    cityListView.arrayHistoricalCity = historicalCity;
    //定位城市列表
    cityListView.arrayLocatingCity   = [NSMutableArray arrayWithObjects:self.locationCity,nil];
    
    [self presentViewController:cityListView animated:YES completion:nil];
}

- (void)didClickedWithCityName:(NSString*)cityName
{
    if ([[NSUserDefaults standardUserDefaults]objectForKey:CommonlyUsedCity]) {
        NSArray *historicalCity = [[NSUserDefaults standardUserDefaults]objectForKey:CommonlyUsedCity];
        NSMutableArray *array = [NSMutableArray arrayWithArray:historicalCity];
        
        if (![array containsObject:cityName]) {
            [array insertObject:cityName atIndex:0];
            if (array.count > 3) {
                [array removeLastObject];
            }
        }else{
            [array exchangeObjectAtIndex:[array indexOfObject:cityName] withObjectAtIndex:0];
        }
        [[NSUserDefaults standardUserDefaults]setObject:array forKey:CommonlyUsedCity];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }else{
        NSMutableArray *array = [NSMutableArray arrayWithArray:@[cityName]];
        [[NSUserDefaults standardUserDefaults]setObject:array forKey:CommonlyUsedCity];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
    self.searchVC.selectCityname = cityName;
    [HDUserInfo shareUserInfos].locationCity = cityName;
    self.currentCity = cityName;
    [self.cityBtn setTitle:cityName forState:UIControlStateNormal];
    [self.tableView.mj_header beginRefreshing];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITabBarDelegate

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    if([viewController isMemberOfClass:[MineViewController class]]){
        if (![HDUserInfo shareUserInfos].currentLogined) {
            //判断是否先登录
            UINavigationController *navc = [LoginViewController controller];
            [self presentViewController:navc animated:YES completion:NULL];
            return NO;
        }
    }
    return YES;
}

- (IBAction)searchBtn:(UIButton *)sender {
    
    self.searchVC.isSerach = YES;
    //    [self.navigationController pushViewController:self.searchVC animated:YES];
    [self.navigationController.view addSubview:self.searchVC.view];
}

#pragma mark - UITextFiledDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    self.searchVC.isSerach = YES;
    //    [self.navigationController pushViewController:self.searchVC animated:YES];
    self.searchVC.selectCityname = self.currentCity;
    [self.navigationController.view addSubview:self.searchVC.view];
    return NO;
}

#pragma mark = MerchantSearchViewDelegate

- (void)cancelSearch
{
    [self.searchVC.view removeFromSuperview];
}

- (void)sureSearch:(NSString *)keyWord city:(NSString *)cityName
{
    [self.searchVC.view removeFromSuperview];
//    mer *resultVC = [[MerchantSearchResultViewController alloc]init];
//    resultVC.currentIndustry = @"";
//    resultVC.keyWord = keyWord;
//    resultVC.currentCity = cityName;
//    [self.navigationController pushViewController:resultVC animated:YES];
    
    MerchantListViewController *resultVC = [[MerchantListViewController alloc]init];
    resultVC.keyWord = keyWord;
    resultVC.currentIndustry = @"";
    resultVC.currentCity = [HDUserInfo shareUserInfos].locationCity;
    [self.navigationController pushViewController:resultVC animated:YES];
}
@end
