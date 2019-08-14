//
//  LEGOSceneAnimationViewController.m
//  LEGOAnimation
//
//  Created by 杨庆人 on 2019/8/13.
//  Copyright © 2019年 杨庆人. All rights reserved.
//

#import "LEGOSceneViewController.h"
#import <SceneKit/SceneKit.h>
#import "LEGODoraemonView.h"
#import "LEGOSceneView.h"

@interface LEGOSceneViewController ()
@property (nonatomic,strong) LEGODoraemonView *sceneView;
@end

@implementation LEGOSceneViewController

- (LEGODoraemonView *)sceneView {
    if (!_sceneView) {
        _sceneView = [[LEGODoraemonView alloc] init];
    }
    return _sceneView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.sceneView];
    [self.sceneView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.mas_equalTo(self.view);
        make.center.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    
    LEGOSceneView *sceneView = [[LEGOSceneView alloc] init];
    [self.view addSubview:sceneView];
    [sceneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.sceneView.mas_bottom).offset(100);
        make.size.mas_equalTo(CGSizeMake(100, 100));
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];

    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self.view addGestureRecognizer:pan];
    
    
    //
    // Do any additional setup after loading the view.
}

- (void)pan:(UIPanGestureRecognizer *)pan {
    CGPoint point = [pan locationInView:self.view];
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
        {
            self.sceneView.startPoint = point;
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            [self.sceneView setupRotate:point];
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            
        }
            break;
            
        default:
            break;
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
