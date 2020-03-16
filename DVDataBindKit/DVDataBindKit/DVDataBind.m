//
//  DVDataBind.m
//
//  Created by David.Shi on 2018/3/16.
//  Copyright © 2018 iOS. All rights reserved.
//

#import "DVDataBind.h"
#import "DVDataBindObserverManager.h"

@interface DVDataBind()

@property(nonatomic, copy, readwrite) NSString *chainCode;

@end


@implementation DVDataBind

#pragma mark - <-- Property -->
+ (DVDataBindObserverManager *)dbManager {
    return [DVDataBindObserverManager sharedInstance];
}

- (DVDataBindObserverManager *)dbManager {
    return [DVDataBindObserverManager sharedInstance];
}


#pragma mark - <-- 双向绑定 -->
+ (DataBindBlock)_inout {
    return ^DVDataBind *(id target, NSString *property) {
        
        NSString *chainCode =  [self.dbManager getChainCodeForTarget:target
                                                             keyPath:property];
        [self.dbManager bindWithTarget:target
                               keyPath:property
                          convertBlock:nil
                          dataBindType:DVDataBindType_IN_OUT
                             chainCode:chainCode];
        
        DVDataBind *db = [[DVDataBind alloc] init];
        db.chainCode = chainCode;
        return db;
    };
}

+ (DataBindUIBlock)_inout_ui {
    return ^DVDataBind *(id target, NSString *property, UIControlEvents controlEvent) {
        
        NSString *chainCode =  [self.dbManager getChainCodeForTarget:target
                                                             keyPath:property
                                                        controlEvent:controlEvent];
        [self.dbManager bindWithTarget:target
                               keyPath:property
                          controlEvent:controlEvent
                          convertBlock:nil
                          dataBindType:DVDataBindType_IN_OUT
                             chainCode:chainCode];
        
        DVDataBind *db = [[DVDataBind alloc] init];
        db.chainCode = chainCode;
        
        return db;
    };
}

+ (DataBindNotBlock)_inout_not {
    return ^DVDataBind *(id target, NSString *property) {
        NSString *chainCode =  [self.dbManager getChainCodeForTarget:target
                                                             keyPath:property];
        [self.dbManager bindWithTarget:target
                               keyPath:property
                          convertBlock:nil
                          dataBindType:DVDataBindType_IN_OUT_NOT
                             chainCode:chainCode];
        
        DVDataBind *db = [[DVDataBind alloc] init];
        db.chainCode = chainCode;
        return db;
    };
}

+ (DataBindUINotBlock)_inout_ui_not {
    return ^DVDataBind *(id target, NSString *property, UIControlEvents controlEvent) {
        NSString *chainCode =  [self.dbManager getChainCodeForTarget:target
                                                             keyPath:property];
        [self.dbManager bindWithTarget:target
                               keyPath:property
                          controlEvent:controlEvent
                          convertBlock:nil
                          dataBindType:DVDataBindType_IN_OUT_NOT
                             chainCode:chainCode];
        
        DVDataBind *db = [[DVDataBind alloc] init];
        db.chainCode = chainCode;
        return db;
    };
}

+ (DataBindConvertBlock)_inout_cv {
    return ^DVDataBind *(id target, NSString *property, DBAnyAnyBlock block) {
        NSString *chainCode =  [self.dbManager getChainCodeForTarget:target
                                                             keyPath:property];
        [self.dbManager bindWithTarget:target
                               keyPath:property
                          convertBlock:block
                          dataBindType:DVDataBindType_IN_OUT
                             chainCode:chainCode];
        
        DVDataBind *db = [[DVDataBind alloc] init];
        db.chainCode = chainCode;
        return db;
    };
}

+ (DataBindUIConvertBlock)_inout_ui_cv {
    return ^DVDataBind *(id target, NSString *property, UIControlEvents controlEvent, DBAnyAnyBlock block) {
        
        NSString *chainCode =  [self.dbManager getChainCodeForTarget:target
                                                             keyPath:property
                                                        controlEvent:controlEvent];
        [self.dbManager bindWithTarget:target
                               keyPath:property
                          controlEvent:controlEvent
                          convertBlock:block
                          dataBindType:DVDataBindType_IN_OUT
                             chainCode:chainCode];
        
        DVDataBind *db = [[DVDataBind alloc] init];
        db.chainCode = chainCode;
        
        return db;
    };
}

+ (DataBindArrayBlock)_inout_arr {
    return ^DVDataBind *(id target, NSString *property, NSUInteger index) {
        
        NSString *chainCode =  [self.dbManager getChainCodeForTarget:target keyPath:property index:index];
        [self.dbManager bindWithTarget:target
                               keyPath:property
                                 index:index
                          convertBlock:nil
                          dataBindType:DVDataBindType_IN_OUT
                             chainCode:chainCode];
        
        DVDataBind *db = [[DVDataBind alloc] init];
        db.chainCode = chainCode;
        
        return db;
    };
}



