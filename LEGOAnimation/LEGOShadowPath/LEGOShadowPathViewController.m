//
//  LEGOShadowPathViewController.m
//  LEGOAnimation
//
//  Created by 杨庆人 on 2019/8/27.
//  Copyright © 2019年 杨庆人. All rights reserved.
//

#import "LEGOShadowPathViewController.h"

@interface LEGOShadowPathViewController ()
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation LEGOShadowPathViewController

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
//        _imageView.image = [UIImage imageNamed:@"image_xxx"];
        _imageView.layer.borderWidth = 1;
        _imageView.backgroundColor = [UIColor whiteColor];
    }
    return _imageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 300));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(self.view.mas_centerY).offset(-50);
    }];
    
    [self.view layoutIfNeeded];
    self.imageView.layer.shadowOffset = CGSizeMake(0, 3);
    self.imageView.layer.shadowOpacity = 0.80;
    self.imageView.layer.shadowRadius = 6.0f;
    self.imageView.layer.shadowColor = [UIColor darkGrayColor].CGColor;
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"阴影";
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imageView.mas_bottom).offset(50);
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.imageView.layer.shadowPath = self.imageView.layer.shadowPath ? nil : [self bezierPathWithCurvedShadowForRect:self.imageView.bounds].CGPath;
}


- (UIBezierPath*)bezierPathWithCurvedShadowForRect:(CGRect)rect {
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    CGPoint topLeft         = rect.origin;
    CGPoint bottomLeft     = CGPointMake(0.0, CGRectGetHeight(rect) + 15);
    CGPoint bottomMiddle = CGPointMake(CGRectGetWidth(rect)/2, CGRectGetHeight(rect) - 3);
    CGPoint bottomRight     = CGPointMake(CGRectGetWidth(rect), CGRectGetHeight(rect) + 15);
    CGPoint topRight     = CGPointMake(CGRectGetWidth(rect), 0.0);
    
    [path moveToPoint:topLeft];
    [path addLineToPoint:bottomLeft];
    [path addQuadCurveToPoint:bottomRight controlPoint:bottomMiddle];
    [path addLineToPoint:topRight];
    [path addLineToPoint:topLeft];
    [path closePath];
    
    return path;
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
