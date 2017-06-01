//
//  MallDetailTableViewCell.h
//  TTXForConsumer
//
//  Created by Guo on 2017/2/23.
//  Copyright © 2017年 ttx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityModel : BaseModel
@property (nonatomic, copy)NSString *activityEndTime;
@property (nonatomic, copy)NSString *activityStartTime;
@property (nonatomic, copy)NSString *coverImg;
@property (nonatomic, copy)NSString *createTime;
@property (nonatomic, copy)NSString *remark;
@property (nonatomic, copy)NSString *name;

@property (nonatomic, copy)NSString *seqId;
@property (nonatomic, copy)NSString *sort;
@property (nonatomic, copy)NSString *state;
@property (nonatomic, copy)NSString *type;

@property (nonatomic, copy)NSString *jumpValue;

@end

@interface HomeActivityTableViewcell : BaseTableViewCell
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;


@property (nonatomic, strong)NSMutableArray *flagShipArray;;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *flagShipHeight;


@property (nonatomic, strong)NSMutableArray *activityAarray;


@property (weak, nonatomic) IBOutlet SwipeView *swipeView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageView;

@property (weak, nonatomic) IBOutlet UILabel *topLineLabel;


- (IBAction)moreTopShip:(id)sender;

- (IBAction)moreTopLine:(id)sender;




@end
