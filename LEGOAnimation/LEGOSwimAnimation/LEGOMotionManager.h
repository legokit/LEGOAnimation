//
//  MCMotionManager.h
//  MechanicalCamera
//
//  Created by 杨庆人 on 2019/11/7.
//  Copyright © 2019 yy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMotion/CoreMotion.h>

typedef void (^MCMotionHandler)(CMDeviceMotion * _Nullable motion);

NS_ASSUME_NONNULL_BEGIN

@interface LEGOMotionManager : NSObject

@property (nonatomic, copy) void (^shake)(CMAcceleration userAcceleration);  // 摇一摇

+ (instancetype)shareManager;

- (void)startMotionUpdatesWithHandler:(MCMotionHandler)handler;

- (void)stopMotion;

@end

NS_ASSUME_NONNULL_END

