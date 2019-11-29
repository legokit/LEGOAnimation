//
//  MCMagnifierView.h
//  MechanicalCamera
//
//  Created by 杨庆人 on 2019/11/7.
//  Copyright © 2019 yy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LEGOMagnifierView : UIWindow

@property (nonatomic, strong) UIView *renderView;
@property (nonatomic, assign) CGPoint renderPoint;
@end

NS_ASSUME_NONNULL_END
