//
//  LEGOMagnifierViewController.m
//  LEGOAnimation
//
//  Created by 杨庆人 on 2019/11/29.
//  Copyright © 2019 杨庆人. All rights reserved.
//

#import "LEGOMagnifierViewController.h"
#import "LEGOMagnifierView.h"

@interface LEGOMagnifierViewController ()
@property (nonatomic, strong) UIImageView *perviewView;
@property (nonatomic, strong) UIImageView *magniBorderView;
@property (nonatomic, strong) LEGOMagnifierView *magnifierView;
@end

@implementation LEGOMagnifierViewController

- (UIImageView *)perviewView {
    if (!_perviewView) {
        _perviewView = [[UIImageView alloc] init];
        _perviewView.image = [UIImage imageNamed:@"IMG_5534.jpg"];
        _perviewView.contentMode = UIViewContentModeScaleAspectFill;
        _perviewView.layer.masksToBounds = YES;
    }
    return _perviewView;
}

- (UIImageView *)magniBorderView {
    if (!_magniBorderView) {
        _magniBorderView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, LEGOScreenWidth * 0.45, LEGOScreenWidth * 0.45)];
        _magniBorderView.image = [UIImage imageNamed:@"img_magnifier_frame"];
        _magniBorderView.hidden = YES;
    }
    return _magniBorderView;
}

- (LEGOMagnifierView *)magnifierView {
    if (!_magnifierView) {
        _magnifierView = [[LEGOMagnifierView alloc] init];
        CGFloat margin = 5.5 / 375 * LEGOScreenWidth;
        CGRect rect = CGRectMake(self.magniBorderView.frame.origin.x + margin, self.magniBorderView.frame.origin.y + margin, self.magniBorderView.frame.size.width - margin * 2, self.magniBorderView.frame.size.height - margin * 2);
        _magnifierView.frame = rect;
        _magnifierView.renderView = self.view.window;
        _magnifierView.layer.cornerRadius = _magnifierView.frame.size.width / 2.0;
        _magnifierView.layer.masksToBounds = YES;
        _magnifierView.hidden = YES;
    }
    return _magnifierView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.perviewView];
    [self.perviewView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(LEGOScreenWidth - 140, LEGOScreenWidth));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(self.view.mas_centerY).offset(-50);
    }];
    
    [self.view addSubview:self.magniBorderView];

    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    [self showMagnifier:touch];
}

- (void)showMagnifier:(UITouch *)touch {
    CGPoint point = [touch locationInView:self.view];
    CGRect rect = CGRectMake(self.perviewView.frame.origin.x, self.perviewView.frame.origin.y, self.perviewView.frame.size.width, self.perviewView.frame.size.height + 90);
    if (CGRectContainsPoint(rect, point)) {
        self.magnifierView.hidden = NO;
        self.magniBorderView.hidden = NO;
        self.magnifierView.center = CGPointMake(point.x, point.y - 90);
        self.magnifierView.renderPoint = CGPointMake(point.x, point.y - 90);
        self.magniBorderView.center = self.magnifierView.center;
    }
    else {
        self.magnifierView.hidden = YES;
        self.magniBorderView.hidden = YES;
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    [self showMagnifier:touch];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    self.magnifierView = nil;
    self.magniBorderView.hidden = YES;
}


@end
