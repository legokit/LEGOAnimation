//
//  MCMotionManager.m
//  MechanicalCamera
//
//  Created by 杨庆人 on 2019/11/7.
//  Copyright © 2019 yy. All rights reserved.
//

#import "LEGOMotionManager.h"

@interface LEGOMotionManager ()
@property (nonatomic, strong) CMMotionManager *motionManager;
@end

static LEGOMotionManager *shareManager = nil;

@implementation LEGOMotionManager

+ (instancetype)shareManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareManager = [[LEGOMotionManager alloc] init];
    });
    return shareManager;
}

- (CMMotionManager *)motionManager {
    if (!_motionManager) {
        _motionManager = [[CMMotionManager alloc] init];
        _motionManager.deviceMotionUpdateInterval = 1 / 60.0;
    }
    return _motionManager;
}

- (void)startMotionUpdatesWithHandler:(MCMotionHandler)handler {
    if (![self.motionManager isDeviceMotionActive] && [self.motionManager isDeviceMotionAvailable]) {
        [self.motionManager startDeviceMotionUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMDeviceMotion * _Nullable motion, NSError * _Nullable error) {
            if (!error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (handler) {
                        handler(motion);
                    }
                });
                
                CMAcceleration userAcceleration = motion.userAcceleration;
                double num = 1.0f;
                if (fabs(userAcceleration.x) > num || fabs(userAcceleration.y) > num ||fabs(userAcceleration.z) > num) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (self.shake) {
                            self.shake(userAcceleration);
                        }
                    });
                }
            }
        }];
    }
}

- (void)stopMotion {
    [self.motionManager stopDeviceMotionUpdates];
}

@end
