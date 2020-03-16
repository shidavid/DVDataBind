//
//  NSObject+Runtime_VAR.h
//  French
//
//  Created by DV on 2019/8/12.
//  Copyright © 2019 iOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DVRuntimeObjectModel.h"

NS_ASSUME_NONNULL_BEGIN
@class DVRuntimeObjectModel;

@interface NSObject (Runtime_VAR)

/// 获取属性property类型, 只能对于对象
@property(nonatomic, assign, readonly) PropertyType propertyType;

/// 获取属性property列表
@property(nonatomic, copy, readonly) NSArray<NSString *> *propertyList;

/// 获取所有成员属性列表 (包括property)
@property(nonatomic, copy, readonly) NSArray<NSString *> *ivarList;

/// 获取所有Property详细信息
@property(nonatomic, copy, readonly) NSArray<DVRuntimeObjectModel *> *propertyListInDetail;

/// 获取所有Ivar详细信息 (包括property)
@property(nonatomic, copy, readonly) NSArray<DVRuntimeObjectModel *> *ivarListInDetail;

/// 获取所有Property和Ivar详细信息
@property(nonatomic, copy, readonly) NSArray<DVRuntimeObjectModel *> *allListInDetail;


///将所有property的值清空
- (void)cleanAllProperyValue;

///将所有ivar的值清空
- (void)cleanAllIvarValue;

/// 获取属性property类型, 任意类型
- (PropertyType)getPropertyTypeWithName:(NSString *)propertyName;

@end

NS_ASSUME_NONNULL_END
