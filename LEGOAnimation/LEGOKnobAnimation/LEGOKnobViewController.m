

//
//  LEGODynamicViewController.m
//  LEGOAnimation
//
//  Created by 杨庆人 on 2019/8/14.
//  Copyright © 2019年 杨庆人. All rights reserved.
//

#import "LEGOKnobViewController.h"
#import "LEGOKnobView.h"

@interface LEGOKnobViewController ()
@property (nonatomic, strong) LEGOKnobView *knobView;
@end

@implementation LEGOKnobViewController

- (LEGOKnobView *)knobView {
    if (!_knobView) {
        _knobView = [[LEGOKnobView alloc] init];
    }
    return _knobView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.knobView];
    [self.knobView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(150, 150));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(self.view.mas_centerY).offset(-50);
    }];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"旋钮";
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.knobView.mas_bottom).offset(50);
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    
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
