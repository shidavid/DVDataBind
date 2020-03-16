//
//  UIColor+Common.h
//  iOS_Template_Objc
//
//  Created by DV on 2018/1/9.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Common)

#pragma mark - <-- Property -->
/// UIColor 颜色调至暗点
@property(nonatomic, strong, readonly) UIColor *darkColor;

/// UIColor 随机颜色
@property(nonatomic, class, readonly) UIColor *randomColor;

/// UIColor 转换为 RGB
@property(nonatomic, strong, readonly) NSArray<NSNumber *> *RGB;


#pragma mark - <-- Instance -->
/**
 *  RGB 转换为 UIColor
 *  @param rgba @[@(r),@(g),@(b),@(alpha)]
 *  r g b 类型:float 取值范围:[0,255]
 *  alpha 类型:float 取值范围:[0,1] 可选写
 *  举例: [UIColor colorWithRGB: @[@(1),@(2),@(3),@(0.4)]];
 */
+ (instancetype)colorWithRGBA:(NSArray<NSNumber *> *)rgba;

/**
 *  16进制 转为 UIColor
 *  @param hex 16进制 0x000000
 *  @return UIColor
 */
+ (instancetype)colorWithHex:(UInt32)hex;

/**
 *  16进制 转换为 UIColor
 *  @param hex 16进制 0x000000
 *  @param opacity 透明度
 *  @return UIColor
 */
+ (instancetype)colorWithHex:(UInt32)hex alpha:(float)opacity;

/**
 *  16进制颜色(html颜色值)字符串 转为 UIColor
 *  @param hexString 16进制字符串 @"0x000000" @"#000000"
 *  @return UIColor
 */
+ (instancetype)colorWithHexString:(NSString *)hexString;

/**
 *  16进制颜色(html颜色值)字符串 转为 UIColor
 *  @param hexString 16进制字符串 @"0x000000" @"#000000"
 *  @param opacity 透明度
 *  @return UIColor
 */
+ (instancetype)colorWithHexString:(NSString *)hexString alpha:(float)opacity;



@end
