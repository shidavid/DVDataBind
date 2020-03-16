//
//  UIImage+Common.m
//   
//
//  Created by DV on 2019/2/25.
//  Copyright © 2019 iOS. All rights reserved.
//

#import "UIImage+Common.h"
#import <objc/runtime.h>


@implementation UIImage (Common)

+ (instancetype)imageWithColor:(UIColor *)color {
    return [self imageWithColor:color size:CGSizeMake(1, 1)];
}

+ (instancetype)imageWithColor:(UIColor *)color size:(CGSize)size {
    //图片尺寸
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    //填充画笔
    UIGraphicsBeginImageContext(rect.size);
    //根据所传颜色绘制
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    //显示区域
    CGContextFillRect(context, rect);
    // 得到图片信息
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    //消除画笔
    UIGraphicsEndImageContext();
    return image;
}

+ (instancetype)imageWithOriginal:(NSString *)name {
    return [[UIImage imageNamed:name] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}


- (UIImage *)resizeImageWithSize:(CGSize)size {
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage *)resizeImageWithScale:(CGFloat)scale {
    CGFloat w = self.size.width * scale;
    CGFloat h = self.size.height * scale;
    CGSize newSize = CGSizeMake(w, h);
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0);
    [self drawInRect:CGRectMake(0, 0, w, h)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage *)clipToCircleImage {
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0);
    
    CGFloat w = self.size.width;
    CGFloat h = self.size.height;
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, w, h)];
    [path addClip];
    
    [self drawAtPoint:CGPointZero];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage *)addText:(NSString *)text fontColor:(UIColor *)fontColor fontSize:(CGFloat)fontSize {
    UIImage *sourceImage = self;
    CGSize imageSize = sourceImage.size;
    
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    [sourceImage drawAtPoint:CGPointMake(0, 0)];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawPath(context, kCGPathStroke);
    
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:fontSize],
                                 NSForegroundColorAttributeName:fontColor};
    
    CGRect sizeToFit = [text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, fontSize)
                                          options:NSStringDrawingUsesDeviceMetrics
                                       attributes:attributes
                                          context:nil];
    [text drawAtPoint:CGPointMake((imageSize.width-sizeToFit.size.width)/2, (imageSize.height-sizeToFit.size.height)/2-2) withAttributes:attributes];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


- (void(^)(BOOL))completionBlock {
    return (void(^)(BOOL finished))objc_getAssociatedObject(self, _cmd);
}

- (void)setCompletionBlock:(void(^)(BOOL))completionBlock {
    objc_setAssociatedObject(self, @selector(completionBlock), completionBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)saveToPhotoAlbum:(void (^)(BOOL))completion {
    self.completionBlock = completion;
    UIImageWriteToSavedPhotosAlbum(self, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

@end
