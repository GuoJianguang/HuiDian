//
//  UICollectionView+NoDataSouce.m
//  Tourguide
//
//  Created by inphase on 15/4/28.
//  Copyright (c) 2015年 inphase. All rights reserved.
//

#import "NothingView.h"
#import "UIScrollView+NoDataSouce.h"

@implementation UIScrollView (NoDataSouce)


- (void)noDataSouce
{
    NothingView *nothingView = [[[NSBundle mainBundle] loadNibNamed:@"NothingView" owner:self options:nil] objectAtIndex:0];
    nothingView.tag = 101;
    nothingView.frame = self.bounds;
    [self addSubview:nothingView];
    nothingView.hidden = YES;
    nothingView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//    nothingView.center = CGPointMake(KWidth/2, self.bounds.size.height/2);
//    [nothingView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(self);
//    }];
}


//- (void)addHomeNoDatasouceWithCallback:(void (^)())callback andAlertSting:(NSString *)alerString andErrorImage:(NSString *)imageName andRefreshBtnHiden:(BOOL)isHidden
//{
//    NothingView *nothingView = [[[NSBundle mainBundle] loadNibNamed:@"NothingView" owner:self options:nil] objectAtIndex:0];
//    nothingView.tag = 101;
//    nothingView.frame = self.bounds;
//    [self addSubview:nothingView];
//    nothingView.hidden = YES;
//    nothingView.alertLabel.text = alerString;
//    nothingView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//    
//    nothingView.error_image.image = [UIImage imageNamed:imageName];
//    
//    nothingView.refresh_btn.hidden = isHidden;
//    
//    //刷新（重新请求）操作
//    NothingView *nothing = [self viewWithTag:101];
//    nothing.refreshCallback = callback;
//    
//
//}



- (void)addNoDatasouceWithCallback:(void (^)())callback andAlertSting:(NSString *)alerString andErrorImage:(NSString *)imageName andRefreshBtnHiden:(BOOL)isHidden
{
    for (id view in self.subviews) {
        if ([view isKindOfClass:[NothingView class]]) {
            [((NothingView *)view) removeFromSuperview];
        }
    }
    
    NothingView *nothingView = [[[NSBundle mainBundle] loadNibNamed:@"NothingView" owner:self options:nil] objectAtIndex:0];
    nothingView.tag = 101;
    nothingView.frame = self.bounds;
    [self addSubview:nothingView];
    nothingView.hidden = YES;
    nothingView.alertLabel.text = alerString;
    nothingView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    nothingView.error_image.image = [UIImage imageNamed:imageName];
    
    nothingView.refresh_btn.hidden = isHidden;
    
    ((NothingView *)[self viewWithTag:101]).refreshCallback = callback;
    //刷新（重新请求）操作
//    NothingView *nothing = [self viewWithTag:101];
//    nothing.refreshCallback = callback;
}


- (void)showRereshBtnwithALerString:(NSString *)alerString
{
    [self viewWithTag:101].hidden = NO;

    [self bringSubviewToFront:[self viewWithTag:101]];

    ((NothingView*)[self viewWithTag:101]).refresh_btn.hidden = NO;
    
    ((NothingView*)[self viewWithTag:101]).alertLabel.text = alerString;
    
    ((NothingView*)[self viewWithTag:101]).error_image.image = [UIImage imageNamed:@"pic_4"];

}


- (void)changeAlerSring:(NSString *)alerString andErrorImage:(NSString *)imageName
{
    ((NothingView*)[self viewWithTag:101]).alertLabel.text = alerString;
    
    ((NothingView*)[self viewWithTag:101]).error_image.image = [UIImage imageNamed:imageName];
}


- (void)judgeIsHaveDataSouce:(NSMutableArray *)dataSouceArray
{
    if (dataSouceArray.count == 0 ) {
        if ([self isKindOfClass:[UITableView class]]) {
            ((UITableView *)self).separatorStyle = UITableViewCellSeparatorStyleNone;
        }
        [self showNoDataSouce];
    }else{
        [self hiddenNoDataSouce];
    }
}


- (void)judgeIsHaveDataSouce:(NSMutableArray *)dataSouceArray andBannerArray:(NSMutableArray *)bannerArray
{
    if (dataSouceArray.count == 0&&bannerArray.count == 0) {
        [self showNoDataSouce];
    }else if(bannerArray.count != 0 && dataSouceArray.count ==0){
        
        CGFloat intervalX = 50.0;/**<横向间隔*/
        CGFloat intervalY = 15.0;/**<纵向间隔*/
        NSInteger columnNum = 4;/**<九宫格列数*/
        CGFloat widthAndHeightRatio = 2.0/3.0;/**<宽高比*/
        CGFloat buttonWidth = (TWitdh - 40 - intervalX * (columnNum - 1))/(CGFloat)columnNum;/**<button的宽度*/
        CGFloat buttonHeight = buttonWidth/widthAndHeightRatio;/**<button的高度*/
        ;
        [[self viewWithTag:100] removeFromSuperview];
        UIView *view  = [[UIView alloc]init];
        view.tag = 100;
        view.backgroundColor = [UIColor whiteColor];;
        [self addSubview:view];
        view.frame = CGRectMake(0, TWitdh*(35/75.) + buttonHeight * 2 + intervalY*2 + 18, TWitdh, self.bounds.size.height - (TWitdh*(35/75.) + buttonHeight * 2 + intervalY*2 + 18));
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.image = [UIImage imageNamed:@"pic_4"];
        [view addSubview:imageView];
        if (THeight == 480) {
            imageView.bounds = CGRectMake(0, 0, TWitdh/7, TWitdh/7*(20/23.));

        }else{
            imageView.bounds = CGRectMake(0, 0, TWitdh/5, TWitdh/5*(20/23.));
        }
        imageView.center = CGPointMake(view.bounds.size.width/2, view.bounds.size.height/2 - 10);
        
        UILabel *label = [[UILabel alloc]init];
        label.text = @"没有数据";
        [view addSubview:label];
        label.font = [UIFont systemFontOfSize:15];
        label.frame = CGRectMake(20, imageView.frame.origin.y + imageView.bounds.size.height, TWitdh - 40, 28);
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor grayColor];
        
        UIView *lineView  =[[UIView alloc]initWithFrame:CGRectMake(0, 0, TWitdh, 1)];
        [view addSubview:lineView];
        lineView.backgroundColor = MacolayerColor;
        
    }
    else{
        [self hiddenNoDataSouce];

    }

}



- (void)showNoDataSouce
{
    [self viewWithTag:101].hidden = NO;
    [self bringSubviewToFront:[self viewWithTag:101]];
}

- (void)hiddenNoDataSouce
{
    [self viewWithTag:101].hidden = YES;
    [self sendSubviewToBack:[self viewWithTag:101]];
    
    [[self viewWithTag:100] removeFromSuperview];
}

- (void)showNoDataSouceNoNetworkConnection
{
    [self viewWithTag:101].hidden = NO;
    ((NothingView *)[self viewWithTag:101]).error_image.image = [UIImage imageNamed:@"pic_no_network"];
    ((NothingView *)[self viewWithTag:101]).alertLabel.text = @"请检查您的网络";
    [self bringSubviewToFront:[self viewWithTag:101]];
}



@end
