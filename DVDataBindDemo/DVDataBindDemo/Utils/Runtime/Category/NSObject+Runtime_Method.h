//
//  NSObject+Runtime_Method.h
//  French
//
//  Created by DV on 2019/8/12.
//  Copyright © 2019 iOS. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Runtime_Method)

@property(nonatomic, strong, readonly) NSArray<NSString *> *methodList;

#pragma mark - <-- 添加 实例 方法 -->
- (void)addInstanceMethod:(SEL)selector i_block:(int(^)())block;

- (void)addInstanceMethod:(SEL)selector I_block:(NSInteger(^)())block;

- (void)addInstanceMethod:(SEL)selector f_block:(float(^)())block;

- (void)addInstanceMethod:(SEL)selector d_block:(double(^)())block;

- (void)addInstanceMethod:(SEL)selector b_block:(BOOL(^)())block;

- (void)addInstanceMethod:(SEL)selector o_block:(id _Nullable(^)())block;

- (void)addInstanceMethod:(SEL)selector v_block:(void(^)())block;



#pragma mark - <-- 添加 协议 方法 -->
@property(nonatomic, strong) id runtime_delegate;

- (void)addDelegateMethod:(SEL)selector i_block:(int(^)())block;

- (void)addDelegateMethod:(SEL)selector I_block:(NSInteger(^)())block;

- (void)addDelegateMethod:(SEL)selector f_block:(float(^)())block;

- (void)addDelegateMethod:(SEL)selector d_block:(double(^)())block;

- (void)addDelegateMethod:(SEL)selector b_block:(BOOL(^)())block;

- (void)addDelegateMethod:(SEL)selector o_block:(id _Nullable(^)())block;

- (void)addDelegateMethod:(SEL)selector v_block:(void(^)())block;



#pragma mark - <-- 添加 本类 公共方法 -->
+ (void)addPublicMethod:(SEL)selector i_block:(int(^)())block;

+ (void)addPublicMethod:(SEL)selector I_block:(NSInteger(^)())block;

+ (void)addPublicMethod:(SEL)selector f_block:(float(^)())block;

+ (void)addPublicMethod:(SEL)selector d_block:(double(^)())block;

+ (void)addPublicMethod:(SEL)selector b_block:(BOOL(^)())block;

+ (void)addPublicMethod:(SEL)selector o_block:(id _Nullable(^)())block;

+ (void)addPublicMethod:(SEL)selector v_block:(void(^)())block;



#pragma mark - <-- 添加 本类 公共类方法 -->
+ (void)addClassMethod:(SEL)selector i_block:(int(^)())block;

+ (void)addClassMethod:(SEL)selector I_block:(NSInteger(^)())block;

+ (void)addClassMethod:(SEL)selector f_block:(float(^)())block;

+ (void)addClassMethod:(SEL)selector d_block:(double(^)())block;

+ (void)addClassMethod:(SEL)selector b_block:(BOOL(^)())block;

+ (void)addClassMethod:(SEL)selector o_block:(id _Nullable(^)())block;

+ (void)addClassMethod:(SEL)selector v_block:(void(^)())block;



#pragma mark - <-- 交换实现方法-->
- (void)exchangeInstanceMethodWithOriginalSel:(SEL)originalSelector
                                  swizzledSel:(SEL)swizzledSelector;

+ (void)exchangeInstanceMethodWithOriginalSel:(SEL)originalSelector
                                  swizzledSel:(SEL)swizzledSelector;



#pragma mark - <-- 执行方法 -->
/// 执行super方法
- (void)performSuperSelector:(SEL)aSelector param:(id)param;
- (void)performSuperSelector:(SEL)aSelector param1:(id)param1 param2:(id)param2;
- (void)performSuperSelector:(SEL)aSelector param1:(id)param1 param2:(id)param2 param3:(id)param3;

@end

NS_ASSUME_NONNULL_END
