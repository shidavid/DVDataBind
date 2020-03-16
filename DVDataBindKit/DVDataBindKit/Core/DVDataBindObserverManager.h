//
//  DVDataBindObserverManager.h
//
//  Created by David.Shi on 2018/3/16.
//  Copyright © 2018 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DVDataBindDefine.h"
#import "DVDataBind.h"

NS_ASSUME_NONNULL_BEGIN

@interface DVDataBindObserverManager : NSObject

+ (instancetype)sharedInstance;


#pragma mark - <-- 查询绑定情况 -->
- (BOOL)queryBindStatusForTarget:(id)target
                         keyPath:(NSString *)keyPath;
- (BOOL)queryBindStatusForTarget:(id)target
                         keyPath:(NSString *)keyPath
                    controlEvent:(UIControlEvents)ctrlEvent;
- (BOOL)queryBindStatusForTarget:(id)target
                         keyPath:(NSString *)keyPath
                           index:(NSUInteger)index;


#pragma mark - <-- 获取链码 -->
- (NSString *)getChainCodeForTarget:(id)target
                            keyPath:(NSString *)keyPath;
- (NSString *)getChainCodeForTarget:(id)target
                            keyPath:(NSString *)keyPath
                       controlEvent:(UIControlEvents)ctrlEvent;
- (NSString *)getChainCodeForTarget:(id)target
                            keyPath:(NSString *)keyPath
                              index:(NSUInteger)index;


#pragma mark - <-- 绑定 -->
- (void)bindWithTarget:(id)target
               keyPath:(NSString *)keyPath
          convertBlock:(nullable DBAnyAnyBlock)convertBlock
          dataBindType:(DVDataBindType)dbType
             chainCode:(NSString *)chainCode;

- (void)bindWithTarget:(id)target
               keyPath:(NSString *)keyPath
          controlEvent:(UIControlEvents)ctrlEvent
          convertBlock:(nullable DBAnyAnyBlock)convertBlock
          dataBindType:(DVDataBindType)dbType
             chainCode:(NSString *)chainCode;

- (void)bindWithTarget:(id)target
               keyPath:(NSString *)keyPath
                 index:(NSUInteger)index
          convertBlock:(nullable DBAnyAnyBlock)convertBlock
          dataBindType:(DVDataBindType)dbType
             chainCode:(NSString *)chainCode;

- (void)bindWithOutBlock:(DBVoidAnyBlock)outBlock
                     key:(NSString *)key
               chainCode:(NSString *)chainCode;

- (void)bindWithFilterBlock:(DBBoolAnyBlock)filterBlock
                  chainCode:(NSString *)chainCode;


#pragma mark - <-- 解绑 -->
- (void)unbindWithTarget:(id)target;
- (void)unbindWithTarget:(id)target keyPath:(NSString *)keyPath;
- (void)unbindWithTarget:(id)target keyPath:(NSString *)keyPath controlEvent:(UIControlEvents)ctrlEvent;
- (void)unbindWithTarget:(id)target keyPath:(NSString *)keyPath index:(NSUInteger)index;
- (void)unbindWithTarget:(id)target keyPath:(NSString *)keyPath outBlockKey:(NSString *)key;

- (void)unbindWithTargetHash:(NSString *)targetHash;
- (void)unbindWithTargetHash:(NSString *)targetHash keyPath:(NSString *)keyPath;
- (void)unbindWithTargetHash:(NSString *)targetHash keyPath:(NSString *)keyPath controlEvent:(UIControlEvents)ctrlEvent;
- (void)unbindWithTargetHash:(NSString *)targetHash keyPath:(NSString *)keyPath index:(NSUInteger)index;
- (void)unbindWithTargetHash:(NSString *)targetHash keyPath:(NSString *)keyPath outBlockKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
