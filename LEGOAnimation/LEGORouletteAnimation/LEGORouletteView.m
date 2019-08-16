



//
//  LEGORouletteView.m
//  LEGOAnimation
//
//  Created by 杨庆人 on 2019/8/16.
//  Copyright © 2019年 杨庆人. All rights reserved.
//

#import "LEGORouletteView.h"

@interface LEGORouletteView ()
@property (nonatomic, strong) CAShapeLayer *dottedLayer1;
@property (nonatomic, strong) CAShapeLayer *dottedLayer2;

@end

@implementation LEGORouletteView

- (instancetype)init {
    if (self = [super init]) {
        [self setRouletteView];
    }
    return self;
}

- (void)setRouletteView {
    UIView *redView = [[UIView alloc] init];
    redView.backgroundColor = [UIColor blueColor];
    [self addSubview:redView];
    [redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(1);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.right.mas_equalTo(self.mas_centerX);
    }];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.layer.cornerRadius = self.bounds.size.width / 2.0;
    self.layer.masksToBounds = YES;
    
    if (self.dottedLayer1) {
        [self.dottedLayer1 removeFromSuperlayer];
    }
    CAShapeLayer *dottedLayer1 = [CAShapeLayer layer];
    dottedLayer1.strokeColor = [UIColor grayColor].CGColor;
    dottedLayer1.fillColor = nil;
    dottedLayer1.path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:self.layer.cornerRadius].CGPath;
    dottedLayer1.frame = self.bounds;
    dottedLayer1.lineWidth = 1.5;
    dottedLayer1.lineCap = @"square";
    [self.layer addSublayer:dottedLayer1];
    self.dottedLayer1 = dottedLayer1;
    
    if (self.dottedLayer2) {
        [self.dottedLayer2 removeFromSuperlayer];
    }
    CAShapeLayer *dottedLayer2 = [CAShapeLayer layer];
    dottedLayer2.strokeColor = [UIColor blackColor].CGColor;
    dottedLayer2.fillColor = nil;
    dottedLayer2.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(15, 15, self.bounds.size.width - 30, self.bounds.size.height -30) cornerRadius:self.layer.cornerRadius].CGPath;
    dottedLayer2.frame = self.bounds;
    dottedLayer2.lineWidth = 0.75;
    dottedLayer2.lineCap = @"square";
    dottedLayer2.lineDashPattern = @[@8, @8];
    [self.layer addSublayer:dottedLayer2];
    self.dottedLayer2 = dottedLayer2;
}

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint previousLocation = [touch previousLocationInView:self];
    CGPoint location = [touch locationInView:self];
    CGPoint center = CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.height / 2.0);
    CGFloat previousRadian = [self radianToCenterPoint:center withPoint:previousLocation];
    CGFloat curRadian = [self radianToCenterPoint:center withPoint:location];
    CGFloat changedRadian = curRadian - previousRadian;
    NSLog(@"changedRadian=%f",changedRadian);
    [self rotateByRadian:changedRadian];
    [self sendActionsForControlEvents:UIControlEventValueChanged];
    return YES;
}

/**
 *  以ColorPanel的anchorPoint为坐标原点建立坐标系，计算坐标点|point|与坐标原点的连线距离x轴正方向的夹角
 *  @param centerPoint 坐标原点坐标
 *  @param point       某坐标点
 *
 *  @return 坐标点|point|与坐标原点的连线距离x轴正方向的夹角
 */
- (CGFloat)radianToCenterPoint:(CGPoint)centerPoint withPoint:(CGPoint)point {
    CGVector vector = CGVectorMake(point.x - centerPoint.x, point.y - centerPoint.y);
    return atan2f(vector.dy, vector.dx);
}

/**
 *  将图层旋转radian弧度
 *  @param radian 旋转的弧度
 */
- (void)rotateByRadian:(CGFloat)radian {
    CGAffineTransform transform = self.layer.affineTransform;
    transform = CGAffineTransformRotate(transform, radian);
    self.layer.affineTransform = transform;
    
    CGFloat rotationAngle = atan2(self.transform.b, self.transform.a);
    if (rotationAngle < 0) {
        rotationAngle = 2 * M_PI - fabs(rotationAngle);
    }
    !self.change ? :self.change(rotationAngle);
    NSLog(@"transform=%f",rotationAngle);
}


@end