- (DataBindBlock)_inout {
    return ^DVDataBind *(id target, NSString *property) {
        [self.dbManager bindWithTarget:target
                               keyPath:property
                          convertBlock:nil
                          dataBindType:DVDataBindType_IN_OUT
                             chainCode:self.chainCode];
        return self;
    };
}

- (DataBindUIBlock)_inout_ui {
    return ^DVDataBind *(id target, NSString *property, UIControlEvents controlEvent) {
        [self.dbManager bindWithTarget:target
                               keyPath:property
                          controlEvent:controlEvent
                          convertBlock:nil
                          dataBindType:DVDataBindType_IN_OUT
                             chainCode:self.chainCode];
        return self;
    };
}

- (DataBindNotBlock)_inout_not {
    return ^DVDataBind *(id target, NSString *property) {
        [self.dbManager bindWithTarget:target
                               keyPath:property
                          convertBlock:nil
                          dataBindType:DVDataBindType_IN_OUT_NOT
                             chainCode:self.chainCode];
        return self;
    };
}

- (DataBindUINotBlock)_inout_ui_not {
    return ^DVDataBind *(id target, NSString *property, UIControlEvents controlEvent) {
        [self.dbManager bindWithTarget:target
                               keyPath:property
                          controlEvent:controlEvent
                          convertBlock:nil
                          dataBindType:DVDataBindType_IN_OUT_NOT
                             chainCode:self.chainCode];
        return self;
    };
}

- (DataBindConvertBlock)_inout_cv {
    return ^DVDataBind *(id target, NSString *property, DBAnyAnyBlock block) {
        [self.dbManager bindWithTarget:target
                               keyPath:property
                          convertBlock:block
                          dataBindType:DVDataBindType_IN_OUT
                             chainCode:self.chainCode];
        return self;
    };
}

- (DataBindUIConvertBlock)_inout_ui_cv {
    return ^DVDataBind *(id target, NSString *property, UIControlEvents controlEvent, DBAnyAnyBlock block) {
        [self.dbManager bindWithTarget:target
                               keyPath:property
                          controlEvent:controlEvent
                          convertBlock:block
                          dataBindType:DVDataBindType_IN_OUT
                             chainCode:self.chainCode];
        return self;
    };
}

- (DataBindArrayBlock)_inout_arr {
    return ^DVDataBind *(id target, NSString *property, NSUInteger index) {
        [self.dbManager bindWithTarget:target
                               keyPath:property
                                 index:index
                          convertBlock:nil
                          dataBindType:DVDataBindType_IN_OUT
                             chainCode:self.chainCode];
        return self;
    };
}


#pragma mark - <-- 单向绑定(数据更新,只发送新数据,不接受) -->
+ (DataBindBlock)_in {
    return ^DVDataBind *(id target, NSString *property) {
        
        NSString *chainCode =  [self.dbManager getChainCodeForTarget:target
                                                             keyPath:property];
        [self.dbManager bindWithTarget:target
                               keyPath:property
                          convertBlock:nil
                          dataBindType:DVDataBindType_IN
                             chainCode:chainCode];
        
        DVDataBind *db = [[DVDataBind alloc] init];
        db.chainCode = chainCode;
        return db;
    };
}

+ (DataBindUIBlock)_in_ui {
    return ^DVDataBind *(id target, NSString *property, UIControlEvents controlEvent) {
        
        NSString *chainCode =  [self.dbManager getChainCodeForTarget:target
                                                             keyPath:property
                                                        controlEvent:controlEvent];
        [self.dbManager bindWithTarget:target
                               keyPath:property
                          controlEvent:controlEvent
                          convertBlock:nil
                          dataBindType:DVDataBindType_IN
                             chainCode:chainCode];
        
        DVDataBind *db = [[DVDataBind alloc] init];
        db.chainCode = chainCode;
        
        return db;
    };
}

+ (DataBindNotBlock)_in_not {
    return ^DVDataBind *(id target, NSString *property) {
        NSString *chainCode =  [self.dbManager getChainCodeForTarget:target
                                                             keyPath:property];
        [self.dbManager bindWithTarget:target
                               keyPath:property
                          convertBlock:nil
                          dataBindType:DVDataBindType_IN_NOT
                             chainCode:chainCode];
        
        DVDataBind *db = [[DVDataBind alloc] init];
        db.chainCode = chainCode;
        return db;
    };
}

