//
//  UIView+Common.m
//  iOS_Template_Objc
//
//  Created by DV on 2018/1/10.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "UIView+Common.h"
#import <objc/runtime.h>


@implementation UIView (Common)

- (CGFloat)x {
    return self.frame.origin.x;
}

- (CGFloat)y {
    return self.frame.origin.y;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (CGFloat)minX {
    return CGRectGetMinX(self.frame);
}

- (CGFloat)midX {
    return CGRectGetMidX(self.frame);
}

- (CGFloat)maxX {
    return CGRectGetMaxX(self.frame);
}

- (CGFloat)minY {
    return CGRectGetMinY(self.frame);
}

- (CGFloat)midY {
    return CGRectGetMidY(self.frame);
}

- (CGFloat)maxY {
    return CGRectGetMaxY(self.frame);
}

- (CGPoint)origin {
    return self.frame.origin;
}

- (CGSize)size {
    return self.frame.size;
}

- (BOOL)isDisplay {
    NSNumber *value = objc_getAssociatedObject(self, _cmd);
    if (!value) {
        value = @(!self.isHidden);
    }
    return [value boolValue];
}

- (void)setIsDisplay:(BOOL)isDisplay {
    objc_setAssociatedObject(self, @selector(isDisplay), @(isDisplay), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (CGRect)lastFrame {
    NSValue *value = objc_getAssociatedObject(self, _cmd);
    if (!value) {
        self.lastFrame = self.frame;
        value = [NSValue valueWithCGRect:self.frame];
    }
    return [value CGRectValue];
}

- (void)setLastFrame:(CGRect)lastFrame {
    objc_setAssociatedObject(self, @selector(lastFrame), [NSValue valueWithCGRect:lastFrame], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (UIImage *)screenShotImage {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, YES, [[UIScreen mainScreen] scale]);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (instancetype)viewWithNib {
    NSString *className = NSStringFromClass([self class]);
    UINib *aNib = [UINib nibWithNibName:className bundle:nil];
    NSArray<UIView *> *array = [aNib instantiateWithOwner:nil options:nil];
    return array[0];
}

- (void)showBorder {
    CGFloat hue    = (CGFloat)(arc4random() % 256) / 256.0;
    CGFloat satur  = (CGFloat)(arc4random() % 128) / 256.0 + 0.5;
    CGFloat bright = (CGFloat)(arc4random() % 128) / 256.0 + 0.5;
    UIColor *color = [UIColor colorWithHue:hue saturation:satur brightness:bright alpha:1];
    [self.layer setBorderWidth:2];
    [self.layer setBorderColor:color.CGColor];
}



- (void)showAllSubViewBorder {
    
    NSMutableArray<UIView *> *array = [NSMutableArray array];
    [array addObject:self];
    
    
    while (array.count > 0 && array.firstObject) {
        UIView *v = array.firstObject;
        [v showBorder];
        [array removeObject:array.firstObject];
        if (v.subviews.count > 0) {
            [array addObjectsFromArray:v.subviews];
        }
        if ([v isKindOfClass:[UITableView class]]) {
            [array addObjectsFromArray:[(UITableView *)v visibleCells]];
        }
        if ([v isKindOfClass:[UICollectionView class]]) {
            [array addObjectsFromArray:[(UICollectionView *)v visibleCells]];
        }
    }
}

- (void)addShadow:(UIColor *)shadowColor frame:(CGRect)frame {
    self.layer.shadowColor = [shadowColor CGColor];
    self.layer.shadowOpacity = 1;
    self.layer.shadowRadius = 1.0;
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [[UIScreen mainScreen] scale];
    CGPathRef path = [[UIBezierPath bezierPathWithRect:frame] CGPath];
    self.layer.shadowPath = path;
}


- (void)updateSubViewLayout:(NSArray<__kindof UIView *> *)subViews
                     margin:(CGFloat)margin {
    if (subViews.count == 0) {
        return;
    }
    
    __block CGFloat lastY = subViews[0].minY;
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1 options:(UIViewAnimationOptionCurveEaseInOut) animations:^{
        
        for (UIView *sub in subViews) {
            if (sub.isDisplay) {
                [self addSubview:sub];
                CGRect tmpFrame = sub.frame;
                tmpFrame.origin.y = lastY;
                sub.frame = tmpFrame;
                sub.alpha = 1;
                lastY = sub.maxY + margin;
            } else {
                sub.alpha = 0;
            }
        }
    } completion:^(BOOL finished) {
        for (UIView *sub in subViews) {
            if (sub.isDisplay) {
                
            } else {
                [sub removeFromSuperview];
            }
        }
    }];
}

- (void)layoutIfNeededForSafeArea {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    UILayoutGuide * guide = self.safeAreaLayoutGuide;
    [self.leadingAnchor constraintEqualToAnchor:guide.leadingAnchor].active = YES;
    [self.trailingAnchor constraintEqualToAnchor:guide.trailingAnchor].active = YES;
    [self.topAnchor constraintEqualToAnchor:guide.topAnchor].active = YES;
    [self.bottomAnchor constraintEqualToAnchor:guide.bottomAnchor].active = YES;
}


@end
