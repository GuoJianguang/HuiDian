//
//  FlagshipCollectionViewCell.h
//  TTXForConsumer
//
//  Created by Guo on 2017/2/23.
//  Copyright © 2017年 ttx. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FlagShipDataModel : BaseModel

@property (nonatomic, strong)NSString *aviableBalance;

@property (nonatomic, strong)NSString *mchCode;

@property (nonatomic, strong)NSString *mchName;

@property (nonatomic, strong)NSString *pic;




@end

@interface FlagshipCollectionViewCell : BaseCollectionViewCell


@property (nonatomic, strong)FlagShipDataModel *dataModel;
@property (weak, nonatomic) IBOutlet UILabel *shipName;

@property (weak, nonatomic) IBOutlet UIImageView *shipImageView;




@end