+ (DataBindUINotBlock)_in_ui_not {
    return ^DVDataBind *(id target, NSString *property, UIControlEvents controlEvent) {
        NSString *chainCode =  [self.dbManager getChainCodeForTarget:target
                                                             keyPath:property];
        [self.dbManager bindWithTarget:target
                               keyPath:property
                          controlEvent:controlEvent
                          convertBlock:nil
                          dataBindType:DVDataBindType_IN_NOT
                             chainCode:chainCode];
        
        DVDataBind *db = [[DVDataBind alloc] init];
        db.chainCode = chainCode;
        return db;
    };
}

+ (DataBindConvertBlock)_in_cv {
    return ^DVDataBind *(id target, NSString *property, DBAnyAnyBlock block) {
        NSString *chainCode =  [self.dbManager getChainCodeForTarget:target
                                                             keyPath:property];
        [self.dbManager bindWithTarget:target
                               keyPath:property
                          convertBlock:block
                          dataBindType:DVDataBindType_IN
                             chainCode:chainCode];
        
        DVDataBind *db = [[DVDataBind alloc] init];
        db.chainCode = chainCode;
        return db;
    };
}

+ (DataBindUIConvertBlock)_in_ui_cv {
    return ^DVDataBind *(id target, NSString *property, UIControlEvents controlEvent, DBAnyAnyBlock block) {
        
        NSString *chainCode =  [self.dbManager getChainCodeForTarget:target
                                                             keyPath:property
                                                        controlEvent:controlEvent];
        [self.dbManager bindWithTarget:target
                               keyPath:property
                          controlEvent:controlEvent
                          convertBlock:block
                          dataBindType:DVDataBindType_IN
                             chainCode:chainCode];
        
        DVDataBind *db = [[DVDataBind alloc] init];
        db.chainCode = chainCode;
        
        return db;
    };
}

+ (DataBindArrayBlock)_in_arr {
    return ^DVDataBind *(id target, NSString *property, NSUInteger index) {
        
        NSString *chainCode =  [self.dbManager getChainCodeForTarget:target keyPath:property index:index];
        [self.dbManager bindWithTarget:target
                               keyPath:property
                                 index:index
                          convertBlock:nil
                          dataBindType:DVDataBindType_IN
                             chainCode:chainCode];
        
        DVDataBind *db = [[DVDataBind alloc] init];
        db.chainCode = chainCode;
        
        return db;
    };
}



- (DataBindBlock)_in {
    return ^DVDataBind *(id target, NSString *property) {
        [self.dbManager bindWithTarget:target
                               keyPath:property
                          convertBlock:nil
                          dataBindType:DVDataBindType_IN
                             chainCode:self.chainCode];
        return self;
    };
}

- (DataBindUIBlock)_in_ui {
    return ^DVDataBind *(id target, NSString *property, UIControlEvents controlEvent) {
        [self.dbManager bindWithTarget:target
                               keyPath:property
                          controlEvent:controlEvent
                          convertBlock:nil
                          dataBindType:DVDataBindType_IN
                             chainCode:self.chainCode];
        return self;
    };
}

- (DataBindNotBlock)_in_not {
    return ^DVDataBind *(id target, NSString *property) {
        [self.dbManager bindWithTarget:target
                               keyPath:property
                          convertBlock:nil
                          dataBindType:DVDataBindType_IN_NOT
                             chainCode:self.chainCode];
        return self;
    };
}

- (DataBindUINotBlock)_in_ui_not {
    return ^DVDataBind *(id target, NSString *property, UIControlEvents controlEvent) {
        [self.dbManager bindWithTarget:target
                               keyPath:property
                          controlEvent:controlEvent
                          convertBlock:nil
                          dataBindType:DVDataBindType_IN_NOT
                             chainCode:self.chainCode];
        return self;
    };
}

- (DataBindConvertBlock)_in_cv {
    return ^DVDataBind *(id target, NSString *property, DBAnyAnyBlock block) {
        [self.dbManager bindWithTarget:target
                               keyPath:property
                          convertBlock:block
                          dataBindType:DVDataBindType_IN
                             chainCode:self.chainCode];
        return self;
    };
}

- (DataBindUIConvertBlock)_in_ui_cv {
    return ^DVDataBind *(id target, NSString *property, UIControlEvents controlEvent, DBAnyAnyBlock block) {
        [self.dbManager bindWithTarget:target
                               keyPath:property
                          controlEvent:controlEvent
                          convertBlock:block
                          dataBindType:DVDataBindType_IN
                             chainCode:self.chainCode];
        return self;
    };
}

- (DataBindArrayBlock)_in_arr {
    return ^DVDataBind *(id target, NSString *property, NSUInteger index) {
        [self.dbManager bindWithTarget:target
                               keyPath:property
                                 index:index
                          convertBlock:nil
                          dataBindType:DVDataBindType_IN
                             chainCode:self.chainCode];
        return self;
    };
}



