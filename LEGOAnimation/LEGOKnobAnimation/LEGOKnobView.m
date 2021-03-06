


//
//  LEGOKnobView.m
//  LEGOAnimation
//
//  Created by 杨庆人 on 2019/8/14.
//  Copyright © 2019年 杨庆人. All rights reserved.
//

#import "LEGOKnobView.h"
#import "LEGOHighlightButton.h"

@interface LEGOKnobView ()
@property (nonatomic, strong) UIImageView *bgView;
@property (nonatomic, strong) UIImageView *knobView;

@property (nonatomic, assign) CGPoint startLocation;
@property (nonatomic, assign) CGFloat currAngle;

@property (nonatomic, strong) LEGOHighlightButton *hotspotButton;


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
        _knobView.layer.borderWidth = 1;
    }
    return _knobView;
}

- (LEGOHighlightButton *)hotspotButton {
    if (!_hotspotButton) {
        _hotspotButton = [LEGOHighlightButton buttonWithType:UIButtonTypeCustom];
        _hotspotButton.backgroundColor = [UIColor lightGrayColor];
    }
    return _hotspotButton;
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
    
    [self.knobView addSubview:self.hotspotButton];
    [self.hotspotButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(25, 25));
        make.bottom.mas_equalTo(self.knobView.mas_top);
        make.centerX.mas_equalTo(self.knobView.mas_centerX);
    }];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.bgView.layer.cornerRadius = self.bounds.size.width / 2.0;
    self.knobView.layer.cornerRadius = (self.bounds.size.width - 25 * 2) / 2.0;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.knobView];
    if (CGRectContainsPoint(self.hotspotButton.frame, point)) {
        [self.hotspotButton sendActionsForControlEvents:UIControlEventTouchDown];
        self.startLocation = [touch locationInView:self];
    }

}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    if (CGPointEqualToPoint(self.startLocation, CGPointZero) ) {
        return;
    }
    UITouch *touch = [touches anyObject];

    CGPoint moveLocation = [touch locationInView:self];
    
    CGFloat Angle = [self getAnglesWithThreePoint:self.startLocation pointB:CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.height / 2.0) pointC:moveLocation];

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
    self.knobView.transform = CGAffineTransformRotate(CGAffineTransformIdentity, self.currAngle);
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
    [self.hotspotButton sendActionsForControlEvents:UIControlEventTouchCancel];
    self.startLocation = CGPointZero;
    [UIView animateWithDuration:0.25 animations:^{
        CATransform3D t = CATransform3DIdentity;
        t.m34 = -1.0f / 500;
        t = CATransform3DRotate(t, M_PI / 9 * 0, -1, 0, 0);
        t = CATransform3DRotate(t, M_PI / 9 * 0, 0, 1, 0);
        self.layer.transform = t;
    }];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    CGPoint knobViewPoint = [self.knobView.layer convertPoint:point fromLayer:self.layer];
    CGRect rect = self.hotspotButton.frame;
    if (CGRectContainsPoint(rect, knobViewPoint)) {
        return [super hitTest:point withEvent:event];
    }
    return nil;
}


@end
