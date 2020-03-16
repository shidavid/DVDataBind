//
//  AppDelegate+Notification.h
//  MM
//
//  Created by DV on 2019/8/27.
//  Copyright © 2019 iOS. All rights reserved.
//

#import "AppDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface AppDelegate (Notification)

/// 添加全局通知监听
- (void)addGlobalNotification;

/// 移除全局通知监听,一般情况下不用移除
- (void)removeGlobalNotification;

@end

NS_ASSUME_NONNULL_END
