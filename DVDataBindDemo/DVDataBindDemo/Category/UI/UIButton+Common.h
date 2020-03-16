//
//  UIButton+Common.h
//  iOS_Template_Objc
//
//  Created by DV on 2018/1/9.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Common)

@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSString *titleForHighlighted;

@property(nonatomic, strong) UIImage *image;
@property(nonatomic, strong) UIImage *imageForHighlighted;
@property(nonatomic, strong) UIImage *imageForSelected;

@property(nonatomic, strong) UIImage *backgroundImage;
@property(nonatomic, strong) UIImage *backgroundImageForHighlighted;

@property(nonatomic, strong) UIColor *titleColor;
@property(nonatomic, strong) UIColor *titleColorForHighlighted;

- (void)constraintToFit;

@end
