//
//  DVFrame.h
//   
//
//  Created by DV on 2018/2/10.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

#define CGSizeOne CGSizeMake(1, 1)

@interface DVFrame : NSObject

@property(nonatomic, class, readonly) CGFloat width;
@property(nonatomic, class, readonly) CGFloat height;
@property(nonatomic, class, readonly) CGFloat height_not_nav;

@property(nonatomic, class, readonly) CGFloat statusBarHeight;
@property(nonatomic, class, readonly) CGFloat navBarHeight;
@property(nonatomic, class, readonly) CGFloat tabBarHeight;

@property(nonatomic, class, readonly) CGRect  bounds;
@property(nonatomic, class, readonly) CGRect  frame;
@property(nonatomic, class, readonly) CGRect  frame_full;
@property(nonatomic, class, readonly) CGRect  frame_not_nav;

@property(nonatomic, class, readonly) CGFloat switchWidth;
@property(nonatomic, class, readonly) CGFloat switchHeight;

@property(nonatomic, class, readonly) CGRect celllFrameTop;
@property(nonatomic, class, readonly) CGRect celllFrame1;
@property(nonatomic, class, readonly) CGRect celllFrame2;
@property(nonatomic, class, readonly) CGRect celllFrame3;
@property(nonatomic, class, readonly) CGRect celllFrame4;
@property(nonatomic, class, readonly) CGRect celllFrame5;
@property(nonatomic, class, readonly) CGRect celllFrame6;
@property(nonatomic, class, readonly) CGRect celllFrame7;
@property(nonatomic, class, readonly) CGRect celllFrame8;
@property(nonatomic, class, readonly) CGRect celllFrame9;

@property(nonatomic, class, readonly) CGRect celllFrame12;
@property(nonatomic, class, readonly) CGRect celllFrame23;
@property(nonatomic, class, readonly) CGRect celllFrame34;
@property(nonatomic, class, readonly) CGRect celllFrame45;
@property(nonatomic, class, readonly) CGRect celllFrame56;
@property(nonatomic, class, readonly) CGRect celllFrame67;
@property(nonatomic, class, readonly) CGRect celllFrame78;
@property(nonatomic, class, readonly) CGRect celllFrame89;

+ (CGRect)cellFrameWithOffset:(CGFloat)offset count:(CGFloat)count;

@end
