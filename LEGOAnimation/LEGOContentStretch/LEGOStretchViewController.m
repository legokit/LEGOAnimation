


//
//  LEGOStretchViewController.m
//  LEGOAnimation
//
//  Created by 杨庆人 on 2019/8/6.
//  Copyright © 2019年 杨庆人. All rights reserved.
//

#import "LEGOStretchViewController.h"

@interface LEGOStretchViewController ()
@property (nonatomic, strong) UIView *stretchView;
@property (nonatomic, strong) UIButton *stretchButton;

@property (nonatomic, strong) UILabel *leftLabel;
@property (nonatomic, strong) UILabel *rightLabel;
@property (nonatomic, strong) UIButton *anchorButton;
@property (nonatomic, assign) BOOL isReverse;

@property (nonatomic, strong) UIButton *shapeButton;
@property (nonatomic, strong) CAShapeLayer *backProgress;
@property (nonatomic, strong) CAShapeLayer *progressLayer;
@property (nonatomic, strong) UIButton *patternButton;

@end

@implementation LEGOStretchViewController

- (UIView *)stretchView {
    if (!_stretchView) {
        _stretchView = [[UIView alloc] init];
        _stretchView.backgroundColor = [UIColor greenColor];
        _stretchView.layer.cornerRadius = 75 / 2.0;
        _stretchView.layer.masksToBounds = YES;
    }
    return _stretchView;
}

- (UIButton *)stretchButton {
    if (!_stretchButton) {
        _stretchButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_stretchButton setTitle:@"挤压" forState:UIControlStateNormal];
        [_stretchButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_stretchButton addTarget:self action:@selector(stretchButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _stretchButton;
}

- (UILabel *)leftLabel {
    if (!_leftLabel) {
        _leftLabel = [[UILabel alloc] init];
        _leftLabel.text = @"leading";
        _leftLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightBlack];
    }
    return _leftLabel;
}

- (UILabel *)rightLabel {
    if (!_rightLabel) {
        _rightLabel = [[UILabel alloc] init];
        _rightLabel.text = @"trailing";
        _rightLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightBlack];
    }
    return _rightLabel;
}

- (UIButton *)anchorButton {
    if (!_anchorButton) {
        _anchorButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_anchorButton setTitle:@"拉扯" forState:UIControlStateNormal];
        [_anchorButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_anchorButton addTarget:self action:@selector(anchorButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _anchorButton;
}

- (UIButton *)shapeButton {
    if (!_shapeButton) {
        _shapeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _shapeButton.layer.cornerRadius = 50 / 2.0;
        _shapeButton.layer.masksToBounds = YES;
        _shapeButton.layer.borderWidth = 1;
        _shapeButton.layer.borderColor = [UIColor grayColor].CGColor;
        _shapeButton.backgroundColor = [UIColor greenColor];
        [_shapeButton addTarget:self action:@selector(shapeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shapeButton;
}

- (UIButton *)patternButton {
    if (!_patternButton) {
        _patternButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_patternButton setTitle:@"形变" forState:UIControlStateNormal];
        [_patternButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_patternButton addTarget:self action:@selector(shapeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _patternButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    [self.view addSubview:self.stretchView];
    [self.stretchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(100);
        make.size.mas_equalTo(CGSizeMake(75, 75));
        make.left.offset(50);
    }];
    [self.view addSubview:self.stretchButton];
    [self.stretchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-50);
        make.centerY.mas_equalTo(self.stretchView.mas_centerY);
    }];
    
    [self.view addSubview:self.leftLabel];
    [self.view addSubview:self.rightLabel];
    [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.stretchView.mas_bottom).offset(100);
        make.left.offset(50);
    }];
    [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.stretchView.mas_bottom).offset(100);
        make.left.mas_equalTo(self.leftLabel.mas_right).offset(50);
    }];
    
    [self.view addSubview:self.anchorButton];
    [self.anchorButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-50);
        make.centerY.mas_equalTo(self.rightLabel.mas_centerY);
    }];
    
    [self.view addSubview:self.shapeButton];
    [self.shapeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(50);
        make.top.mas_equalTo(self.leftLabel.mas_bottom).offset(100);
        make.size.mas_equalTo(CGSizeMake(100, 50));
    }];
    [self.view addSubview:self.patternButton];
    [self.patternButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-50);
        make.centerY.mas_equalTo(self.shapeButton.mas_centerY);
    }];
    
    // Do any additional setup after loading the view.
}

- (void)shapeButtonClick:(id)sender {
    CABasicAnimation *anima = [CABasicAnimation animation];
    anima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    anima.duration = 0.5;
    anima.keyPath = @"bounds";
    anima.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, self.shapeButton.bounds.size.height, self.shapeButton.bounds.size.height)];
    anima.removedOnCompletion = NO;
    anima.fillMode = kCAFillModeForwards;
    [self.shapeButton.layer addAnimation:anima forKey:@"zoomAnimation"];
    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.shapeButton.backgroundColor = [UIColor whiteColor];
    } completion:^(BOOL finished) {
        [self drawProgressLayer];
    }];
}

