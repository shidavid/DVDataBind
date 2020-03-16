//
//  UILabel+DV.h
//   
//
//  Created by 施达威 on 2018/2/8.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Common)

@property(nonatomic, assign) CGFloat fontSize;

- (CGFloat)heightFromFitWidth:(CGFloat)width;


/// 自动根据宽度适应字间距
- (void)wordSpaceToFitWidth:(CGFloat)width;


/// 改变行间距
- (void)changeLineSpace:(float)space;

/// 改变字间距
- (void)changeWordSpace:(float)space;

/// 改变行间距和字间距
- (void)changeLineSpace:(float)lineSpace wordSpace:(float)wordSpace;

- (void)addUnderLineWithString:(NSString *)string;

@end
