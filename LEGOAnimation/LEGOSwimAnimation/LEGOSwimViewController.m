//
//  LEGOSwimViewController.m
//  LEGOAnimation
//
//  Created by 杨庆人 on 2019/11/29.
//  Copyright © 2019 杨庆人. All rights reserved.
//

#import "LEGOSwimViewController.h"
#import "LEGOSwimView.h"
#import "LEGOMotionManager.h"

@interface LEGOSwimViewController ()

@property (nonatomic, strong) LEGOSwimView *swimView;
@end

@implementation LEGOSwimViewController

- (LEGOSwimView *)swimView {
    if (!_swimView) {
        _swimView = [[LEGOSwimView alloc] init];
    }
    return _swimView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.swimView];
    [self.swimView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(LEGOScreenWidth - 140, LEGOScreenWidth));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(self.view.mas_centerY).offset(-50);
    }];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"模拟重力感应";
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.swimView.mas_bottom).offset(50);
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNotification:) name:UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNotification:) name:UIApplicationWillEnterForegroundNotification object:nil];
    __weak typeof(self)weakSelf = self;
    [[LEGOMotionManager shareManager] startMotionUpdatesWithHandler:^(CMDeviceMotion *motion) {
        weakSelf.swimView.accelleration = motion.gravity;
        weakSelf.swimView.userAcceleration = motion.userAcceleration;
        [weakSelf.swimView updateLocation];
    }];
}


- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[LEGOMotionManager shareManager] stopMotion];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillEnterForegroundNotification object:nil];
}

- (void)receiveNotification:(NSNotification *)notification {
    if ([notification.name isEqualToString:UIApplicationDidEnterBackgroundNotification]) {
        [[LEGOMotionManager shareManager] stopMotion];
    } else {
        [[LEGOMotionManager shareManager] startMotionUpdatesWithHandler:^(CMDeviceMotion *motion) {
            self.swimView.accelleration = motion.gravity;
            self.swimView.userAcceleration = motion.userAcceleration;
            [self.swimView updateLocation];
        }];
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
