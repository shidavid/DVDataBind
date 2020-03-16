//
//  DVInfo.h
//  iOS_Template_Objc
//
//  Created by DV on 2018/1/10.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

//判断是否是ipad
#define isPad ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
//判断iPhone4系列
#define kiPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhone5系列
#define kiPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhone6 6s 7系列
#define kiPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhone6p 6sp 7p系列
#define kiPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhoneX，Xs（iPhoneX，iPhoneXs）
#define IS_IPHONE_X ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhoneXr
#define IS_IPHONE_Xr ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhoneXsMax
#define IS_IPHONE_Xs_Max ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size)&& !isPad : NO)

//判断iPhoneX所有系列
#define IS_PhoneXAll (IS_IPHONE_X || IS_IPHONE_Xr || IS_IPHONE_Xs_Max)
#define k_Height_NavContentBar 44.0f
#define k_Height_StatusBar (IS_PhoneXAll? 44.0 : 20.0)
#define k_Height_NavBar (IS_PhoneXAll ? 88.0 : 64.0)
#define k_Height_TabBar (IS_PhoneXAll ? 83.0 : 49.0)


#pragma mark - <-- Define -->
typedef NS_ENUM(NSUInteger, DVPhoneType) {
    kiPhone_2G, kiPhone_3G, kiPhone_4, kiPhone_4S, kiPhone_5,
    kiPhone_5C, kiPhone_5S, kiPhone_6, kiPhone_6P, kiPhone_6S,
    kiPhone_6SP, kiPhone_7, kiPhone_7P, kiPhone_8, kiPhone_8P,
    kiPhone_X, kiPhone_XR, kiPhone_XS, kiPhone_XSM, kiPhone_SE,
    kiPad_IPAD, k_PC, k_NULL
};


#pragma mark - <-- Class -->
/**
 APP信息 & 手机信息 工具类
 */
@interface DVInfo : NSObject

/// 项目名称
@property(nonatomic, class, readonly) NSString *projectName;

/// APP名字
@property(nonatomic, class, readonly) NSString *appName;

/// APP版本
@property(nonatomic, class, readonly) NSString *appVersion;

/// APP Build版本
@property(nonatomic, class, readonly) NSString *appBuild;

/// APP Bundle ID
@property(nonatomic, class, readonly) NSString *bundleID;

/// 手机机型
@property(nonatomic, class, readonly) DVPhoneType phoneType;

/// 是否为iPhone X 全系列
@property(nonatomic, class, readonly) BOOL isPhoneX_All;

/// UUID
@property(nonatomic, class, readonly) NSString *UUID;

/// 开发环境语言
@property(nonatomic, class, readonly) NSString *developRegion;

/// 当地地区语言
@property(nonatomic, class, readonly) NSString *localLanguage;

/// 系统语言
@property(nonatomic, class, readonly) NSString *systemLanuage;

/// APP 支持最低系统版本
@property(nonatomic, class, readonly) NSString *minimumSystemVersion;

/// 当前系统版本
@property(nonatomic, class, readonly) NSString *systemVersion;

/// 手机充电状态
@property(nonatomic, class, readonly) UIDeviceBatteryState batteryState;

/// 手机电量
@property(nonatomic, class, readonly) float batteryLevel;

/// SIM IP地址
@property(nonatomic, class, readonly) NSString *simIP;

/// WIFI IP地址
@property(nonatomic, class, readonly) NSString *wifiIP;


@end

NS_ASSUME_NONNULL_END
