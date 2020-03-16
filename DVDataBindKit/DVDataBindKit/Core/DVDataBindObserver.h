//
//  DVDataBindObserver.h
//  iOS_Test
//
//  Created by DV on 2018/8/9.
//  Copyright © 2018 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DVDataBindDefine.h"
#import "DVDataBind.h"

NS_ASSUME_NONNULL_BEGIN

@interface DVDataBindObserver : NSObject

#pragma mark - <-- Property -->
@property(nonatomic, copy, readonly) NSString *chainCode;
@property(nonatomic, assign, readonly) NSUInteger bindCount;


#pragma mark - <-- Method -->
- (instancetype)initWithChainCode:(NSString *)chainCode;


#pragma mark - <-- 判断包含 -->
- (BOOL)isContainTarget:(id)target;
- (BOOL)isContainTarget:(id)target keyPath:(NSString *)keyPath;
- (BOOL)isContainTarget:(id)target keyPath:(NSString *)keyPath controlEvent:(UIControlEvents)ctrlEvent;
- (BOOL)isContainTarget:(id)target keyPath:(NSString *)keyPath index:(NSUInteger)index;
- (BOOL)isContainTarget:(id)target keyPath:(NSString *)keyPath outBlockKey:(NSString *)key;

- (BOOL)isContainTargetHash:(NSString *)targetHash;
- (BOOL)isContainTargetHash:(NSString *)targetHash keyPath:(NSString *)keyPath;
- (BOOL)isContainTargetHash:(NSString *)targetHash keyPath:(NSString *)keyPath controlEvent:(UIControlEvents)ctrlEvent;
- (BOOL)isContainTargetHash:(NSString *)targetHash keyPath:(NSString *)keyPath index:(NSUInteger)index;
- (BOOL)isContainTargetHash:(NSString *)targetHash keyPath:(NSString *)keyPath outBlockKey:(NSString *)key;


#pragma mark - <-- 绑定 -->
- (void)bindWithTarget:(id)target
               keyPath:(NSString *)keyPath
          convertBlock:(nullable DBAnyAnyBlock)convertBlock
          dataBindType:(DVDataBindType)dbType;

- (void)bindWithTarget:(id)target
               keyPath:(NSString *)keyPath
          controlEvent:(UIControlEvents)ctrlEvent
          convertBlock:(nullable DBAnyAnyBlock)convertBlock
          dataBindType:(DVDataBindType)dbType;

- (void)bindWithTarget:(id)target
               keyPath:(NSString *)keyPath
                 index:(NSUInteger)index
          convertBlock:(nullable DBAnyAnyBlock)convertBlock
          dataBindType:(DVDataBindType)dbType;

- (void)bindWithOutBlock:(DBVoidAnyBlock)outBlock
                     key:(NSString *)key;

- (void)bindWithFilterBlock:(DBBoolAnyBlock)filterBlock;


#pragma mark - <-- 解绑 -->
- (void)unbindWithTarget:(id)target;
- (void)unbindWithTarget:(id)target keyPath:(NSString *)keyPath;
- (void)unbindWithOutBlockKey:(NSString *)key;

- (void)unbindWithTargetHash:(NSString *)targetHash;
- (void)unbindWithTargetHash:(NSString *)targetHash keyPath:(NSString *)keyPath;

@end

NS_ASSUME_NONNULL_END
