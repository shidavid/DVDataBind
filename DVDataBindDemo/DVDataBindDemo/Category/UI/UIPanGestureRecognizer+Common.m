//
//  UIPanGestureRecognizer+Common.m
//  DVKit
//
//  Created by mlgPro on 2020/1/18.
//  Copyright © 2020 DVKit. All rights reserved.
//

#import "UIPanGestureRecognizer+Common.h"

@implementation UIPanGestureRecognizer (Common)

- (void)setXTranslationWithView:(UIView *)view {
    CGPoint transPoint = [self translationInView:view];
    view.transform = CGAffineTransformTranslate(view.transform, transPoint.x, 0);
    [self setTranslation:CGPointZero inView:view];
}

- (void)setYTranslationWithView:(UIView *)view {
    CGPoint transPoint = [self translationInView:view];
    view.transform = CGAffineTransformTranslate(view.transform, 0, transPoint.y);
    [self setTranslation:CGPointZero inView:view];
}

@end
