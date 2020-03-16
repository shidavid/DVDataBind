//
//  UIView+Common.h
//  iOS_Template_Objc
//
//  Created by DV on 2018/1/10.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Common)

#pragma mark - <-- Frame -->
@property(nonatomic, assign, readonly) CGFloat x;
@property(nonatomic, assign, readonly) CGFloat y;

@property(nonatomic, assign, readonly) CGFloat width;
@property(nonatomic, assign, readonly) CGFloat height;

@property(nonatomic, assign, readonly) CGFloat minX;
@property(nonatomic, assign, readonly) CGFloat midX;
@property(nonatomic, assign, readonly) CGFloat maxX;

@property(nonatomic, assign, readonly) CGFloat minY;
@property(nonatomic, assign, readonly) CGFloat midY;
@property(nonatomic, assign, readonly) CGFloat maxY;

@property(nonatomic, assign, readonly) CGPoint origin;
@property(nonatomic, assign, readonly) CGSize  size;

@property(nonatomic, assign) BOOL isDisplay;

@property(nonatomic, assign, readonly) CGRect lastFrame;


#pragma mark - <-- Common -->
///截图
@property(nonatomic, strong, readonly) UIImage *screenShotImage;

+ (instancetype)viewWithNib;

///显示边框
- (void)showBorder;

- (void)showAllSubViewBorder;

- (void)addShadow:(UIColor *)shadowColor frame:(CGRect)frame;

- (void)updateSubViewLayout:(NSArray<__kindof UIView *> *)subViews margin:(CGFloat)margin;

- (void)layoutIfNeededForSafeArea;

@end
