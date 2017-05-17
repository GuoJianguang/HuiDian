//
//  RoundView.h
//  HuiDian
//
//  Created by mac on 2017/5/16.
//  Copyright © 2017年 Huidian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RoundView : UIView

//占比（进度）
@property (nonatomic,assign)CGFloat proess;

//线宽
@property (nonatomic,assign)CGFloat width;
//半径
@property (nonatomic,assign)CGFloat radius;

//内圈半径半径
@property (nonatomic,assign)CGFloat minradius;
/**<减少的角度 直接传度数 如30*/
@property (nonatomic, assign) CGFloat reduceValue;

@property (nonatomic, assign)CGFloat money;



@end
