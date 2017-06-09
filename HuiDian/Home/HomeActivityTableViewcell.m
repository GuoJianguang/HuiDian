//
//  MallDetailTableViewCell.m
//  TTXForConsumer
//
//  Created by Guo on 2017/2/23.
//  Copyright © 2017年 ttx. All rights reserved.
//

#import "HomeActivityTableViewcell.h"
#import "FlagshipCollectionViewCell.h"
//#import "UIColor+Wonderful.h"
//#import "FlagShipViewController.h"
//#import "TopLineViewController.h"
//#import "DisCountViewController.h"
#import "MerchantDetailViewController.h"


@implementation ActivityModel

+ (id)modelWithDic:(NSDictionary *)dic
{
    ActivityModel *model = [[ActivityModel alloc]init];
    model.activityEndTime = NullToSpace(dic[@"activityEndTime"]);
    model.activityStartTime = NullToSpace(dic[@"activityStartTime"]);
    model.coverImg = NullToSpace(dic[@"coverImg"]);
    model.createTime = NullToSpace(dic[@"createTime"]);
    model.name = NullToSpace(dic[@"name"]);
    model.remark = NullToSpace(dic[@"remark"]);
    model.seqId = NullToSpace(dic[@"seqId"]);
    model.sort = NullToSpace(dic[@"sort"]);
    model.state = NullToSpace(dic[@"state"]);
    model.type = NullToSpace(dic[@"type"]);
    model.jumpValue = NullToSpace(dic[@"jumpValue"]);
    return model;
}


@end

@interface HomeActivityTableViewcell()<UICollectionViewDelegate,UICollectionViewDataSource,SwipeViewDelegate,SwipeViewDataSource>

@end

@implementation HomeActivityTableViewcell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.swipeView.dataSource = self;
    self.swipeView.delegate = self;
    self.topLineLabel.textColor = MacoTitleColor;
    
    self.pageView.pageIndicatorTintColor = MacoYellowColor;
    self.pageView.currentPageIndicatorTintColor = MacoTitleColor;
}


- (void)setFlagShipArray:(NSMutableArray *)flagShipArray
{
    if (!_flagShipArray) {
        _flagShipArray = [NSMutableArray array];
    }
    [_flagShipArray removeAllObjects];
    [_flagShipArray addObjectsFromArray:flagShipArray];
//    if (_flagShipArray.count > 3) {
//        self.flagShipHeight.constant = TWitdh*(492/750.);
//    }else{
//        self.flagShipHeight.constant = TWitdh*(310/750.);
//    }
    self.flagShipHeight.constant = TWitdh*(310/750.);
    if (_flagShipArray.count == 0) {
        UILabel *alerLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, TWitdh - 16, TWitdh*(230/750.))];
        alerLabel.backgroundColor = [UIColor grayColor];
        alerLabel.text = @"暂无人气商家";
        alerLabel.textAlignment = NSTextAlignmentCenter;
        alerLabel.textColor = MacoColor;
        alerLabel.font = [UIFont systemFontOfSize:25];
        [self.collectionView addSubview:alerLabel];
        return;
    }
    
    [self.collectionView reloadData];
}


- (void)setActivityAarray:(NSMutableArray *)activityAarray{
    if (!_activityAarray) {
        _activityAarray = [NSMutableArray array];
    }
    [_activityAarray removeAllObjects];
    [_activityAarray addObjectsFromArray:activityAarray];
    self.pageView.numberOfPages = _activityAarray.count;
    if (_activityAarray.count == 0 ) {
        ActivityModel *model = [[ActivityModel alloc]init];
        model.coverImg = @"";
        model.remark = @"";
        [_activityAarray addObject:model];
    }
    [self.swipeView reloadData];
}

- (void)setMerchantArray:(NSMutableArray *)merchantArray
{
    _merchantArray = merchantArray;
    if (_merchantArray.count == 0) {
        self.nearlyMerchantView.hidden = YES;
    }else{
        self.nearlyMerchantView.hidden = NO;

    }
}
#pragma mark - 限时折扣

