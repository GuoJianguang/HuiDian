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

@interface RoundView()

@property (nonatomic,strong)UILabel *proessLabel;

@end

@implementation RoundView

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)setProess:(CGFloat)proess
{
    _proess = proess;
    [self setNeedsDisplay];
}
- (void)setWidth:(CGFloat)width
{
    _width = width;
    [self setNeedsDisplay];
}

- (void)setRadius:(CGFloat)radius
{

    _radius = radius;
    [self setNeedsDisplay];
}

- (void)setMinradius:(CGFloat)minradius
{
    _minradius = minradius;
    [self setNeedsDisplay];

}


- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self) {
        self = [super initWithCoder:aDecoder];

    }
    return self;
}

- (UILabel *)proessLabel
{
    if (!_proessLabel) {
        _proessLabel = [[UILabel alloc]init];
        _proessLabel.textColor = [UIColor colorFromHexString:@"#dd137b"];
        _proessLabel.font = [UIFont systemFontOfSize:15.];
        _proessLabel.font = [UIFont boldSystemFontOfSize:30];
        _proessLabel.textAlignment = NSTextAlignmentCenter;
        _proessLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _proessLabel;
}

- (void)setMoney:(CGFloat)money
{
    _money = money;
    self.proessLabel.text = [NSString stringWithFormat:@"¥%.2f",_money];
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    //获取图形上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    UIBezierPath *basePath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.center.x, self.bounds.size.height - 60) radius:self.radius startAngle:M_PI endAngle:0 clockwise:YES];

    //把路径添加到上下文
    //线条宽度
    CGContextSetLineWidth(ctx, self.width);
    //设置线条顶端
    CGContextSetLineCap(ctx, kCGLineCapButt);
    [MacoTitleColor setStroke];
    CGContextAddPath(ctx, basePath.CGPath);
    //渲染粗线
    CGContextStrokePath(ctx);
    
    UIBezierPath *loadPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.center.x, self.bounds.size.height - 60) radius:self.radius startAngle:M_PI endAngle:(1+self.proess)*M_PI clockwise:YES];
    
    //把路径添加到上下文
    //线条宽度
    CGContextSetLineWidth(ctx, self.width);
    //设置线条顶端
    CGContextSetLineCap(ctx, kCGLineCapButt);
    [[UIColor colorFromHexString:@"#dd137b"] setStroke];
    CGContextAddPath(ctx, loadPath.CGPath);
    //渲染路径线
    CGContextStrokePath(ctx);
    
    
    
    UIBezierPath *basePath1 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.center.x, self.bounds.size.height - 60) radius:self.minradius startAngle:M_PI endAngle:0 clockwise:YES];
    
    //把路径添加到上下文
    //线条宽度
    CGContextSetLineWidth(ctx, 3);
    //设置线条顶端
    CGContextSetLineCap(ctx, kCGLineCapButt);
    [MacoTitleColor setStroke];
    CGContextAddPath(ctx, basePath1.CGPath);
    //渲染细线
    CGContextStrokePath(ctx);
    
    
    //画圆点
    
    CGFloat endImageWidth = self.width +8 ;
    CGFloat valueEndA = 180*(1-self.proess);
    CGFloat x = TWitdh/2. + (self.radius)*cosf(valueEndA*M_PI/180) - endImageWidth/2;
    CGFloat y = self.bounds.size.height - 60 - self.radius*sinf(valueEndA*M_PI/180) - endImageWidth/2;
    UIImage *image = [UIImage imageNamed:@"pic_indicating_circle"];
    CGContextDrawImage(ctx, CGRectMake(x, y, endImageWidth, endImageWidth), image.CGImage);

    
//    画文字
    CGSize size = CGSizeMake(self.minradius *1.6 , 30);
    self.proessLabel.frame = CGRectMake(TWitdh/2. - size.width/2., self.bounds.size.height - 60 - self.minradius/2.,size.width, size.height);
    [self addSubview:self.proessLabel];
}

- (void)setReduceValue:(CGFloat)reduceValue
{
    if (_reduceValue != CircleDegreeToRadian(reduceValue)) {
        if (reduceValue>=360) {
            return;
        }
        _reduceValue = CircleDegreeToRadian(reduceValue);
        [self setNeedsDisplay];
    }}

@end
