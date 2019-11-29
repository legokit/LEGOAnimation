//
//  LEGOTransformViewController.m
//  LEGOAnimation
//
//  Created by 杨庆人 on 2019/8/20.
//  Copyright © 2019年 杨庆人. All rights reserved.
//

#import "LEGOTransformViewController.h"

@interface LEGOTransformViewController ()
@property (nonatomic, strong) UIView *transformView;
@property (nonatomic, strong) UIButton *bounesButton;

@end

@implementation LEGOTransformViewController

- (UIView *)transformView {
    if (!_transformView) {
        _transformView = [[UIView alloc] init];
        _transformView.layer.borderWidth = 1;
    }
    return _transformView;
}

- (UIButton *)bounesButton {
    if (!_bounesButton) {
        _bounesButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_bounesButton setTitle:@"3D 旋转" forState:UIControlStateNormal];
        [_bounesButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_bounesButton addTarget:self action:@selector(bounesButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bounesButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.transformView];
    [self.transformView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 400));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(self.view.mas_centerY).offset(-75);
    }];
    
    [self.view addSubview:self.bounesButton];
    [self.bounesButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.transformView.mas_bottom).offset(75);
    }];
    
    // Do any additional setup after loading the view.
}

- (void)bounesButtonClick:(id)sender {
    CATransform3D perspectiveTransform = [self getPerspectiveTransform];
    CASpringAnimation *springAnimation = [CASpringAnimation animationWithKeyPath:@"transform"];
    springAnimation.toValue = [NSValue valueWithCATransform3D:perspectiveTransform];
    springAnimation.duration = 1;
    springAnimation.removedOnCompletion = NO;
    springAnimation.fillMode = kCAFillModeForwards;
    springAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.transformView.layer addAnimation:springAnimation forKey:@"springAnimation"];
}

- (CATransform3D)getPerspectiveTransform {
    
    // 初始化3D变换,获取默认值
    CATransform3D perspectiveTransform = CATransform3DIdentity;
    
    // 透视
    perspectiveTransform.m34 = -1.0/500.0;
    
    // 位移
    perspectiveTransform = CATransform3DTranslate(perspectiveTransform, 0, 0, 0);
    
    // 空间旋转
    perspectiveTransform = CATransform3DRotate(perspectiveTransform, 180 / 180.0 * M_PI, 0, 1, 0);
    
    // 缩放变换
//    perspectiveTransform = CATransform3DScale(perspectiveTransform, 0.75, 0.75, 0.75);
    
//    self.transformView.layer.transform              = perspectiveTransform;
//    self.transformView.layer.allowsEdgeAntialiasing = YES; // 抗锯齿
//    self.transformView.layer.speed                  = 0.5;
    
    return perspectiveTransform;
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
