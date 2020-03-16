//
//  UIImage+Common.h
//   
//
//  Created by DV on 2019/2/25.
//  Copyright © 2019 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Common)

#pragma mark - <-- Instance -->
+ (instancetype)imageWithColor:(UIColor *)color;

+ (instancetype)imageWithColor:(UIColor *)color size:(CGSize)size;

/// 渲染模式:Original
+ (instancetype)imageWithOriginal:(NSString *)name;


#pragma mark - <-- Method -->
/// 根据面积 改变图片尺寸
- (UIImage *)resizeImageWithSize:(CGSize)size;

/// 根据比例 改变图片尺寸
- (UIImage *)resizeImageWithScale:(CGFloat)scale;

/// 剪切成圆形
- (UIImage *)clipToCircleImage;

- (UIImage *)addText:(NSString *)text fontColor:(UIColor *)fontColor fontSize:(CGFloat)fontSize;

/// 保存至系统相册
- (void)saveToPhotoAlbum:(nullable void(^)(BOOL finished))completion;

@end

NS_ASSUME_NONNULL_END
