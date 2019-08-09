



//
//  LEGOSimuationViewController.m
//  LEGOAnimation
//
//  Created by 杨庆人 on 2019/8/9.
//  Copyright © 2019年 杨庆人. All rights reserved.
//

#import "LEGOSimuationViewController.h"

@interface LEGOSimuationViewController ()
@property (nonatomic, strong) UIView *simuationView;
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIView *sideView;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIButton *turnButton;
@end

@implementation LEGOSimuationViewController

- (UIView *)simuationView {
    if (!_simuationView) {
        _simuationView = [[UIView alloc] init];
    }
    return _simuationView;
}

- (UIView *)topView {
    if (!_topView) {
        _topView = [[UIView alloc] init];
        _topView.backgroundColor = [UIColor redColor];
    }
    return _topView;
}

- (UIView *)sideView {
    if (!_sideView) {
        _sideView = [[UIView alloc] init];
        _sideView.backgroundColor = [UIColor blueColor];
    }
    return _sideView;
}

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = [UIColor yellowColor];
    }
    return _bottomView;
}

- (UIButton *)turnButton {
    if (!_turnButton) {
        _turnButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_turnButton setTitle:@"翻转" forState:UIControlStateNormal];
        [_turnButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_turnButton addTarget:self action:@selector(turnButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _turnButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.simuationView];
    [self.simuationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 100));
        make.top.offset(100);
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    
    [self.simuationView addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.simuationView);
    }];
    [self.simuationView addSubview:self.sideView];
    [self.sideView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.height.mas_equalTo(50);
        make.centerY.mas_equalTo(self.simuationView.mas_centerY);
    }];
    [self.simuationView addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.simuationView);
    }];
    
    [self.view addSubview:self.turnButton];
    [self.turnButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(100 + 100 + 100 / 2.0 + 50);   // top、height、AnchorPoint、offset
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    
    [self.view layoutIfNeeded];
    
    CATransform3D t1 = CATransform3DIdentity;
    t1 = CATransform3DTranslate(t1, 0, 0, -50 / 2.0);
    t1 = CATransform3DRotate(t1, -M_PI_2, 1, 0, 0);
    t1 = CATransform3DTranslate(t1, 0, 0, 50);
    self.sideView.layer.transform = t1;
    
    CATransform3D t2 = CATransform3DIdentity;
    t2 = CATransform3DTranslate(t2, 0, 0, -50);
    t2 = CATransform3DRotate(t2, -M_PI, 1, 0, 0);
    self.bottomView.layer.transform = t2;

    CGPoint point = CGPointMake(0.5, 0.0);
    [self.class setAnchorPointTo:self.simuationView point:point];
    
    // Do any additional setup after loading the view.
}

- (void)turnButtonClick:(id)sender {
    CATransform3D t = CATransform3DIdentity;
    t.m34 = -1.0f / 500;   // 远小近大效果
    t = CATransform3DRotate(t, M_PI_2, 1, 0, 0);
    CASpringAnimation * springAnimation = [CASpringAnimation animationWithKeyPath:@"sublayerTransform"];
    springAnimation.toValue = [NSValue valueWithCATransform3D:t];
    springAnimation.duration = 8;
    springAnimation.removedOnCompletion = NO;
    springAnimation.fillMode = kCAFillModeForwards;
    springAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.simuationView.layer addAnimation:springAnimation forKey:@"springAnimation"];
}

+ (void)setAnchorPointTo:(UIView *)view point:(CGPoint)point {
//        view.frame = CGRectOffset(view.frame, (point.x - view.layer.anchorPoint.x) * view.frame.size.width, (point.y - view.layer.anchorPoint.y) * view.frame.size.height);
//        view.layer.anchorPoint = point;
    CGRect oldFrame = view.frame;
    view.layer.anchorPoint = point;
    view.frame = oldFrame;
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
