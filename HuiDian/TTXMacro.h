//
//  TTXMacro.h
//  天添薪
//
//  Created by ttx on 16/1/6.
//  Copyright © 2016年 ttx. All rights reserved.
//

#ifndef TTXMacro_h
#define TTXMacro_h



#define NullToSpace(string) (([string class] != [NSNull class] && string) ? [string description]: @"")
#define NullToNumber(string) (([string class] != [NSNull class] && string) ? [string description]: @"0")

//友盟的key
/**
 友盟appstore的key
 */
#define YoumengKey @"58ca3298f43e487d560016d0"
/**
微信支付的key
 */
#define WXApiKey @"wx0032c653b99c31f1"
/**
 高德appstore的key
 */
#define MAP_APPKEY_APPSTORE @"61ee8210243db6b5e2765d8bb756d59f"
//密码md5加密key
#define PasswordKey @"PW2017$HD"
//#define PasswordKey @"PW2017$LY"
//PW2017$LY
//生成订单md5加密key
#define OrderWithMd5Key @"T2t0X16"


//加载失败的图片
#define LoadingErrorDefaultImageCircular ([UIImage imageNamed:@"defaultImagecircular"])
#define LoadingErrorDefaultImageSquare ([UIImage imageNamed:@"defaultImageSquare"])
#define LoadingErrorDefaultImageBanner ([UIImage imageNamed:@"shangjiaxiangqingdatu"])
#define LoadingErrorDefaultHearder ([UIImage imageNamed:@"pic_head_portrait"])

#define AppIconImage ([UIImage imageNamed:@"AppIcon"])



//登出的通知
#define LogOutNSNotification @"LogOutNSNotification"
//记录历史的城市选择
#define CommonlyUsedCity @"CommonlyUsedCity"
//修改头像成功
#define ChangeHeadImageSuccess @"ChangeHeadImageSuccess"
//修改昵称成功
#define ChangeNickNameSucces @"ChangeNickNameSucces"
//保存登录的用户名
#define LoginUserName @"LoginUserName"
#define LoginUserPassword @"LoginUserPassword"
//搜索商户的通知
#define SearchKeyWord @"SearchKeyWord"
//微信支付的结果回调
#define WeixinPayResult @"WeixinPayResult"

//接收让利回馈信息的推送
#define Upush_Notifi @"Upush_Fanxian_Notifi"
//账户抵换信息推送
#define Upush_tixian_Notifi @"Upush_tixian_Notifi"
//待付款订单推送
#define Upush_Order_Notifi @"Upush_Order_Notifi"
//商家未结算推送
#define Upush_NotJiesuan_Notifi @"Upush_NotJiesuan_Notifi"


#define AutoLoginAfterGetDeviceToken @"AutoLoginAfterGetDeviceToken"

#define IsRequestTrue ([NullToNumber(jsonObject[@"code"]) isEqualToString:@"0"])


#define TWitdh  [UIScreen mainScreen].bounds.size.width
#define THeight [UIScreen mainScreen].bounds.size.height
#define MacoColor [UIColor colorFromHexString:@"#ea3d3a"]
#define MacoYellowColor [UIColor colorFromHexString:@"#fff500"]
#define MacoBlueColor [UIColor colorFromHexString:@"#4c2575"]
#define MacoPriceColor [UIColor colorFromHexString:@"f27242"]


#define MacoGrayColor [UIColor colorWithRed:241/255. green:247/255. blue:247/255. alpha:1.]

//标题的颜色
#define MacoTitleColor [UIColor colorFromHexString:@"#4c2575"]
//详情的字体颜色
#define MacoDetailColor [UIColor colorFromHexString:@"#969696"]
//介绍的字体颜色
#define MacoIntrodouceColor [UIColor colorFromHexString:@"#b4b4b4"]
//边框的颜色
#define MacolayerColor [UIColor colorFromHexString:@"#e6e6e6"]

//appStore地址
#define AppStoreDetailUrl @"https://itunes.apple.com/us/app/tian-tian-xin/id1079754747?l=zh&ls=1&mt=8"
//列表请求每页的条数
//每页条数
#define MacoRequestPageCount @"20"

#endif /* TTXMacro_h */
