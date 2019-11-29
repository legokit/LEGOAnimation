//
//  LEGOSwimView.h
//  LEGOAnimation
//
//  Created by 杨庆人 on 2019/11/29.
//  Copyright © 2019 杨庆人. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>

NS_ASSUME_NONNULL_BEGIN

@interface LEGOSwimView : UIView
@property (nonatomic, assign) CMAcceleration accelleration;
@property (nonatomic, assign) CMAcceleration userAcceleration;

- (void)updateLocation;

@end

NS_ASSUME_NONNULL_END
