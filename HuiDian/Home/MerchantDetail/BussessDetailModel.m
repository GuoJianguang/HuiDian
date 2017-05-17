//
//  BussessDetailModel.m
//  HuiDian
//
//  Created by mac on 2017/5/16.
//  Copyright © 2017年 Huidian. All rights reserved.
//

#import "BussessDetailModel.h"

@implementation BussessDetailModel
+ (id)modelWithDic:(NSDictionary *)dic
{
    BussessDetailModel *model = [[BussessDetailModel alloc]init];
    model.address = NullToSpace(dic[@"address"]);
    model.code = NullToSpace(dic[@"code"]);
    model.desc = NullToSpace(dic[@"desc"]);
    model.highQuality = NullToSpace(dic[@"highQuality"]);
    model.longitude = NullToSpace(dic[@"longitude"]);
    model.name = NullToSpace(dic[@"name"]);
    model.phone = NullToSpace(dic[@"phone"]);
    model.pic = NullToSpace(dic[@"pic"]);
    model.latitude = NullToSpace(dic[@"latitude"]);
    model.recommend = NullToSpace(dic[@"recommend"]);
    //    model.slidePic = NullToSpace(dic[@"slidePic"]);
    model.trade = NullToSpace(dic[@"trade"]);
    model.keyword = NullToSpace(dic[@"keyword"]);
    
    if ([dic[@"slidePic"] isKindOfClass:[NSArray class]]) {
        model.slidePic = dic[@"slidePic"];
    }else{
        model.slidePic = [NSArray array];
    }
    
    if ([dic[@"morePic"] isKindOfClass:[NSArray class]]) {
        for (NSDictionary *parms in dic[@"morePic"]) {
            [model.morePic addObject:[ImageModel modelWithDic:parms]];
        }
    }else{
        model.morePic = [NSMutableArray array];
    }
    
    
    return model;
}

- (NSMutableArray *)morePic
{
    if (!_morePic) {
        _morePic = [NSMutableArray array];
    }
    return _morePic;
}

- (NSArray *)slidePic
{
    if (!_slidePic) {
        _slidePic  = [NSArray array];
    }
    return _slidePic;
}



@end


@implementation ImageModel

+ (id)modelWithDic:(NSDictionary *)dic
{
    ImageModel *model = [[ImageModel alloc]init];
    model.image = NullToSpace(dic[@"image"]);
    model.height = [NullToNumber(dic[@"height"]) doubleValue];
    model.width = [NullToNumber(dic[@"width"]) doubleValue];
    return model;

}

@end
