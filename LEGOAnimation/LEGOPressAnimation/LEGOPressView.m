//
//  LEGOPressView.m
//  LEGOAnimation
//
//  Created by 杨庆人 on 2019/11/29.
//  Copyright © 2019 杨庆人. All rights reserved.
//

#import "LEGOPressView.h"

@interface LEGOPressView ()
@property (nonatomic, strong) UIImageView *bgView;
@property (nonatomic, strong) UIImageView *pressView;

@property (nonatomic, assign) CGPoint startLocation;
@property (nonatomic, assign) CGFloat currAngle;


@end

@implementation LEGOPressView

- (instancetype)init {
    if (self = [super init] ) {
        [self setKnobView];
    }
    return self;
}

- (UIImageView *)bgView {
    if (!_bgView) {
        _bgView = [[UIImageView alloc] init];
        _bgView.layer.borderWidth = 1;
    }
    return _bgView;
}

- (UIImageView *)pressView {
    if (!_pressView) {
        _pressView = [[UIImageView alloc] init];
        _pressView.layer.borderWidth = 1;
    }
    return _pressView;
}

- (void)setKnobView {
    [self addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    [self addSubview:self.pressView];
    [self.pressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(25, 25, 25, 25));
    }];
     
    UIView *lineH = [[UIView alloc] init];
    lineH.backgroundColor = [UIColor blackColor];
    [self.pressView addSubview:lineH];
    [lineH mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(45);
        make.height.mas_equalTo(1);
        make.center.mas_equalTo(self.pressView);
    }];
    
    UIView *lineV = [[UIView alloc] init];
    lineV.backgroundColor = [UIColor blackColor];
    [self.pressView addSubview:lineV];
    [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(45);
        make.center.mas_equalTo(self.pressView);
    }];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.bgView.layer.cornerRadius = self.bounds.size.width / 2.0;
    self.pressView.layer.cornerRadius = (self.bounds.size.width - 25 * 2) / 2.0;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    self.startLocation = [touch locationInView:self];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    if (CGPointEqualToPoint(self.startLocation, CGPointZero) ) {
        return;
    }
    UITouch *touch = [touches anyObject];

    CGPoint moveLocation = [touch locationInView:self];
    
    CGFloat Angle = [self getAnglesWithThreePoint:self.startLocation pointB:CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.height / 2.0) pointC:moveLocation];
    NSLog(@"startLocation=%@,moveLocation=%@",[NSValue valueWithCGPoint:self.startLocation],[NSValue valueWithCGPoint:moveLocation]);
    self.startLocation = moveLocation;
    self.currAngle += Angle;
    if (self.currAngle > M_PI * 2) {
        self.currAngle = self.currAngle - M_PI * 2;
    }
    else if (self.currAngle < -M_PI * 2) {
        self.currAngle = self.currAngle + M_PI * 2;
    }
    NSLog(@"self.currAngle=%f",self.currAngle);
//    self.knobView.transform = CGAffineTransformRotate(self.knobView.transform, Angle);
    self.pressView.transform = CGAffineTransformRotate(CGAffineTransformIdentity, self.currAngle);

    CGFloat xFactor = MIN(1, MAX(-1, (moveLocation.x - (self.bounds.size.width / 2.0)) / (self.bounds.size.width / 2.0)));
    CGFloat yFactor = MIN(1, MAX(-1, (moveLocation.y - (self.bounds.size.height / 2.0)) / (self.bounds.size.height / 2.0)));
    CATransform3D t = CATransform3DIdentity;
    t.m34 = -1.0f / 500;
    t = CATransform3DRotate(t, M_PI / 9 * yFactor, -1, 0, 0);
    t = CATransform3DRotate(t, M_PI / 9 * xFactor, 0, 1, 0);
    self.layer.transform = t;
}

-(CGFloat)getAnglesWithThreePoint:(CGPoint)pointA pointB:(CGPoint)pointB pointC:(CGPoint)pointC {
    CGFloat x1 = pointA.x - pointB.x;
    CGFloat y1 = pointA.y - pointB.y;
    CGFloat x2 = pointC.x - pointB.x;
    CGFloat y2 = pointC.y - pointB.y;
    
    CGFloat x = x1 * x2 + y1 * y2;
    CGFloat y = x1 * y2 - x2 * y1;
    
    CGFloat angle = acos(x/sqrt(x*x+y*y));
    
    if (x*y < 0) {
        angle = -angle;
    }else{
        
    }
    
    return angle;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    self.startLocation = CGPointZero;
    [UIView animateWithDuration:0.25 animations:^{
        CATransform3D t = CATransform3DIdentity;
        t.m34 = -1.0f / 500;
        t = CATransform3DRotate(t, M_PI / 9 * 0, -1, 0, 0);
        t = CATransform3DRotate(t, M_PI / 9 * 0, 0, 1, 0);
        self.layer.transform = t;
    }];
}

@end

