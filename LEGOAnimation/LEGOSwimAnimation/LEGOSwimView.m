

//
//  LEGOSwimView.m
//  LEGOAnimation
//
//  Created by 杨庆人 on 2019/11/29.
//  Copyright © 2019 杨庆人. All rights reserved.
//

#import "LEGOSwimView.h"

@interface LEGOSwimView ()
@property (nonatomic, assign) CGFloat currAccellerationX;
@property (nonatomic, assign) CGFloat currAccellerationY;
@property (nonatomic, assign) CGFloat currAccellerationZ;

@property (nonatomic, strong) UIImageView *swimView;
@property (nonatomic, assign) CGPoint currentPoint;

@property (nonatomic, assign) CGFloat ballXVelocity;
@property (nonatomic, assign) CGFloat ballYVelocity;
@property (nonatomic, assign) CGFloat imageWidth;
@property (nonatomic, assign) CGFloat imageHeight;
@property (nonatomic, assign) CGFloat currentAngle;

@property (nonatomic, assign) BOOL isRecord;

@end

@implementation LEGOSwimView

- (instancetype)init {
    if (self = [super init]) {
        [self setSwimView];
    }
    return self;
}

- (UIImageView *)swimView {
    if (!_swimView) {
        _swimView = [[UIImageView alloc] init];
        _swimView.layer.borderWidth = 1;
        _swimView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    }
    return _swimView;
}

- (void)setSwimView {
    [self addSubview:self.swimView];
    [self.swimView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(180, 250));
        make.center.mas_equalTo(self);
    }];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.layer.borderWidth = 1;
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
}

- (void)setCurrentPoint:(CGPoint)currentPoint {
    _currentPoint = currentPoint;
    CGRect rect = self.bounds;
    
    if (currentPoint.x <= self.imageWidth / 2 + CGRectGetMinX(rect)) {
        self.currentAngle = self.currentAngle / 1.1;
        self.ballXVelocity = - self.ballXVelocity / 2;
        _currentPoint.x = self.imageWidth / 2 + CGRectGetMinX(rect);
    }

    if (currentPoint.x >= CGRectGetMaxX(rect) - self.imageWidth / 2) {
        self.currentAngle = self.currentAngle / 1.1;
        self.ballXVelocity = - self.ballXVelocity / 2;
        _currentPoint.x = CGRectGetMaxX(rect) - self.imageWidth / 2;
    }
    
    if (currentPoint.y <= self.imageHeight / 2 + CGRectGetMinY(rect)) {
        self.currentAngle = self.currentAngle / 1.1;
        self.ballYVelocity = - self.ballYVelocity / 2;
        _currentPoint.y = self.imageHeight / 2 + CGRectGetMinY(rect);
    }

    if (currentPoint.y >= CGRectGetMaxY(rect) - self.imageHeight / 2) {
        self.currentAngle = self.currentAngle / 1.1;
        self.ballYVelocity = - self.ballYVelocity / 2;
        _currentPoint.y = CGRectGetMaxY(rect) - self.imageHeight / 2;
    }

    self.swimView.center = _currentPoint;
}

- (void)updateLocation {
    
    if (!self.isRecord) {
        self.currAccellerationX = self.accelleration.x;
        self.currAccellerationY = self.accelleration.y;
        self.currAccellerationZ = self.accelleration.z;
        self.currentPoint = self.swimView.center;
        self.isRecord = YES;
    }

    [self setupPreviewViewEffect];

    [self setupPreviewViewCurrentPoint];
}

- (void)setupPreviewViewEffect {
    
    CGFloat x = self.accelleration.x - self.currAccellerationX;
    CGFloat y = self.accelleration.y - self.currAccellerationY;
    CGFloat z = self.accelleration.z - self.currAccellerationZ;
    
    if (fabs(x) > fabs(y) && fabs(x) > fabs(z)) {
        self.currentAngle += x * 15;
    }
    else if (fabs(y) > fabs(x) && fabs(y) > fabs(z)) {
        self.currentAngle += y * 15;
    }
    else {
        self.currentAngle += z * 15;
    }

    [UIView animateWithDuration:(1 / 17.0) delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.swimView.transform = CGAffineTransformRotate(CGAffineTransformIdentity, M_PI / 180.0 * self.currentAngle);
    } completion:nil];
    
    self.currAccellerationX = self.accelleration.x;
    self.currAccellerationY = self.accelleration.y;
    self.currAccellerationZ = self.accelleration.z;
}

static NSDate *lastUpdateTime = nil;

- (void)setupPreviewViewCurrentPoint {
    if (lastUpdateTime) {
        NSTimeInterval updatePeriod = [[NSDate date] timeIntervalSinceDate:lastUpdateTime];
        self.ballXVelocity = self.ballXVelocity + (self.accelleration.x * updatePeriod);
        self.ballYVelocity = self.ballYVelocity + (self.accelleration.y * updatePeriod);
        if (self.ballXVelocity > 0.1) {
            self.ballXVelocity = 0.1;
        }
        if (self.ballXVelocity < -0.1) {
            self.ballXVelocity = -0.1;
        }
        if (self.ballYVelocity > 0.1) {
            self.ballYVelocity = 0.1;
        }
        if (self.ballYVelocity < -0.1) {
            self.ballYVelocity = -0.1;
        }
        self.currentPoint = CGPointMake(self.currentPoint.x + self.ballXVelocity * updatePeriod * 1000, self.currentPoint.y + -self.ballYVelocity * updatePeriod * 1000);
    }
    lastUpdateTime = [NSDate date];
}

- (void)dealloc {
    lastUpdateTime = nil;
}

- (CGFloat)imageWidth{
    return self.swimView.frame.size.width;
}

- (CGFloat)imageHeight{
    return self.swimView.frame.size.height;
}

@end
