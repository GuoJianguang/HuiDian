//
//  MerchantDetailViewController.m
//  HuiDian
//
//  Created by mac on 2017/5/16.
//  Copyright © 2017年 Huidian. All rights reserved.
//

#import "MerchantDetailViewController.h"
#import "MerchantDetailTableViewCell.h"

@interface MerchantDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)BussessDetailModel *dataModel;

@end

@implementation MerchantDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.naviBar.hidden = YES;
    [self detailRequest:self.merchantCode];
    self.isWhiteBg = YES;
}


#pragma mark - 商户详情接口请求
- (void)detailRequest:(NSString *)mchCode
{
    [SVProgressHUD showWithStatus:@"正在加载..." maskType:SVProgressHUDMaskTypeBlack];
    NSDictionary *parms = @{@"code":mchCode};
    [HttpClient GET:@"mch/get" parameters:parms success:^(NSURLSessionDataTask *operation, id jsonObject) {
        [SVProgressHUD dismiss];
        if (IsRequestTrue) {
            self.dataModel = [BussessDetailModel modelWithDic:jsonObject[@"data"]];
            [self.tableView reloadData];
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [SVProgressHUD dismiss];

    }];
}


#pragma mark - UITableView
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MerchantDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[MerchantDetailTableViewCell indentify]];
    if (!cell) {
        cell = [MerchantDetailTableViewCell newCell];
    }
    if (self.dataModel) {
        cell.dataModel = self.dataModel;
    }
//    if (self.commentArray) {
//        cell.commentArray  = self.commentArray;
//    }
//    cell.goodsArray = self.goodsArray;
    return cell;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0;
    for (ImageModel *model in self.dataModel.morePic) {
        height += TWitdh*(model.height/model.width);
    }
    return TWitdh *(55/75.) + height;
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
