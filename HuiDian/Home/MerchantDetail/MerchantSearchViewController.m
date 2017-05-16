//
//  MerchantSearchViewController.m
//  TTXForConsumer
//
//  Created by ttx on 16/7/1.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import "MerchantSearchViewController.h"
#import "LocationManager.h"
#import "CityListViewController.h"
#import "MerchantSearchResultViewController.h"



@interface MerchantSearchViewController ()<CityListViewDelegate,UITextFieldDelegate>

@property (nonatomic, strong)NSMutableArray *sortDataSouceArray;


@end

@implementation MerchantSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.naviBar.hidden = YES;
    // Do any additional setup after loading the view from its nib.
    self.searchView.layer.cornerRadius = 15.;
    self.searchView.layer.masksToBounds = YES;
    self.searchView.layer.borderWidth = 1;
    self.searchView.layer.borderColor = MacolayerColor.CGColor;
    self.selectCityLabel.textColor = MacoColor;
    self.isWhiteBg = YES;
    [self.view sendSubviewToBack:self.bgImageView];
    
    self.cityLabel.text = [NSString stringWithFormat:@"当前城市：%@",[HDUserInfo shareUserInfos].locationCity];
    self.serchTF.delegate = self;
    self.selectCityname = [HDUserInfo shareUserInfos].locationCity;
}

- (NSString *)selectCityname
{
    if (!_selectCityname) {
        _selectCityname = [NSString stringWithFormat:@""];
    }
    return _selectCityname;
}

- (void)setIsSerach:(BOOL)isSerach
{
    _isSerach = isSerach;
    self.collectionView.hidden = _isSerach;
    self.cityView.hidden = _isSerach;
}

- (BOOL)myContainsString:(NSString*)string and:(NSString *)otherString {
    NSRange range = [string rangeOfString:otherString];
    return range.length != 0;
}

#pragma mark- 懒加载


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backBtn:(UIButton *)sender {
    self.cityLabel.text = [NSString stringWithFormat:@"当前城市：%@",[HDUserInfo shareUserInfos].locationCity];
    self.selectCityname = [HDUserInfo shareUserInfos].locationCity;
    if ([self.delegate respondsToSelector:@selector(cancelSearch)]) {
        [self.delegate cancelSearch];
    }
}

#pragma mark - 取消搜索的按钮
- (IBAction)cancelBtn:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(cancelSearch)]) {
        [self.delegate cancelSearch];
    }
}


#pragma mark -城市选择器
- (IBAction)selectCity:(id)sender {
    CityListViewController *cityListView = [[CityListViewController alloc]init];
    cityListView.delegate = self;
    //热门城市列表
    cityListView.arrayHotCity = [NSMutableArray arrayWithObjects:@"成都",@"重庆",@"昆明",@"德阳",@"资阳", nil];
    //历史选择城市列表
    NSMutableArray *historicalCity = [[NSUserDefaults standardUserDefaults]objectForKey:CommonlyUsedCity];
    cityListView.arrayHistoricalCity = historicalCity;
    //定位城市列表
    cityListView.arrayLocatingCity   = [NSMutableArray arrayWithObjects:self.selectCityname, nil];
    
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
    self.selectCityname = cityName;
    self.cityLabel.text = [NSString stringWithFormat:@"已选择城市：%@",cityName];
}


#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.collectionView.hidden = YES;
    self.cityView.hidden = YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([self.delegate respondsToSelector:@selector(sureSearch:city:)]) {
        [self.delegate sureSearch:textField.text city:self.selectCityname];
    }
    textField.text = @"";

    return YES;
}


@end