- (NSInteger)numberOfItemsInSwipeView:(SwipeView *)swipeView
{
    return self.activityAarray.count;
}


- (UIView *)swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    UIImageView *imageView = nil;
    if (nil == view) {
        view = [[UIView alloc] initWithFrame:swipeView.bounds];
        imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
//        imageView.bounds = CGRectMake(0, 0, TWitdh, self.swipeView.bounds.size.height);
        imageView.center = swipeView.center;
        imageView.tag = 10;
        [view addSubview:imageView];
        imageView.contentMode = UIViewContentModeScaleToFill;
        imageView.layer.masksToBounds = YES;
        view.autoresizingMask = UIViewAutoresizingFlexibleHeight |
        UIViewAutoresizingFlexibleWidth;
        imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth |
        UIViewAutoresizingFlexibleHeight;
        UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, 0, 0);
        [view addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(view).insets(insets);
        }];
        

    }else {
        imageView = (UIImageView*)[view viewWithTag:10];
    }
    ActivityModel *model = self.activityAarray[index];
    [imageView sd_setImageWithURL:[NSURL URLWithString:model.coverImg] placeholderImage:LoadingErrorDefaultImageBanner];

    return view;
}


- (void)swipeViewCurrentItemIndexDidChange:(SwipeView *)swipeView
{
    self.pageView.currentPage = swipeView.currentPage;
}


-(void)swipeView:(SwipeView *)swipeView didSelectItemAtIndex:(NSInteger)index
{
    ActivityModel *model = self.activityAarray[index];
    if ([model.remark isEqualToString:@"暂无"]) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"暂无限时折扣活动" duration:2.];
        return;
    }
    BaseHtmlViewController *htmlVC = [[BaseHtmlViewController alloc]init];
    htmlVC.htmlUrl = model.jumpValue;
    htmlVC.htmlTitle = model.name;
    [self.viewController.navigationController pushViewController:htmlVC animated:YES];
}


#pragma mark - UICollectionView

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
//    if (self.sortDataSouceArray.count < 5) {
//        return self.sortDataSouceArray.count;
//    }
    return self.flagShipArray.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个UICollectionView展示的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier =[FlagshipCollectionViewCell indentify];
    static BOOL nibri =NO;
    if(!nibri)
    {
        UINib *nib = [FlagshipCollectionViewCell newCell];
        [collectionView registerNib:nib forCellWithReuseIdentifier:identifier];
        nibri =YES;
    }
    FlagshipCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.dataModel = self.flagShipArray[indexPath.item];
    nibri=NO;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    MerchantDetailViewController *merchantDVC = [[MerchantDetailViewController alloc]init];
    FlagShipDataModel *model = self.flagShipArray[indexPath.item];
    merchantDVC.merchantCode = model.mchCode;
    [self.viewController.navigationController pushViewController:merchantDVC animated:YES];
}


//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    if (_flagShipArray.count > 3) {
//        self.flagShipHeight.constant = TWitdh*(492/750.);
//    }else{
//        self.flagShipHeight.constant = TWitdh*(310/750.);
//    }
    return CGSizeMake((TWitdh- 16)/3., TWitdh*(310/750.)-(TWitdh *(8/75.)));

//    if (_flagShipArray.count > 3) {
//        return CGSizeMake((TWitdh- 16)/3., (TWitdh*(485/750.)-(TWitdh *(8/75.)))/2.);
//    }else{
//    }
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                        layout:(UICollectionViewLayout *)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}




- (IBAction)moreTopShip:(id)sender {
//    FlagShipViewController *shipVC = [[FlagShipViewController alloc]init];
//    shipVC.flagShipArray = self.flagShipArray;
//    [self.viewController.navigationController pushViewController:shipVC animated:YES];
}

- (IBAction)moreTopLine:(id)sender {
//    TopLineViewController *topLineVC = [[TopLineViewController alloc]init];
//    topLineVC.dataSouceArray = self.topLineArray;
//    [self.viewController.navigationController pushViewController:topLineVC animated:YES];
}
@end