-(void)drawProgressLayer {
    //1. 背景环
    CAShapeLayer *backProgressLayer = [CAShapeLayer layer];
    backProgressLayer.strokeColor = [UIColor grayColor].CGColor;
    backProgressLayer.fillColor = [UIColor whiteColor].CGColor;
    backProgressLayer.lineCap   = kCALineCapRound;
    backProgressLayer.lineJoin  = kCALineJoinBevel;
    backProgressLayer.lineWidth = 2;

    UIBezierPath *backProgressCircle = [UIBezierPath bezierPath];
    [backProgressCircle addArcWithCenter:self.shapeButton.center radius:self.shapeButton.bounds.size.height / 2.0 startAngle:-M_PI_2 endAngle:M_PI_2 * 3 clockwise:YES];
    backProgressLayer.path = backProgressCircle.CGPath;
    [self.view.layer addSublayer:backProgressLayer];
    self.backProgress = backProgressLayer;
    
    //2. 圆环
    CAShapeLayer *progressLayer = [CAShapeLayer layer];
    progressLayer.strokeColor = [UIColor greenColor].CGColor;
    progressLayer.fillColor = [UIColor whiteColor].CGColor;
    progressLayer.lineCap   = kCALineCapRound;
    progressLayer.lineJoin  = kCALineJoinBevel;
    progressLayer.lineWidth = 4.0;
    progressLayer.strokeEnd = 0.0;
    
    UIBezierPath *progressCircle = [UIBezierPath bezierPath];
    [progressCircle addArcWithCenter:self.shapeButton.center radius:self.shapeButton.bounds.size.height / 2.0 startAngle:-M_PI_2 endAngle:M_PI_2 * 3 clockwise:YES];
    progressLayer.path = progressCircle.CGPath;
    [self.view.layer addSublayer:progressLayer];
    self.progressLayer = progressLayer;
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 0.5;
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    pathAnimation.removedOnCompletion = NO;
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.delegate = (id <CAAnimationDelegate>)self;
    [pathAnimation setValue:@"pathAnimation" forKey:@"name"];
    [progressLayer addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
}

- (void)anchorButtonClick:(id)sender {
    [self setAnchorPointTo:self.leftLabel andPoint:CGPointMake(0, 0.9)];
    [self setAnchorPointTo:self.rightLabel andPoint:CGPointMake(1, 0.9)];
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        if (!self.isReverse) {
            self.leftLabel.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.7, 1.4);
            self.rightLabel.transform = CGAffineTransformIdentity;
            self.isReverse = YES;
        }
        else {
            self.leftLabel.transform = CGAffineTransformIdentity;
            self.rightLabel.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.7, 1.4);
            self.isReverse = NO;
        }
    } completion:^(BOOL finished) {
        if (finished) {
            [self anchorButtonClick:nil];
        }
    }];
}

- (void)setAnchorPointTo:(UIView *)view andPoint:(CGPoint)point {
    //    view.frame = CGRectOffset(view.frame, (point.x - view.layer.anchorPoint.x) * view.frame.size.width, (point.y - view.layer.anchorPoint.y) * view.frame.size.height);
    //    view.layer.anchorPoint = point;
    CGRect oldFrame = view.frame;
    view.layer.anchorPoint = point;
    view.frame = oldFrame;
}

- (void)stretchButtonClick:(id)sender {
    [self animationWillxFromScale:1.0 xToScale:1.5 yFromScale:1.0 yToScale:0.5 name:@"startAnimation"];
}

- (void)animationWillxFromScale:(CGFloat)xFromScale xToScale:(CGFloat)xToScale yFromScale:(CGFloat)yFromScale yToScale:(CGFloat)yToScale name:(NSString *)name {
    self.stretchView.layer.transform = CATransform3DMakeScale(xToScale, yToScale, 1);
    CABasicAnimation *yAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale.y"];
    yAnimation.fromValue = @(yFromScale);
    yAnimation.toValue = @(yToScale);
    
    CABasicAnimation *xAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale.x"];
    xAnimation.fromValue = @(xFromScale);
    xAnimation.toValue = @(xToScale);
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = @[yAnimation, xAnimation];
    animationGroup.duration = 1.5;
    animationGroup.delegate = (id <CAAnimationDelegate>)self;
    [animationGroup setValue:name forKey:@"name"];
    [self.stretchView.layer addAnimation:animationGroup forKey:@"animationGroup"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if ([[anim valueForKey:@"name"] isEqualToString:@"startAnimation"]) {
        [self animationWillxFromScale:1.5 xToScale:1 yFromScale:0.5 yToScale:1 name:@"endAnimation"];
    }
    else if ([[anim valueForKey:@"name"] isEqualToString:@"pathAnimation"]) {
        [self.backProgress removeFromSuperlayer];
        [self.progressLayer removeFromSuperlayer];
        CABasicAnimation *anima = [CABasicAnimation animation];
        anima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        anima.duration = 1;
        anima.keyPath = @"bounds";
        anima.fromValue = [NSValue valueWithCGRect:CGRectMake(0, 0, self.shapeButton.bounds.size.height, self.shapeButton.bounds.size.height)];
        anima.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, 100, self.shapeButton.bounds.size.height)];
        anima.removedOnCompletion = NO;
        anima.fillMode = kCAFillModeForwards;
        [self.shapeButton.layer addAnimation:anima forKey:@"zoomAnimation"];
        [UIView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.shapeButton.backgroundColor = [UIColor greenColor];
        } completion:nil];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
