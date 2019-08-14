




//
//  LEGOSimuationView.m
//  LEGOAnimation
//
//  Created by 杨庆人 on 2019/8/14.
//  Copyright © 2019年 杨庆人. All rights reserved.
//

#import "LEGOSimuationView.h"
@interface LEGOSimuationView ()
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIView *sideView;
@property (nonatomic, strong) UIView *bottomView;
@end
@implementation LEGOSimuationView

- (UIView *)topView {
    if (!_topView) {
        _topView = [[UIView alloc] init];
//        _topView.backgroundColor = [UIColor redColor];
        _topView.layer.borderWidth = 1;
    }
    return _topView;
}

- (UIView *)sideView {
    if (!_sideView) {
        _sideView = [[UIView alloc] init];
        _sideView.layer.borderWidth = 1;
//        _sideView.backgroundColor = [UIColor blueColor];
    }
    return _sideView;
}

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        _bottomView.layer.borderWidth = 1;
//        _bottomView.backgroundColor = [UIColor yellowColor];
    }
    return _bottomView;
}

- (instancetype)init {
    if (self = [super init]) {
        [self setSimuationView];
    }
    return self;
}

- (void)setSimuationView {
    [self addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    [self addSubview:self.sideView];
    [self.sideView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.height.mas_equalTo(50);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    [self addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    
    [self layoutIfNeeded];
    
    CATransform3D t1 = CATransform3DIdentity;
    t1 = CATransform3DTranslate(t1, 0, 0, -50 / 2.0);
    t1 = CATransform3DRotate(t1, -M_PI_2, 1, 0, 0);
    t1 = CATransform3DTranslate(t1, 0, 0, 50);
    self.sideView.layer.transform = t1;
    
    CATransform3D t2 = CATransform3DIdentity;
    t2 = CATransform3DTranslate(t2, 0, 0, -50);
    t2 = CATransform3DRotate(t2, -M_PI, 1, 0, 0);
    self.bottomView.layer.transform = t2;
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.text = @"1";
    [self.topView addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.topView);
    }];
    UILabel *label2 = [[UILabel alloc] init];
    label2.text = @"2";
    [self.sideView addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.sideView);
    }];
    UILabel *label3= [[UILabel alloc] init];
    label3.text = @"3";
    [self.bottomView addSubview:label3];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.bottomView);
    }];
}

@end