#pragma mark - <-- 单向绑定(数据更新,只接受新数据,不发送) -->
- (DataBindBlock)_out {
    return ^DVDataBind *(id target, NSString *property) {
        [self.dbManager bindWithTarget:target
                               keyPath:property
                          convertBlock:nil
                          dataBindType:DVDataBindType_OUT
                             chainCode:self.chainCode];
        return self;
    };
}

- (DataBindUIBlock)_out_ui {
    return ^DVDataBind *(id target, NSString *property, UIControlEvents controlEvent) {
        [self.dbManager bindWithTarget:target
                               keyPath:property
                          controlEvent:controlEvent
                          convertBlock:nil
                          dataBindType:DVDataBindType_OUT
                             chainCode:self.chainCode];
        return self;
    };
}

- (DataBindNotBlock)_out_not {
    return ^DVDataBind *(id target, NSString *property) {
        [self.dbManager bindWithTarget:target
                               keyPath:property
                          convertBlock:nil
                          dataBindType:DVDataBindType_OUT_NOT
                             chainCode:self.chainCode];
        return self;
    };
}

- (DataBindUINotBlock)_out_ui_not {
    return ^DVDataBind *(id target, NSString *property, UIControlEvents controlEvent) {
        [self.dbManager bindWithTarget:target
                               keyPath:property
                          controlEvent:controlEvent
                          convertBlock:nil
                          dataBindType:DVDataBindType_OUT_NOT
                             chainCode:self.chainCode];
        return self;
    };
}

- (DataBindConvertBlock)_out_cv {
    return ^DVDataBind *(id target, NSString *property, DBAnyAnyBlock block) {
        [self.dbManager bindWithTarget:target
                               keyPath:property
                          convertBlock:block
                          dataBindType:DVDataBindType_OUT
                             chainCode:self.chainCode];
        return self;
    };
}

- (DataBindUIConvertBlock)_out_ui_cv {
    return ^DVDataBind *(id target, NSString *property, UIControlEvents controlEvent, DBAnyAnyBlock block) {
        [self.dbManager bindWithTarget:target
                               keyPath:property
                          controlEvent:controlEvent
                          convertBlock:block
                          dataBindType:DVDataBindType_OUT
                             chainCode:self.chainCode];
        return self;
    };
}

- (DataBindArrayBlock)_out_arr {
    return ^DVDataBind *(id target, NSString *property, NSUInteger index) {
        [self.dbManager bindWithTarget:target
                               keyPath:property
                                 index:index
                          convertBlock:nil
                          dataBindType:DVDataBindType_OUT
                             chainCode:self.chainCode];
        return self;
    };
}

- (DataBindKeyAnyOutBlock)_out_key_any {
    return ^DVDataBind *(NSString *key, DBVoidAnyBlock block) {
        [self.dbManager bindWithOutBlock:block key:key chainCode:self.chainCode];
        return self;
    };
}


#pragma mark - <-- 特殊额外处理绑定 -->
- (DataBindFilterBlock)_filter {
    return ^DVDataBind *(DBBoolAnyBlock block) {
        [self.dbManager bindWithFilterBlock:block chainCode:self.chainCode];
        return self;
    };
}


#pragma mark - <-- 解绑 -->
+ (void)unbindWithTarget:(id)target {
    [self.dbManager unbindWithTarget:target];
}

+ (void)unbindWithTarget:(id)target property:(NSString *)property {
    [self.dbManager unbindWithTarget:target keyPath:property];
}

+ (void)unbindWithTarget:(id)target property:(NSString *)property index:(NSInteger)index {
    [self.dbManager unbindWithTarget:target keyPath:property index:index];
}

+ (void)unbindWithTarget:(id)target property:(NSString *)property controlEvent:(UIControlEvents)ctrlEvent {
    [self.dbManager unbindWithTarget:target keyPath:property controlEvent:ctrlEvent];
}

+ (void)unbindWithTarget:(id)target property:(NSString *)property outBlockKey:(NSString *)key {
    [self.dbManager unbindWithTarget:target keyPath:property outBlockKey:key];
}


#pragma mark - <-- 查询绑定情况 -->
+ (BOOL)queryBindStatusForTarget:(id)target property:(NSString *)property {
    return [self.dbManager queryBindStatusForTarget:target keyPath:property];
}

+ (BOOL)queryBindStatusForTarget:(id)target property:(NSString *)property index:(NSUInteger)index {
    return [self.dbManager queryBindStatusForTarget:target keyPath:property index:index];
}

+ (BOOL)queryBindStatusForTarget:(id)target property:(NSString *)property controlEvent:(UIControlEvents)ctrlEvent {
    return [self.dbManager queryBindStatusForTarget:target keyPath:property controlEvent:ctrlEvent];
}


@end
