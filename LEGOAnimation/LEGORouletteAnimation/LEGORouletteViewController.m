

//
//  LEGORouletteViewController.m
//  LEGOAnimation
//
//  Created by 杨庆人 on 2019/8/16.
//  Copyright © 2019年 杨庆人. All rights reserved.
//

#import "LEGORouletteViewController.h"
#import "LEGORouletteView.h"

@interface LEGORouletteViewController ()
@property (nonatomic, strong) LEGORouletteView *rouletteView;

@end

@implementation LEGORouletteViewController

- (LEGORouletteView *)rouletteView {
    if (!_rouletteView) {
        _rouletteView = [[LEGORouletteView alloc] init];
    }
    return _rouletteView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.rouletteView];
    [self.rouletteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(250, 250));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(self.view.mas_centerY).offset(-50);
    }];
    
    UIView *redView = [[UIView alloc] init];
    redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:redView];
    [redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(40);
        make.centerX.mas_equalTo(self.rouletteView.mas_centerX);
        make.top.mas_equalTo(self.rouletteView.mas_top).offset(-2.5);
    }];
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor grayColor];
    [self.view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.rouletteView);
        make.height.mas_equalTo(1.5);
        make.centerY.mas_equalTo(self.rouletteView.mas_centerY);
    }];

    UIView *maskView = [[UIView alloc] init];
    maskView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:maskView];
    [maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.rouletteView.mas_centerY);
        make.left.bottom.right.mas_equalTo(self.rouletteView);
    }];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"仪表盘";
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.rouletteView.mas_bottom);
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.text = @"0°";
    [self.view addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.rouletteView.mas_left).offset(-5);
        make.centerY.mas_equalTo(self.rouletteView.mas_centerY);
    }];
    
    UILabel *label2 = [[UILabel alloc] init];
    label2.text = @"90°";
    [self.view addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.rouletteView.mas_centerX);
        make.bottom.mas_equalTo(self.rouletteView.mas_top).offset(-10);
    }];
    
    UILabel *label3 = [[UILabel alloc] init];
    label3.text = @"180°";
    [self.view addSubview:label3];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.rouletteView.mas_right).offset(5);
        make.centerY.mas_equalTo(self.rouletteView.mas_centerY);
    }];
    
    
    UILabel *valueLabel = [[UILabel alloc] init];
    [self.view addSubview:valueLabel];
    [valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_centerX).offset(-120);
        make.bottom.mas_equalTo(self.rouletteView.mas_top).offset(-100);
    }];
    
    self.rouletteView.change = ^(CGFloat value) {
        valueLabel.text = [NSString stringWithFormat:@"rotationAngle: %.5f°",value / M_PI * 180];
    };
    // Do any additional setup after loading the view.
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
