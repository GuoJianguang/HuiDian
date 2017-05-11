//
//  WalletDynamicViewController.m
//  HuiDian
//
//  Created by mac on 2017/5/9.
//  Copyright © 2017年 Huidian. All rights reserved.
//

#import "WalletDynamicViewController.h"
#import "WalletView2.h"
#import "WalletView3.h"
#import "WalletView1.h"


@interface WalletDynamicViewController ()<SwipeViewDelegate,SwipeViewDataSource,SortButtonSwitchViewDelegate>

@property (nonatomic, strong)WalletView2 *withDrawView;
@property (nonatomic, strong)WalletView1 *orderView;
@property (nonatomic, strong)WalletView3 *earningsView;
@end

@implementation WalletDynamicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.naviBar.title = @"钱包动态";
    [self.view sendSubviewToBack:self.bgImageView];
    self.isWhiteBg = YES;
    self.sortView.titleArray = @[@"订单记录",@"提现记录",@"每日收益"];
    self.sortView.delegate = self;
    self.naviBar.lineVIew.hidden = YES;
    self.swipew.dataSource = self;
    self.swipew.delegate = self;
}

- (WalletView1 *)orderView
{
    if (!_orderView) {
        _orderView =[[WalletView1 alloc]init];
    }
    return _orderView;
}

- (WalletView3 *)earningsView
{
    if (!_earningsView) {
        _earningsView = [[WalletView3 alloc]init];
    }
    return _earningsView;
}

- (WalletView2 *)withDrawView{
    if (!_withDrawView) {
        _withDrawView = [[WalletView2 alloc]init];
    }
    return _withDrawView;
}
#pragma mark - SortViewDelegate
- (void)sortBtnDselect:(SortButtonSwitchView *)sortView withSortId:(NSString *)sortId
{
    [self.swipew scrollToPage:[sortId integerValue] -1 duration:0.5];
    
}
#pragma mark - SwipeView
- (UIView *)swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    if (view == nil) {
        view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, swipeView.frame.size.width, swipeView.frame.size.height)];
        view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    for (UIView *subView in view.subviews) {
        [subView removeFromSuperview];
    }
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, 0, 0);
    switch (index) {
        case 0:{
            [view addSubview:self.orderView];
            [self.orderView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(view).insets(insets);
            }];
        }
            break;
        case 1:{
            [view addSubview:self.withDrawView];
            [self.withDrawView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(view).insets(insets);
            }];
        }
            break;
        case 2:{
            [view addSubview:self.earningsView];
            [self.earningsView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(view).insets(insets);
            }];
        }
            break;
            
        default:
            break;
    }
    
    return view;
}

- (NSInteger)numberOfItemsInSwipeView:(SwipeView *)swipeView
{
    return 3;
}
- (void)swipeViewCurrentItemIndexDidChange:(SwipeView *)swipeView
{
    switch (swipeView.currentPage) {
        case 0:
            [self.orderView reload];
            break;
        case 1:
            [self.withDrawView reload];
            break;
        case 2:
            [self.earningsView reload];
            break;
        default:
            break;
    }
    [self.sortView selectItem:swipeView.currentItemIndex ];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
