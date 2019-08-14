



//
//  LEGOSimuationViewController.m
//  LEGOAnimation
//
//  Created by 杨庆人 on 2019/8/9.
//  Copyright © 2019年 杨庆人. All rights reserved.
//

#import "LEGOSimuationViewController.h"
#import "LEGOSimuationView.h"

@interface LEGOSimuationViewController ()
@property (nonatomic, strong) LEGOSimuationView *simuationView;
@end

@implementation LEGOSimuationViewController

- (LEGOSimuationView *)simuationView {
    if (!_simuationView) {
        _simuationView = [[LEGOSimuationView alloc] init];
    }
    return _simuationView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.simuationView];
    [self.simuationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 100));
        make.centerY.mas_equalTo(self.view.mas_centerY).offset(-50);
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    
    UIButton *turnButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [turnButton1 setTitle:@"上翻" forState:UIControlStateNormal];
    [turnButton1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [turnButton1 addTarget:self action:@selector(turnButton1Click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:turnButton1];
    
    UIButton *turnButton2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [turnButton2 setTitle:@"左翻" forState:UIControlStateNormal];
    [turnButton2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [turnButton2 addTarget:self action:@selector(turnButton2Click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:turnButton2];
    
    UIButton *turnButton3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [turnButton3 setTitle:@"下翻" forState:UIControlStateNormal];
    [turnButton3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [turnButton3 addTarget:self action:@selector(turnButton3Click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:turnButton3];
    
    UIButton *turnButton4 = [UIButton buttonWithType:UIButtonTypeCustom];
    [turnButton4 setTitle:@"右翻" forState:UIControlStateNormal];
    [turnButton4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [turnButton4 addTarget:self action:@selector(turnButton4Click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:turnButton4];
    
    NSArray *array = @[turnButton1,turnButton2,turnButton3,turnButton4];
    [array mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:50 leadSpacing:50 tailSpacing:50];
    [array mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(50);
        if (@available(iOS 11.0, *)) {
            make.bottom.mas_equalTo(self.view.safeAreaInsets.bottom).offset(-100);
        } else {
            make.bottom.offset(-100);
            // Fallback on earlier versions
        }
    }];
    
    // Do any additional setup after loading the view.
}

- (void)turnButton1Click:(id)sender {
    CGPoint point = CGPointMake(0.5, 0);
    [self.class setAnchorPointTo:self.simuationView point:point];
    CATransform3D t = CATransform3DIdentity;
    t.m34 = -1.0f / 500;
    t = CATransform3DRotate(t, M_PI_2 * 1.5, 1, 0, 0);
    CASpringAnimation * springAnimation = [CASpringAnimation animationWithKeyPath:@"sublayerTransform"];
    springAnimation.toValue = [NSValue valueWithCATransform3D:t];
    springAnimation.duration = 2;
    springAnimation.removedOnCompletion = NO;
    springAnimation.fillMode = kCAFillModeForwards;
    springAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.simuationView.layer addAnimation:springAnimation forKey:@"springAnimation"];
}

- (void)turnButton2Click:(id)sender {
    CGPoint point = CGPointMake(0, 0.5);
    [self.class setAnchorPointTo:self.simuationView point:point];
    CATransform3D t = CATransform3DIdentity;
    t.m34 = -1.0f / 500;
    t = CATransform3DRotate(t, -M_PI_2 * 1.5, 0, 1, 0);
    CASpringAnimation * springAnimation = [CASpringAnimation animationWithKeyPath:@"sublayerTransform"];
    springAnimation.toValue = [NSValue valueWithCATransform3D:t];
    springAnimation.duration = 2;
    springAnimation.removedOnCompletion = NO;
    springAnimation.fillMode = kCAFillModeForwards;
    springAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.simuationView.layer addAnimation:springAnimation forKey:@"springAnimation"];
}

- (void)turnButton3Click:(id)sender {
    CGPoint point = CGPointMake(0.5, 1);
    [self.class setAnchorPointTo:self.simuationView point:point];
    CATransform3D t = CATransform3DIdentity;
    t.m34 = -1.0f / 500;
    t = CATransform3DRotate(t, -M_PI_2 * 1.5, 1, 0, 0);
    CASpringAnimation * springAnimation = [CASpringAnimation animationWithKeyPath:@"sublayerTransform"];
    springAnimation.toValue = [NSValue valueWithCATransform3D:t];
    springAnimation.duration = 2;
    springAnimation.removedOnCompletion = NO;
    springAnimation.fillMode = kCAFillModeForwards;
    springAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.simuationView.layer addAnimation:springAnimation forKey:@"springAnimation"];
}

- (void)turnButton4Click:(id)sender {
    CGPoint point = CGPointMake(1, 0.5);
    [self.class setAnchorPointTo:self.simuationView point:point];
    CATransform3D t = CATransform3DIdentity;
    t.m34 = -1.0f / 500;   // 远小近大效果
    t = CATransform3DRotate(t, M_PI_2 * 1.5, 0, 1, 0);
    CASpringAnimation * springAnimation = [CASpringAnimation animationWithKeyPath:@"sublayerTransform"];
    springAnimation.toValue = [NSValue valueWithCATransform3D:t];
    springAnimation.duration = 2;
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
