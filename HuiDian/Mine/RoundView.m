//
//  RoundView.m
//  HuiDian
//
//  Created by mac on 2017/5/16.
//  Copyright © 2017年 Huidian. All rights reserved.
//


#import "RoundView.h"

//宽高定义
#define CircleSelfWidth (TWitdh - 140)/2
#define CircleSelfHeight self.frame.size.height
#define CircleDegreeToRadian(d) ((d)*M_PI)/180.0

@implementation RoundView

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.backgroundColor = [UIColor cyanColor];
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    //获取图形上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    UIBezierPath *basePath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.center.x, self.bounds.size.height - 60) radius:(TWitdh - 140)/2. startAngle:M_PI endAngle:0 clockwise:YES];

    //把路径添加到上下文
    //线条宽度
    CGContextSetLineWidth(ctx, 12);
    //设置线条顶端
    CGContextSetLineCap(ctx, kCGLineCapButt);
    [MacoTitleColor setStroke];
    CGContextAddPath(ctx, basePath.CGPath);
    //渲染粗线
    CGContextStrokePath(ctx);
    
    UIBezierPath *loadPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.center.x, self.bounds.size.height - 60) radius:(TWitdh - 140)/2. startAngle:M_PI endAngle:1.5*M_PI clockwise:YES];
    
    //把路径添加到上下文
    //线条宽度
    CGContextSetLineWidth(ctx, 12);
    //设置线条顶端
    CGContextSetLineCap(ctx, kCGLineCapButt);
    [[UIColor colorFromHexString:@"#dd137b"] setStroke];
    CGContextAddPath(ctx, loadPath.CGPath);
    //渲染路径线
    CGContextStrokePath(ctx);
    
    
    
    UIBezierPath *basePath1 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.center.x, self.bounds.size.height - 60) radius:(TWitdh - 180)/2. startAngle:M_PI endAngle:0 clockwise:YES];
    
    //把路径添加到上下文
    //线条宽度
    CGContextSetLineWidth(ctx, 3);
    //设置线条顶端
    CGContextSetLineCap(ctx, kCGLineCapButt);
    [MacoTitleColor setStroke];
    CGContextAddPath(ctx, basePath1.CGPath);
    //渲染细线
    CGContextStrokePath(ctx);
    
    CGFloat x = TWitdh/2. + ((TWitdh - 140)/2.)*cosf(90);
//    CGFloat y = self.bounds.size.height - 60 - (((TWitdh - 140)/2.)*sinf(90));

//    CGFloat x = TWitdh/2. - 12/2.;
    CGFloat y = self.bounds.size.height - 60 - ((TWitdh - 140)/2.) - 6;
    UIImage *image = [UIImage imageNamed:@"pic_indicating_circle"];
     CGContextDrawImage(ctx, CGRectMake(x, y, 12, 12), image.CGImage);
    
}

@end
