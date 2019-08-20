//
//  LEGOKeyFrameViewController.m
//  LEGOAnimation
//
//  Created by 杨庆人 on 2019/8/6.
//  Copyright © 2019年 杨庆人. All rights reserved.
//

#import "LEGOCAKeyframeViewController.h"

@interface LEGOCAKeyframeViewController ()
@property (nonatomic, strong) UIView *keyFrameView;
@property (nonatomic, strong) UIButton *keyFrameButton;
@property (nonatomic, strong) UIButton *pathButton;
@property (nonatomic, strong) UIButton *shakeButton;
@end

@implementation LEGOCAKeyframeViewController

- (UIView *)keyFrameView {
    if (!_keyFrameView) {
        _keyFrameView = [[UIView alloc] init];
        _keyFrameView.layer.borderWidth = 1;
    }
    return _keyFrameView;
}

- (UIButton *)keyFrameButton {
    if (!_keyFrameButton) {
        _keyFrameButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_keyFrameButton setTitle:@"关键帧" forState:UIControlStateNormal];
        [_keyFrameButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_keyFrameButton addTarget:self action:@selector(keyFrameButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _keyFrameButton;
}

- (UIButton *)pathButton {
    if (!_pathButton) {
        _pathButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_pathButton setTitle:@"路径" forState:UIControlStateNormal];
        [_pathButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_pathButton addTarget:self action:@selector(pathButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _pathButton;
}

- (UIButton *)shakeButton {
    if (!_shakeButton) {
        _shakeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shakeButton setTitle:@"抖动" forState:UIControlStateNormal];
        [_shakeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_shakeButton addTarget:self action:@selector(shakeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shakeButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.keyFrameView];
    [self.keyFrameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 100));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(self.view.mas_centerY).offset(-75);
    }];
    
    [self.view addSubview:self.keyFrameButton];
    [self.view addSubview:self.pathButton];
    [self.view addSubview:self.shakeButton];
    
    NSArray *array = @[self.keyFrameButton,self.pathButton,self.shakeButton];
    
    [array mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:80 leadSpacing:15 tailSpacing:15];
    [array mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(-175);
        make.height.mas_equalTo(80);
    }];
    
    // Do any additional setup after loading the view.
}

- (void)keyFrameButtonClick:(id)sender {
    [self.keyFrameView.layer removeAllAnimations];

    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGPoint center = self.keyFrameView.center;
    CGPoint point1 = center;
    CGPoint point2 = CGPointMake(point1.x - 100, point1.y);
    CGPoint point3 = CGPointMake(point2.x, point2.y - 100);
    CGPoint point4 = CGPointMake(point1.x, point3.y);
    CGPoint point5 = center;
    
    animation.values = @[[NSValue valueWithCGPoint:point1],
                          [NSValue valueWithCGPoint:point2],
                          [NSValue valueWithCGPoint:point3],
                          [NSValue valueWithCGPoint:point4],
                          [NSValue valueWithCGPoint:point5]
                          ];
    // 设定每个关键帧的时长，如果没有显式地设置，则默认每个帧的时间 = 总duration / (values.count - 1)
    animation.keyTimes = @[@0.0, @0.25, @0.5, @0.75, @1.0];
    animation.repeatCount = 1;
    //  annimation.autoreverses = NO;
    animation.duration = 2.0f;
    [self.keyFrameView.layer addAnimation:animation forKey:@"rectRunAnimation"];
}

- (void)pathButtonClick:(id)sender {
    [self.keyFrameView.layer removeAllAnimations];
    CGPoint center = self.keyFrameView.center;
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(center.x - 60, center.y) radius:60 startAngle:0.0f endAngle:M_PI *2 clockwise:YES];
    animation.duration = 2.0f;
    animation.path = path.CGPath;
    animation.repeatCount = 1;
    [self.keyFrameView.layer addAnimation:animation forKey:@"pathAnimation"];
}

- (void)shakeButtonClick:(id)sender {
    [self.keyFrameView.layer removeAllAnimations];
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
    NSValue *value1 = [NSNumber numberWithFloat:-M_PI /180 *4];
    NSValue *value2 = [NSNumber numberWithFloat:M_PI /180 *4];
    NSValue *value3 = [NSNumber numberWithFloat:-M_PI /180 *4];
    animation.values = @[value1,value2,value3];
    animation.repeatCount = MAXFLOAT;
    [self.keyFrameView.layer addAnimation:animation forKey:@"shakeAnimation"];
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
