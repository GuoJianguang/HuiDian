//
//  HomeSortTableViewCell.h
//  TTXForConsumer
//
//  Created by mac on 2017/5/15.
//  Copyright © 2017年 ttx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeSortTableViewCell : BaseTableViewCell
@property (weak, nonatomic) IBOutlet UIButton *allBtn;
- (IBAction)allBtn:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIButton *distanceBtn;
- (IBAction)distanceBtn:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIView *allView;
@property (weak, nonatomic) IBOutlet UIView *distacneView;

@property (nonatomic, copy)NSString *sortWay;

@end
