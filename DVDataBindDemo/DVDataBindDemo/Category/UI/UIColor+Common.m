//
//  UIColor+Common.m
//  iOS_Template_Objc
//
//  Created by DV on 2018/1/9.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "UIColor+Common.h"

@implementation UIColor (Common)

- (UIColor *)darkColor {
    NSArray<NSNumber*> *rgb = self.RGB;
    float red   = (rgb[0].floatValue < 50.0) ? 0 : (rgb[0].floatValue - 50.0);
    float green = (rgb[1].floatValue < 50.0) ? 0 : (rgb[1].floatValue - 50.0);
    float blue  = (rgb[2].floatValue < 50.0) ? 0 : (rgb[2].floatValue - 50.0);
    float alpha = rgb[3].floatValue;
    return [UIColor colorWithRGBA:@[@(red),@(green),@(blue),@(alpha)]];
}

+ (UIColor *)randomColor {
    CGFloat hue    = (CGFloat)(arc4random() % 256) / 256.0;
    CGFloat satur  = (CGFloat)(arc4random() % 128) / 256.0 + 0.5;
    CGFloat bright = (CGFloat)(arc4random() % 128) / 256.0 + 0.5;
    return [UIColor colorWithHue:hue saturation:satur brightness:bright alpha:1];
}

- (NSArray<NSNumber *> *)RGB {
    size_t  n = CGColorGetNumberOfComponents(self.CGColor);
    const CGFloat *rgba = CGColorGetComponents(self.CGColor);
    NSMutableArray *resultArr = [NSMutableArray new];
    
    for (int i = 0; i < 4; i++){
        NSNumber *value;
        
        if (n == 2) {
            if (i == 3) {
                value = @(rgba[1]);
            }
            else{
                value = @(rgba[0]*255.0);
            }
            
        }
        else{
            if (i == 3) {
                value = @(rgba[i]);
            }
            else{
                value = @(rgba[i]*255.0);
            }
        }
        
        [resultArr addObject:value];
    }

    return [resultArr copy];
}



#pragma mark - <-- Instance -->
+ (instancetype)colorWithRGBA:(NSArray<NSNumber *> *)rgba {
    float red = rgba[0].floatValue/255.0f;
    float green = rgba[1].floatValue/255.0f;
    float blue = rgba[2].floatValue/255.0f;
    float alpha = (rgba.count < 4 ? 1.0f : rgba[3].floatValue);

    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

+ (instancetype)colorWithHex:(UInt32)hex {
    return [UIColor colorWithHex:hex alpha:1.0f];
}

+ (instancetype)colorWithHex:(UInt32)hex alpha:(float)opacity {
    float red   = ((float)((hex & 0xFF0000) >> 16))/255.0;
    float green = ((float)((hex & 0xFF00) >> 8))/255.0;
    float blue  = ((float)(hex & 0xFF))/255.0;
    return [UIColor colorWithRed:red green:green blue:blue alpha:opacity];
}

+ (instancetype)colorWithHexString:(NSString *)hexString {
    return [self colorWithHexString:hexString alpha:1.0f];
}

+ (instancetype)colorWithHexString:(NSString *)hexString alpha:(float)opacity {
    NSString *cString = [[hexString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    
    if ([cString length] < 6) return [UIColor blackColor];
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"] || [cString hasPrefix:@"0x"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor blackColor];
    
    // Separate into r, g, b substrings
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:opacity];
}
@end
