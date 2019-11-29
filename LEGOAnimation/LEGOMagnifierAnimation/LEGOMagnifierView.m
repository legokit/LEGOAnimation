



//
//  MCMagnifierView.m
//  MechanicalCamera
//
//  Created by 杨庆人 on 2019/11/7.
//  Copyright © 2019 yy. All rights reserved.
//

#import "LEGOMagnifierView.h"

@interface LEGOMagnifierView ()
@end

@implementation LEGOMagnifierView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.windowLevel = UIWindowLevelStatusBar + 1;
        self.layer.delegate = self;
    }
    return self;
}


- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
    CGContextSetShouldAntialias(ctx, YES);  // 抗锯齿
    CGInterpolationQuality quality = kCGInterpolationMedium;  // 图像质量
    CGContextSetInterpolationQuality(ctx, quality);
    CGContextTranslateCTM(ctx, self.frame.size.width * 0.5, self.frame.size.height * 0.5);
    CGContextScaleCTM(ctx, 2, 2);
    CGContextTranslateCTM(ctx, -1 * self.renderPoint.x, -1 * self.renderPoint.y);
    [self.renderView.layer renderInContext:ctx];
}

- (void)setRenderPoint:(CGPoint)renderPoint {
    _renderPoint = renderPoint;
    [self.layer setNeedsDisplay];
}

- (void)setHidden:(BOOL)hidden {
    [super setHidden:hidden];
    self.layer.borderColor = hidden ? [[UIColor clearColor] CGColor] : [[UIColor lightGrayColor] CGColor];
}


@end
