//
//  HomeSortTableViewCell.m
//  TTXForConsumer
//
//  Created by mac on 2017/5/15.
//  Copyright © 2017年 ttx. All rights reserved.
//

#import "HomeSortTableViewCell.h"
#import "HomeViewController.h"

@implementation HomeSortTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.contentView.backgroundColor = [UIColor colorFromHexString:@"#e6e6e6"];
    [self.allBtn setTitleColor:MacoTitleColor forState:UIControlStateNormal];
    [self.distanceBtn setTitleColor:MacoTitleColor forState:UIControlStateNormal];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)allBtn:(UIButton *)sender {
    ((HomeViewController*)self.viewController).sortWay = @"1";
    [((HomeViewController*)self.viewController).tableView.mj_header beginRefreshing];
    self.allView.hidden = NO;
    self.distacneView.hidden  = YES;
}
- (IBAction)distanceBtn:(UIButton *)sender {
    ((HomeViewController*)self.viewController).sortWay = @"2";
    [((HomeViewController*)self.viewController).tableView.mj_header beginRefreshing];
    self.allView.hidden = YES;
    self.distacneView.hidden  = NO;
}

- (void)setSortWay:(NSString *)sortWay{
    _sortWay = sortWay;
    if ([_sortWay isEqualToString:@"1"]) {
        self.allView.hidden = NO;
        self.distacneView.hidden  = YES;
        return;
    }
    self.allView.hidden = YES;
    self.distacneView.hidden  = NO;
}
@end
