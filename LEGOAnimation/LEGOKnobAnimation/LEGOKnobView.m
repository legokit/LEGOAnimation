


//
//  LEGOKnobView.m
//  LEGOAnimation
//
//  Created by 杨庆人 on 2019/8/14.
//  Copyright © 2019年 杨庆人. All rights reserved.
//

#import "LEGOKnobView.h"
@interface LEGOKnobView ()
@property (nonatomic, strong) UIImageView *bgView;
@property (nonatomic, strong) UIImageView *knobView;

@property (nonatomic, assign) CGPoint startLocation;

@end

@implementation LEGOKnobView

- (instancetype)init {
    if (self = [super init] ) {
        [self setKnobView];
    }
    return self;
}

- (UIImageView *)bgView {
    if (!_bgView) {
        _bgView = [[UIImageView alloc] init];
//        _bgView.backgroundColor = [UIColor blackColor];
        _bgView.layer.borderWidth = 1;
    }
    return _bgView;
}

- (UIImageView *)knobView {
    if (!_knobView) {
        _knobView = [[UIImageView alloc] init];
        _knobView.image = [UIImage imageNamed:@"knob_pointer"];
//        _knobView.backgroundColor = [UIColor yellowColor];
        _knobView.layer.borderWidth = 1;
    }
    return _knobView;
}

- (void)setKnobView {
    [self addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    [self addSubview:self.knobView];
    [self.knobView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(25, 25, 25, 25));
    }];
     
    UIView *lineH = [[UIView alloc] init];
    lineH.backgroundColor = [UIColor blackColor];
    [self.knobView addSubview:lineH];
    [lineH mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(45);
        make.height.mas_equalTo(1);
        make.center.mas_equalTo(self.knobView);
    }];
    
    UIView *lineV = [[UIView alloc] init];
    lineV.backgroundColor = [UIColor blackColor];
    [self.knobView addSubview:lineV];
    [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(45);
        make.center.mas_equalTo(self.knobView);
    }];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.bgView.layer.cornerRadius = self.bounds.size.width / 2.0;
    self.bgView.layer.masksToBounds = YES;
    self.knobView.layer.cornerRadius = (self.bounds.size.width - 25 * 2) / 2.0;
    self.knobView.layer.masksToBounds = YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    self.startLocation = [touch locationInView:self];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint moveLocation = [touch locationInView:self];
    CGFloat Angle = [self getAnglesWithThreePoint:self.startLocation pointB:CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.height / 2.0) pointC:moveLocation];
    NSLog(@"angle=%f",Angle);
    NSLog(@"startLocation=%@,moveLocation=%@",[NSValue valueWithCGPoint:self.startLocation],[NSValue valueWithCGPoint:moveLocation]);
    self.knobView.transform = CGAffineTransformRotate(self.knobView.transform, Angle);
    self.startLocation = moveLocation;
    
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
    [UIView animateWithDuration:0.25 animations:^{
        CATransform3D t = CATransform3DIdentity;
        t.m34 = -1.0f / 500;
        t = CATransform3DRotate(t, M_PI / 9 * 0, -1, 0, 0);
        t = CATransform3DRotate(t, M_PI / 9 * 0, 0, 1, 0);
        self.layer.transform = t;
    }];
}

@end
