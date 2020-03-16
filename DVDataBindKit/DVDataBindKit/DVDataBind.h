//
//  DVDataBind.h
//
//  Created by David.Shi on 2018/3/16.
//  Copyright © 2018 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


#pragma mark - <-------------------- Typedef -------------------->
@class DVDataBind;
typedef void(^DBVoidAnyBlock)();
typedef BOOL(^DBBoolAnyBlock)();
typedef id(^DBAnyAnyBlock)();

typedef DVDataBind *_Nonnull(^DataBindBlock)(id target, NSString *property);
typedef DVDataBind *_Nonnull(^DataBindUIBlock)(id target, NSString *property, UIControlEvents controlEvent);
typedef DVDataBind *_Nonnull(^DataBindNotBlock)(id target, NSString *property);
typedef DVDataBind *_Nonnull(^DataBindUINotBlock)(id target, NSString *property, UIControlEvents controlEvent);
typedef DVDataBind *_Nonnull(^DataBindConvertBlock)(id target, NSString *property, DBAnyAnyBlock block);
typedef DVDataBind *_Nonnull(^DataBindUIConvertBlock)(id target, NSString *property, UIControlEvents controlEvent, DBAnyAnyBlock block);
typedef DVDataBind *_Nonnull(^DataBindArrayBlock)(id target, NSString *property, NSUInteger index);
typedef DVDataBind *_Nonnull(^DataBindKeyAnyOutBlock)(NSString *key, DBVoidAnyBlock block);
typedef DVDataBind *_Nonnull(^DataBindFilterBlock)(DBBoolAnyBlock block);


#pragma mark - <-------------------- Class -------------------->
/**
 数据双向绑定
 @code
 UITextField *textField;
 UILabel *lable;
 
 DVDataBind
 ._inout(self.textField, @"text", UIControlEventEditingChanged)
 ._inout(self.label, @"text")
 ._filter(^BOOL(NSString *string) {
    //string 处理
    return YES/NO; //返回YES可更新新值
 })
 ._out_key_any(@"com.key.xxx", ^(NSString *string){
    //string 处理
 });
 @endcode
 */
@interface DVDataBind : NSObject

#pragma mark - <-- Property -->
/// 链码
@property(nonatomic, copy, readonly) NSString *chainCode;


#pragma mark - <-- 双向绑定 -->
+ (DataBindBlock)_inout;
+ (DataBindUIBlock)_inout_ui;
+ (DataBindNotBlock)_inout_not;
+ (DataBindUINotBlock)_inout_ui_not;
+ (DataBindConvertBlock)_inout_cv;
+ (DataBindUIConvertBlock)_inout_ui_cv;
+ (DataBindArrayBlock)_inout_arr;


- (DataBindBlock)_inout;
- (DataBindUIBlock)_inout_ui;
- (DataBindNotBlock)_inout_not;
- (DataBindUINotBlock)_inout_ui_not;
- (DataBindConvertBlock)_inout_cv;
- (DataBindUIConvertBlock)_inout_ui_cv;
- (DataBindArrayBlock)_inout_arr;


#pragma mark - <-- 单向绑定(数据更新,只发送新数据,不接受) -->
+ (DataBindBlock)_in;
+ (DataBindUIBlock)_in_ui;
+ (DataBindNotBlock)_in_not;
+ (DataBindUINotBlock)_in_ui_not;
+ (DataBindConvertBlock)_in_cv;
+ (DataBindUIConvertBlock)_in_ui_cv;
+ (DataBindArrayBlock)_in_arr;


- (DataBindBlock)_in;
- (DataBindUIBlock)_in_ui;
- (DataBindNotBlock)_in_not;
- (DataBindUINotBlock)_in_ui_not;
- (DataBindConvertBlock)_in_cv;
- (DataBindUIConvertBlock)_in_ui_cv;
- (DataBindArrayBlock)_in_arr;


#pragma mark - <-- 单向绑定(数据更新,只接受新数据,不发送) -->
- (DataBindBlock)_out;
- (DataBindUIBlock)_out_ui;
- (DataBindNotBlock)_out_not;
- (DataBindUINotBlock)_out_ui_not;
- (DataBindConvertBlock)_out_cv;
- (DataBindUIConvertBlock)_out_ui_cv;
- (DataBindArrayBlock)_out_arr;
- (DataBindKeyAnyOutBlock)_out_key_any;


#pragma mark - <-- 特殊额外处理绑定 -->
- (DataBindFilterBlock)_filter;




#pragma mark - <-- 解除绑定 -->
+ (void)unbindWithTarget:(id)target;
+ (void)unbindWithTarget:(id)target property:(NSString *)property;
+ (void)unbindWithTarget:(id)target property:(NSString *)property index:(NSInteger)index;
+ (void)unbindWithTarget:(id)target property:(NSString *)property controlEvent:(UIControlEvents)ctrlEvent;
+ (void)unbindWithTarget:(id)target property:(NSString *)property outBlockKey:(NSString *)key;


#pragma mark - <-- 查询绑定情况 -->
+ (BOOL)queryBindStatusForTarget:(id)target property:(NSString *)property;
+ (BOOL)queryBindStatusForTarget:(id)target property:(NSString *)property index:(NSUInteger)index;
+ (BOOL)queryBindStatusForTarget:(id)target property:(NSString *)property controlEvent:(UIControlEvents)ctrlEvent;

@end

NS_ASSUME_NONNULL_END
