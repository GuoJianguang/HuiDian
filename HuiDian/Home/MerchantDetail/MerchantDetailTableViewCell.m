//
//  MerchantDetailTableViewCell.m
//  HuiDian
//
//  Created by mac on 2017/5/16.
//  Copyright © 2017年 Huidian. All rights reserved.
//

#import "MerchantDetailTableViewCell.h"
#import "BussessMapViewController.h"

@interface MerchantDetailTableViewCell()<SwipeViewDataSource,SwipeViewDelegate,UIActionSheetDelegate>

@end

@implementation MerchantDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.swipeView.dataSource = self;
    self.swipeView.delegate = self;
    self.pageCongtrol.pageIndicatorTintColor = MacoYellowColor;
    self.pageCongtrol.currentPageIndicatorTintColor = MacoTitleColor;
    
    self.mchantName.textColor = [UIColor colorFromHexString:@"#3d3d3d"];
    [self.addressBtn setTitleColor:[UIColor colorFromHexString:@"#aaaaaa"] forState:UIControlStateNormal];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDataModel:(BussessDetailModel *)dataModel
{
    _dataModel = dataModel;
    self.mchantName.text = _dataModel.name;
    self.pageCongtrol.numberOfPages = _dataModel.slidePic.count;
    
    //电话
    [self.addressBtn setTitle:_dataModel.address forState:UIControlStateNormal];

    if (_dataModel.slidePic.count == 0) {
        self.pageCongtrol.hidden = YES;
        _dataModel.slidePic = @[@"http://192.168.1.2/more.png"];
    }
    [self.swipeView reloadData];
    [[AutoScroller shareAutoScroller]autoSwipeView:self.swipeView WithPageView:self.pageCongtrol WithDataSouceArray:[NSMutableArray arrayWithArray:_dataModel.slidePic]];
}


#pragma mark -- Banner
- (NSInteger)numberOfItemsInSwipeView:(SwipeView *)swipeView
{
    return self.dataModel.slidePic.count;;
}

- (UIView *)swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    UIImageView *imageView = nil;
    if (nil == view) {
        view = [[UIView alloc] initWithFrame:swipeView.bounds];
        imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        imageView.bounds = CGRectMake(0, 0, TWitdh, self.swipeView.bounds.size.height);
        imageView.center = swipeView.center;
        imageView.tag = 10;
        [view addSubview:imageView];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        view.autoresizingMask = UIViewAutoresizingFlexibleHeight |
        UIViewAutoresizingFlexibleWidth;
        imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth |
        UIViewAutoresizingFlexibleHeight;
    }else {
        imageView = (UIImageView*)[view viewWithTag:10];
    }
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.dataModel.slidePic[index]] placeholderImage:LoadingErrorDefaultImageBanner];
    
    return view;
}

- (void)swipeViewCurrentItemIndexDidChange:(SwipeView *)swipeView
{
    //    self.pageView.currentIndicatorIndex = swipeView.currentPage;
    self.pageCongtrol.currentPage = swipeView.currentPage;
}

- (void)swipeView:(SwipeView *)swipeView didSelectItemAtIndex:(NSInteger)index
{
    //banner点击事件
    if (self.dataModel.slidePic.count ==0) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"暂时没有更多图片" duration:1.5];
        return;
    }
    [ImageViewer sharedImageViewer].controller = self.viewController;
    [[ImageViewer sharedImageViewer]showImageViewer:[NSMutableArray arrayWithArray:self.dataModel.slidePic] withIndex:index andView:self];
}


- (IBAction)backBtn:(id)sender {
    [self.viewController.navigationController popViewControllerAnimated:YES];
}
- (IBAction)callPhoneBtn:(UIButton *)sender {
    if ([self.dataModel.phone containsString:@","]) {
        NSArray *arry =   [self.dataModel.phone componentsSeparatedByString:@","];
        
        UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:@"拨打商家电话" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles: nil];
        for (int i = 0; i < arry.count; i ++) {
            [sheet addButtonWithTitle:arry[i]];
        }
        [sheet showInView:self.viewController.view];
    }else{
        //只有一个电话号码
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",self.dataModel.phone];
        UIWebView * callWebview = [[UIWebView alloc] init];
        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
        [self.viewController.view addSubview:callWebview];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        return;
    }
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel://%@",[actionSheet buttonTitleAtIndex:buttonIndex]];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}
- (IBAction)addressBtn:(UIButton *)sender {
    BussessMapViewController *mapVC = [[BussessMapViewController alloc]init];
    
    CLLocationCoordinate2D d;
    d.latitude = [self.dataModel.latitude floatValue];
    d.longitude = [self.dataModel.longitude floatValue];
    
    if (d.longitude == 0 || d.latitude == 0) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"该商户暂时没有位置信息" duration:1.5];
        return;
    }
    
    mapVC.destinationCoordinate = d;
    mapVC.dataModel = self.dataModel;
    [self.viewController.navigationController pushViewController:mapVC animated:YES];

}
@end
