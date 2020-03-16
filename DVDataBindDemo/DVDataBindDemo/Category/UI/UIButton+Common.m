//
//  UIButton+Common.m
//  iOS_Template_Objc
//
//  Created by DV on 2018/1/9.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "UIButton+Common.h"

@implementation UIButton (Common)


#pragma mark - <-- Property -->
- (NSString *)title {
    return [self titleForState:UIControlStateNormal];
}

- (void)setTitle:(NSString *)title {
    [self setTitle:title forState:UIControlStateNormal];
}

- (NSString *)titleForHighlighted {
    return [self titleForState:UIControlStateHighlighted];
}

- (void)setTitleForHighlighted:(NSString *)titleForHighlighted {
    [self setTitle:titleForHighlighted forState:UIControlStateHighlighted];
}


- (UIColor *)titleColor {
    return [self titleColorForState:UIControlStateNormal];
}

- (void)setTitleColor:(UIColor *)titleColor {
    [self setTitleColor:titleColor forState:UIControlStateNormal];
}

- (UIColor *)titleColorForHighlighted {
    return [self titleColorForState:UIControlStateHighlighted];
}

- (void)setTitleColorForHighlighted:(UIColor *)titleColorForHighlighted {
    [self setTitleColor:titleColorForHighlighted forState:UIControlStateHighlighted];
}

- (UIImage *)image {
    return [self imageForState:UIControlStateNormal];
}

- (void)setImage:(UIImage *)image {
    [self setImage:image forState:UIControlStateNormal];
}

- (UIImage *)imageForHighlighted {
    return [self imageForState:UIControlStateHighlighted];
}

- (void)setImageForHighlighted:(UIImage *)imageForHighlighted {
    [self setImage:imageForHighlighted forState:UIControlStateHighlighted];
}

- (UIImage *)imageForSelected {
    return [self imageForState:UIControlStateSelected];
}

- (void)setImageForSelected:(UIImage *)imageForSelected {
    [self setImage:imageForSelected forState:UIControlStateSelected];
}

- (UIImage *)backgroundImage {
    return [self backgroundImageForState:UIControlStateNormal];
}

- (void)setBackgroundImage:(UIImage *)backgroundImage {
    [self setBackgroundImage:backgroundImage forState:UIControlStateNormal];
}

- (UIImage *)backgroundImageForHighlighted {
    return [self backgroundImageForState:UIControlStateHighlighted];
}

- (void)setBackgroundImageForHighlighted:(UIImage *)backgroundImageForHighlighted {
    [self setBackgroundImage:backgroundImageForHighlighted forState:UIControlStateHighlighted];
}


#pragma mark - <-- Method -->
- (void)constraintToFit {
    if (@available(iOS 11, *)) {
        [[self.widthAnchor constraintEqualToConstant:self.bounds.size.width] setActive:YES];
        [[self.widthAnchor constraintEqualToConstant:self.bounds.size.height] setActive:YES];
    }
}

@end
