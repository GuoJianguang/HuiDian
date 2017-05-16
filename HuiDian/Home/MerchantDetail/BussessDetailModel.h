//
//  BussessDetailModel.h
//  HuiDian
//
//  Created by mac on 2017/5/16.
//  Copyright © 2017年 Huidian. All rights reserved.
//

#import "BaseModel.h"

@interface BussessDetailModel : BaseModel
@property (nonatomic, copy)NSString *address;
@property (nonatomic, copy)NSString *code;
@property (nonatomic, copy)NSString *desc;
@property (nonatomic, copy)NSString *highQuality;
@property (nonatomic, copy)NSString *keyword;
@property (nonatomic, copy)NSString *latitude;
@property (nonatomic, copy)NSString *longitude;
@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *phone;
@property (nonatomic, copy)NSString *pic;
@property (nonatomic, copy)NSString *recommend;
@property (nonatomic, copy)NSArray *slidePic;
@property (nonatomic, copy)NSString *trade;
@property (nonatomic, copy)NSArray *morePic;

@end
