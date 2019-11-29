//
//  FCHighlightButton.m
//  FilmCamera
//
//  Created by 杨庆人 on 2019/5/27.
//  Copyright © 2019年 The last stand. All rights reserved.
//

#import "LEGOHighlightButton.h"
@interface LEGOHighlightButton ()
@property (nonatomic, assign) CGFloat originalAlpha;
@end
@implementation LEGOHighlightButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addTarget:self action:@selector(highlightButtonDidBeTouchDown:) forControlEvents:UIControlEventTouchDown];
        [self addTarget:self action:@selector(highlightButtonDidBeTouchUpInside:) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchCancel | UIControlEventTouchUpOutside];

        self.originalAlpha = self.alpha;
    }
    return self;
}

- (void)highlightButtonDidBeTouchDown:(UIButton *)button {
    self.alpha = 0.3f;
}

- (void)highlightButtonDidBeTouchUpInside:(UIButton *)button {
    self.alpha = self.originalAlpha;
}


- (void)setHighlighted:(BOOL)highlighted {
    if (self.selected) {
        [super setHighlighted:NO];
    }
    else {
        [super setHighlighted:highlighted];
    }
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    CGRect bounds = self.bounds;
    bounds = CGRectMake(self.bounds.origin.x - self.hotspot, self.bounds.origin.y - self.hotspot, self.bounds.size.width + 2*self.hotspot, self.bounds.size.height + 2*self.hotspot);
    return CGRectContainsPoint(bounds, point);
}

@end
