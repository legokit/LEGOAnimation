//
//  LEGOBaseViewController.m
//  LEGOAnimation
//
//  Created by 杨庆人 on 2019/8/6.
//  Copyright © 2019年 杨庆人. All rights reserved.
//

#import "LEGOBaseViewController.h"

@interface LEGOBaseViewController ()
@property (nonatomic, strong) UIView *zoomView;
@property (nonatomic, strong) UIView *rotationView;
@property (nonatomic, strong) UIView *gradualView;

@property (nonatomic, strong) UIButton *zoomButton;
@property (nonatomic, strong) UIButton *rotationButton;
@property (nonatomic, strong) UIButton *gradualButton;

@end

@implementation LEGOBaseViewController

- (UIView *)zoomView {
    if (!_zoomView) {
        _zoomView = [[UIView alloc] init];
        _zoomView.backgroundColor = [UIColor blueColor];
    }
    return _zoomView;
}

- (UIView *)rotationView {
    if (!_rotationView) {
        _rotationView = [[UIView alloc] init];
        _rotationView.backgroundColor = [UIColor orangeColor];
    }
    return _rotationView;
}

- (UIView *)gradualView {
    if (!_gradualView) {
        _gradualView = [[UIView alloc] init];
        _gradualView.backgroundColor = [UIColor redColor];
    }
    return _gradualView;
}

- (UIButton *)zoomButton {
    if (!_zoomButton) {
        _zoomButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_zoomButton setTitle:@"缩放" forState:UIControlStateNormal];
        [_zoomButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_zoomButton addTarget:self action:@selector(zoomButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _zoomButton;
}

- (UIButton *)rotationButton {
    if (!_rotationButton) {
        _rotationButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rotationButton setTitle:@"旋转" forState:UIControlStateNormal];
        [_rotationButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_rotationButton addTarget:self action:@selector(rotationButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rotationButton;
}

- (UIButton *)gradualButton {
    if (!_gradualButton) {
        _gradualButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_gradualButton setTitle:@"渐变" forState:UIControlStateNormal];
        [_gradualButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_gradualButton addTarget:self action:@selector(gradualButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _gradualButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.zoomView];
    [self.view addSubview:self.rotationView];
    [self.view addSubview:self.gradualView];
    
    NSArray *array = @[self.zoomView, self.rotationView, self.gradualView];
    [array mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedItemLength:100 leadSpacing:100 tailSpacing:100];
    [array mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(100);
        make.left.offset(50);
    }];
    
    [self.view addSubview:self.zoomButton];
    [self.view addSubview:self.rotationButton];
    [self.view addSubview:self.gradualButton];
    
    [self.zoomButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-50);
        make.centerY.mas_equalTo(self.zoomView.mas_centerY);
    }];
    [self.rotationButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-50);
        make.centerY.mas_equalTo(self.rotationView.mas_centerY);
    }];
    [self.gradualButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-50);
        make.centerY.mas_equalTo(self.gradualView.mas_centerY);
    }];
    
    // Do any additional setup after loading the view.
}

-(void)zoomButtonClick:(id)sender {
//    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
//    animation.toValue = [NSNumber numberWithFloat:0.75f];
//    animation.duration = 1.0f;
//    animation.removedOnCompletion = NO;
//    animation.fillMode = kCAFillModeForwards;
//    [self.zoomView.layer addAnimation:animation forKey:@"scaleAnimation"];

    [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [self.zoomView.layer setValue:@(0.8) forKeyPath:@"transform.scale"];
    } completion:^(BOOL finished) {
        if (finished) {
            [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                [self.zoomView.layer setValue:@(1) forKeyPath:@"transform.scale"];
            } completion:nil];
        }
    }];
}

-(void)rotationButtonClick:(id)sender {
//        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
//        animation.toValue = [NSNumber numberWithFloat:M_PI];
//        animation.duration = 1.0f;
//        [self.rotationView.layer addAnimation:animation forKey:@"rotateAnimation"];
    
    [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [self.rotationView.layer setValue:@(M_PI) forKeyPath:@"transform.rotation.z"];
    } completion:^(BOOL finished) {
        if (finished) {
            [self.rotationView.layer setValue:@(0) forKeyPath:@"transform.rotation.z"];
        }
    }];
}

-(void)gradualButtonClick:(id)sender {
    //    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    //    animation.toValue = (id)[UIColor greenColor].CGColor;
    //    animation.duration = 1.0f;
    //    [self.gradualView.layer addAnimation:animation forKey:@"gradualAnimation"];
    
    [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [self.gradualView.layer setValue:(id)[UIColor greenColor].CGColor forKeyPath:@"backgroundColor"];
    } completion:^(BOOL finished) {
        if (finished) {
            [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                [self.gradualView.layer setValue:(id)[UIColor redColor].CGColor forKeyPath:@"backgroundColor"];
            } completion:nil];
        }
    }];
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
