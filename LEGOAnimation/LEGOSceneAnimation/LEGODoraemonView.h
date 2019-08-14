//
//  LEGOSceneView.h
//  LEGOAnimation
//
//  Created by 杨庆人 on 2019/8/13.
//  Copyright © 2019年 杨庆人. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LEGODoraemonView : UIView
@property (nonatomic, assign) CGPoint startPoint;
- (void)setupRotate:(CGPoint)point;
@end

NS_ASSUME_NONNULL_END
