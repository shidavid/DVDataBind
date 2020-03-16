//
//  NSObject+Runtime_Class.h
//  French
//
//  Created by DV on 2019/8/12.
//  Copyright © 2019 iOS. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Runtime_Class)

#pragma mark - <-- 获取信息 -->
/// 获取本类
- (Class)getClass;

/// 获取本类
+ (Class)getClass;


/// 获取元类
- (Class)getMetaClass;

/// 获取元类
+ (Class)getMetaClass;


///获取本类的类名
- (NSString *)getClassName;

///获取本类的类名
+ (NSString *)getClassName;


#pragma mark - <-- Method -->
- (void)changeToClass:(Class)aClass;

@end

NS_ASSUME_NONNULL_END
