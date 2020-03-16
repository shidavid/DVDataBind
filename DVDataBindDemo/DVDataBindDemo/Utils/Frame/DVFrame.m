//
//  DVFrame.m
//   
//
//  Created by DV on 2018/2/10.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "DVFrame.h"

@implementation DVFrame

//#define k_Height_NavContentBar 44.0f
//#define k_Height_StatusBar (IS_PhoneXAll? 44.0 : 20.0)
//#define k_Height_NavBar (IS_PhoneXAll ? 88.0 : 64.0)
//#define k_Height_TabBar (IS_PhoneXAll ? 83.0 : 49.0)

+ (CGFloat)width {
    return [[UIScreen mainScreen] bounds].size.width;
}

+ (CGFloat)height {
    return [[UIScreen mainScreen] bounds].size.height;
}

+ (CGFloat)height_not_nav {
    return [self height] - [self navBarHeight];
}

+ (CGFloat)statusBarHeight {
    return [[UIApplication sharedApplication] statusBarFrame].size.height;
}

+ (CGFloat)navBarHeight {
    return 44.0 + [self statusBarHeight];
}


+ (CGRect)bounds {
    return [[UIScreen mainScreen] bounds];
}

+ (CGRect)frame {
    return CGRectMake(0, 0, [self width], [self height] - [self navBarHeight] - [self tabBarHeight]);
}

+ (CGRect)frame_full {
    return CGRectMake(0, 0, [self width], [self height]);
}

+ (CGRect)frame_not_nav {
    return CGRectMake(0, 0, [self width], [self height] - [self navBarHeight]);
}


+ (CGFloat)switchWidth {
    return 51.0f;
}

+ (CGFloat)switchHeight {
    return 31.0f;
}

#pragma mark - <-- CellFrame -->
+ (CGFloat)cellX {
    return 0;
}

+ (CGFloat)cellY {
    return 5;
}

+ (CGFloat)cellWidth {
    return [self width];
}

+ (CGFloat)cellHeight {
    return 44;
}

+ (CGFloat)cellW {
    return 5;
}

+ (CGRect)celllFrameTop {
    return CGRectMake([self cellX], 0, [self cellWidth], [self cellHeight]);
}

+ (CGRect)celllFrame1 {
    return CGRectMake([self cellX], [self cellY], [self cellWidth], [self cellHeight]);
}

+ (CGRect)celllFrame2 {
    return CGRectMake([self cellX], self.cellY + (self.cellHeight + self.cellW), [self cellWidth], [self cellHeight]);
}

+ (CGRect)celllFrame3 {
    return CGRectMake([self cellX], self.cellY + (self.cellHeight + self.cellW) * 2, [self cellWidth], [self cellHeight]);
}

+ (CGRect)celllFrame4 {
    return CGRectMake([self cellX], self.cellY + (self.cellHeight + self.cellW) * 3, [self cellWidth], [self cellHeight]);
}

+ (CGRect)celllFrame5 {
    return CGRectMake([self cellX], self.cellY + (self.cellHeight + self.cellW) * 4, [self cellWidth], [self cellHeight]);
}

+ (CGRect)celllFrame6 {
    return CGRectMake([self cellX], self.cellY + (self.cellHeight + self.cellW) * 5, [self cellWidth], [self cellHeight]);
}

+ (CGRect)celllFrame7 {
    return CGRectMake([self cellX], self.cellY + (self.cellHeight + self.cellW) * 6, [self cellWidth], [self cellHeight]);
}

+ (CGRect)celllFrame8 {
    return CGRectMake([self cellX], self.cellY + (self.cellHeight + self.cellW) * 7, [self cellWidth], [self cellHeight]);
}

+ (CGRect)celllFrame9 {
    return CGRectMake([self cellX], self.cellY + (self.cellHeight + self.cellW) * 8, [self cellWidth], [self cellHeight]);
}

+ (CGRect)celllFrame12 {
    return CGRectMake([self cellX],
                      self.cellY,
                      self.cellWidth,
                      self.cellHeight * 2 + self.cellW);
}

+ (CGRect)celllFrame23 {
    return CGRectMake([self cellX],
                      self.cellY + (self.cellHeight + self.cellW) * 1,
                      self.cellWidth,
                      self.cellHeight * 2 + self.cellW);
}

+ (CGRect)celllFrame34 {
    return CGRectMake([self cellX],
                      self.cellY + (self.cellHeight + self.cellW) * 2,
                      self.cellWidth,
                      self.cellHeight * 2 + self.cellW);
}

+ (CGRect)celllFrame45 {
    return CGRectMake([self cellX],
                      self.cellY + (self.cellHeight + self.cellW) * 3,
                      self.cellWidth,
                      self.cellHeight * 2 + self.cellW);
}

+ (CGRect)celllFrame56 {
    return CGRectMake([self cellX],
                      self.cellY + (self.cellHeight + self.cellW) * 4,
                      self.cellWidth,
                      self.cellHeight * 2 + self.cellW);
}

+ (CGRect)celllFrame67 {
    return CGRectMake([self cellX],
                      self.cellY + (self.cellHeight + self.cellW) * 5,
                      self.cellWidth,
                      self.cellHeight * 2 + self.cellW);
}

+ (CGRect)celllFrame78 {
    return CGRectMake([self cellX],
                      self.cellY + (self.cellHeight + self.cellW) * 6,
                      self.cellWidth,
                      self.cellHeight * 2 + self.cellW);
}

+ (CGRect)celllFrame89 {
    return CGRectMake([self cellX],
                      self.cellY + (self.cellHeight + self.cellW) * 7,
                      self.cellWidth,
                      self.cellHeight * 2 + self.cellW);
}

+ (CGRect)cellFrameWithOffset:(CGFloat)offset count:(CGFloat)count {
    return CGRectMake([self cellX],
                      self.cellY + (self.cellHeight + self.cellW) * offset,
                      [self cellWidth],
                      [self cellHeight] * count + self.cellW * (count - 1));
}

@end
