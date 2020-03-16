//
//  DVDataBindObserverManager.m
//  iOS_Test
//
//  Created by DV on 2018/8/9.
//  Copyright © 2018 iOS. All rights reserved.
//

#import "DVDataBindObserverManager.h"
#import "DVDataBindObserver.h"
#import "NSObject+DataBind.h"

@interface DVDataBindObserverManager ()

@property(nonatomic, strong) NSMutableDictionary<NSString *, NSMutableSet<NSString *> *> *chainCodesForTargetHashMap;

@property(nonatomic, strong) NSMutableDictionary<NSString *, DVDataBindObserver *> *observerForChainCodeMap;

@end


@implementation DVDataBindObserverManager

#pragma mark - <-- sharedInstance -->
+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static DVDataBindObserverManager *instance = nil;
    dispatch_once(&onceToken,^{
        instance = [[super allocWithZone:NULL] init];
    });
    return instance;
}

+ (id)allocWithZone:(struct _NSZone *)zone{
    return [self sharedInstance];
}


#pragma mark - <-- Property -->
- (NSMutableDictionary<NSString *,NSMutableSet<NSString *> *> *)chainCodesForTargetHashMap {
    if (_chainCodesForTargetHashMap == nil) {
        _chainCodesForTargetHashMap = [[NSMutableDictionary alloc] init];
    }
    return _chainCodesForTargetHashMap;
}

- (NSMutableDictionary<NSString *,DVDataBindObserver *> *)observerForChainCodeMap {
    if (_observerForChainCodeMap == nil) {
        _observerForChainCodeMap = [[NSMutableDictionary alloc] init];
    }
    return _observerForChainCodeMap;
}


#pragma mark - <-------------------- Public Method -------------------->
#pragma mark - <-- 查询绑定情况 -->
- (BOOL)queryBindStatusForTarget:(id)target
                         keyPath:(NSString *)keyPath {
    return target ?
            ([self getDBObserverForTarget:target keyPath:keyPath] != nil)
            : NO;
}

- (BOOL)queryBindStatusForTarget:(id)target
                         keyPath:(NSString *)keyPath
                    controlEvent:(UIControlEvents)ctrlEvent {
    return target ?
            ([self getDBObserverForTarget:target keyPath:keyPath controlEvent:ctrlEvent] != nil)
            : NO;
}

- (BOOL)queryBindStatusForTarget:(id)target
                         keyPath:(NSString *)keyPath
                           index:(NSUInteger)index {
    return target ?
            ([self getDBObserverForTarget:target keyPath:keyPath index:index] != nil)
            : NO;
}


#pragma mark - <-- 获取链码 -->
- (NSString *)getChainCodeForTarget:(id)target
                            keyPath:(NSString *)keyPath {
    NSString *chainCode = @"";
    
    if (target) {
        DVDataBindObserver *dbObserver = [self getDBObserverForTarget:target
                                                              keyPath:keyPath];
        chainCode = dbObserver ? dbObserver.chainCode : [self newRandomChainCodeForTarget:target];
    }
    
    return chainCode;
}

- (NSString *)getChainCodeForTarget:(id)target
                            keyPath:(NSString *)keyPath
                       controlEvent:(UIControlEvents)ctrlEvent {
    NSString *chainCode = @"";
    
    if (target) {
        DVDataBindObserver *dbObserver = [self getDBObserverForTarget:target
                                                              keyPath:keyPath
                                                         controlEvent:ctrlEvent];
        chainCode = dbObserver ? dbObserver.chainCode : [self newRandomChainCodeForTarget:target];
    }
    
    return chainCode;
}

- (NSString *)getChainCodeForTarget:(id)target
                            keyPath:(NSString *)keyPath
                              index:(NSUInteger)index {
    NSString *chainCode = @"";
    
    if (target) {
        DVDataBindObserver *dbObserver = [self getDBObserverForTarget:target
                                                             keyPath:keyPath
                                                               index:index];
        chainCode = dbObserver ? dbObserver.chainCode : [self newRandomChainCodeForTarget:target];
    }
    
    return chainCode;
}


#pragma mark - <-- 绑定 -->
- (void)bindWithTarget:(id)target
               keyPath:(NSString *)keyPath
          convertBlock:(DBAnyAnyBlock)convertBlock
          dataBindType:(DVDataBindType)dbType
             chainCode:(NSString *)chainCode {
    
    if (target == nil || [chainCode isEqualToString:@""]) {
        NSLog(@"[DVDataBind ERROR]: 绑定目标和属性失败, target: %@, keyPath: %@, chainCode: %@",target,keyPath,chainCode);
        return;
    }
    
    DVDataBindObserver *dbObserver = [self getDBObserverForChainCode:chainCode];
    [dbObserver bindWithTarget:target
                       keyPath:keyPath
                  convertBlock:convertBlock
                  dataBindType:dbType];
    
    NSMutableSet<NSString *> *chainCodesSet = [self getChainCodesSetForTarget:target];
    [chainCodesSet addObject:chainCode];
}

- (void)bindWithTarget:(id)target
               keyPath:(NSString *)keyPath
          controlEvent:(UIControlEvents)ctrlEvent
          convertBlock:(DBAnyAnyBlock)convertBlock
          dataBindType:(DVDataBindType)dbType
             chainCode:(NSString *)chainCode {
    
    if (target == nil || [chainCode isEqualToString:@""]) {
        NSLog(@"[DVDataBind ERROR]: 绑定目标和属性失败, target: %@, keyPath: %@, chainCode: %@",target,keyPath,chainCode);
        return;
    }
    
    DVDataBindObserver *dbObserver = [self getDBObserverForChainCode:chainCode];
    [dbObserver bindWithTarget:target
                       keyPath:keyPath
                  controlEvent:ctrlEvent
                  convertBlock:convertBlock
                  dataBindType:dbType];
    
    NSMutableSet<NSString *> *chainCodesSet = [self getChainCodesSetForTarget:target];
    [chainCodesSet addObject:chainCode];
}

- (void)bindWithTarget:(id)target
               keyPath:(NSString *)keyPath
                 index:(NSUInteger)index
          convertBlock:(DBAnyAnyBlock)convertBlock
          dataBindType:(DVDataBindType)dbType
             chainCode:(NSString *)chainCode {
    
    if (target == nil || [chainCode isEqualToString:@""]) {
        NSLog(@"[DVDataBind ERROR]: 绑定目标和属性失败, target: %@, keyPath: %@, chainCode: %@",target,keyPath,chainCode);
        return;
    }
    
    DVDataBindObserver *dbObserver = [self getDBObserverForChainCode:chainCode];
    [dbObserver bindWithTarget:target
                       keyPath:keyPath
                         index:index
                  convertBlock:convertBlock
                  dataBindType:dbType];
    
    NSMutableSet<NSString *> *chainCodesSet = [self getChainCodesSetForTarget:target];
    [chainCodesSet addObject:chainCode];
}

- (void)bindWithOutBlock:(DBVoidAnyBlock)outBlock
                     key:(NSString *)key
               chainCode:(NSString *)chainCode {
    
    if (outBlock == nil || [chainCode isEqualToString:@""]) {
        NSLog(@"[DVDataBind ERROR]: 绑定Block失败, chainCode: %@",chainCode);
        return;
    }
    
    DVDataBindObserver *dbObserver = [self getDBObserverForChainCode:chainCode];
    [dbObserver bindWithOutBlock:outBlock key:key];
}

- (void)bindWithFilterBlock:(DBBoolAnyBlock)filterBlock chainCode:(NSString *)chainCode{
    
    if (filterBlock == nil || [chainCode isEqualToString:@""]) {
        NSLog(@"[DVDataBind ERROR]: 绑定Block失败, chainCode: %@",chainCode);
        return;
    }
    
    DVDataBindObserver *dbObserver = [self getDBObserverForChainCode:chainCode];
    [dbObserver bindWithFilterBlock:filterBlock];
}


#pragma mark - <-- 解绑 -->
- (void)unbindWithTarget:(id)target {
    if (target) {
        NSString *targetHash = [(NSObject *)target db_Hash];
        [self unbindWithTargetHash:targetHash];
    }
}

- (void)unbindWithTarget:(id)target keyPath:(NSString *)keyPath {
    if (target) {
        NSString *targetHash = [(NSObject *)target db_Hash];
        [self unbindWithTargetHash:targetHash keyPath:keyPath];
    }
}

- (void)unbindWithTarget:(id)target keyPath:(NSString *)keyPath controlEvent:(UIControlEvents)ctrlEvent {
    if (target) {
        NSString *targetHash = [(NSObject *)target db_Hash];
        [self unbindWithTargetHash:targetHash keyPath:keyPath controlEvent:ctrlEvent];
    }
}

- (void)unbindWithTarget:(id)target keyPath:(NSString *)keyPath index:(NSUInteger)index {
    if (target) {
        NSString *targetHash = [(NSObject *)target db_Hash];
        [self unbindWithTargetHash:targetHash keyPath:keyPath index:index];
    }
}

- (void)unbindWithTarget:(id)target keyPath:(NSString *)keyPath outBlockKey:(NSString *)key {
    if (target) {
        NSString *targetHash = [(NSObject *)target db_Hash];
        [self unbindWithTargetHash:targetHash keyPath:keyPath outBlockKey:key];
    }
}

- (void)unbindWithTargetHash:(NSString *)targetHash {
    
    NSArray<DVDataBindObserver *> *dbObservers = [self getDBObserverForTargetHash:targetHash];
    
    [self.chainCodesForTargetHashMap removeObjectForKey:targetHash];
    
    for (DVDataBindObserver *dbObserver in dbObservers) {
        [dbObserver unbindWithTargetHash:targetHash];
        if (dbObserver.bindCount == 0) {
            [self.observerForChainCodeMap removeObjectForKey:dbObserver.chainCode];
        }
    }
}

- (void)unbindWithTargetHash:(NSString *)targetHash keyPath:(NSString *)keyPath {

    DVDataBindObserver *dbObserver = [self getDBObserverForTargetHash:targetHash keyPath:keyPath];
    if (!dbObserver) return;
    
    [self removeChainCodesForTargetHash:targetHash chainCode:dbObserver.chainCode];
    
    [dbObserver unbindWithTargetHash:targetHash keyPath:keyPath];
    if (dbObserver.bindCount == 0) {
        [self.observerForChainCodeMap removeObjectForKey:dbObserver.chainCode];
    }
}

- (void)unbindWithTargetHash:(NSString *)targetHash keyPath:(NSString *)keyPath controlEvent:(UIControlEvents)ctrlEvent {
    
    DVDataBindObserver *dbObserver = [self getDBObserverForTargetHash:targetHash keyPath:keyPath controlEvent:ctrlEvent];
    if (!dbObserver) return;
    
    [self removeChainCodesForTargetHash:targetHash chainCode:dbObserver.chainCode];
    
    [dbObserver unbindWithTargetHash:targetHash keyPath:keyPath];
    if (dbObserver.bindCount == 0) {
        [self.observerForChainCodeMap removeObjectForKey:dbObserver.chainCode];
    }
}

- (void)unbindWithTargetHash:(NSString *)targetHash keyPath:(NSString *)keyPath index:(NSUInteger)index {
    
    DVDataBindObserver *dbObserver = [self getDBObserverForTargetHash:targetHash keyPath:keyPath index:index];
    if (!dbObserver) return;
    
    [self removeChainCodesForTargetHash:targetHash chainCode:dbObserver.chainCode];
    
    [dbObserver unbindWithTargetHash:targetHash keyPath:keyPath];
    if (dbObserver.bindCount == 0) {
        [self.observerForChainCodeMap removeObjectForKey:dbObserver.chainCode];
    }
}

- (void)unbindWithTargetHash:(NSString *)targetHash keyPath:(NSString *)keyPath outBlockKey:(nonnull NSString *)key {
    DVDataBindObserver *dbObserver = [self getDBObserverForTargetHash:targetHash keyPath:keyPath outBlockKey:key];
    if (!dbObserver) return;
    
    [dbObserver unbindWithOutBlockKey:key];
}



#pragma mark - <-------------------- Private Method -------------------->
#pragma mark - <-- Property -->
- (NSString *)chainCodePrefix {
    return @"DB";
}

- (NSString *)newRandomChainCodeForTarget:(__kindof NSObject *)target {
    NSString *newChainCode = [NSString stringWithFormat:@"%@_%@_%@",
                              self.chainCodePrefix,
                              target.db_Hash,
                              [self randomLetterAndNumber]];
    return newChainCode;
}

- (NSString *)randomLetterAndNumber {
    //定义一个包含数字，大小写字母的字符串
    NSString * strAll = @"0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    //定义一个结果
    NSMutableString *result = [[NSMutableString alloc] initWithCapacity:16];
    for (int i = 0; i < 16; ++i) {
        //获取随机数
        NSInteger index = arc4random() % (strAll.length - 1);
        char tempStr = [strAll characterAtIndex:index];
        [result appendString:[NSString stringWithFormat:@"%c",tempStr]];
    }
    
    return result;
}


#pragma mark - <-- Method -->
- (NSArray<DVDataBindObserver *> *)getDBObserverForTarget:(__kindof NSObject *)target {
    return [self getDBObserverForTargetHash:target.db_Hash];
}

- (DVDataBindObserver *)getDBObserverForTarget:(__kindof NSObject *)target
                                       keyPath:(NSString *)keyPath {
    return [self getDBObserverForTargetHash:target.db_Hash keyPath:keyPath];
}

- (DVDataBindObserver *)getDBObserverForTarget:(__kindof NSObject *)target
                                       keyPath:(NSString *)keyPath
                                  controlEvent:(UIControlEvents)ctrlEvent {
    return [self getDBObserverForTargetHash:target.db_Hash keyPath:keyPath controlEvent:ctrlEvent];
}

- (DVDataBindObserver *)getDBObserverForTarget:(__kindof NSObject *)target
                                       keyPath:(NSString *)keyPath
                                         index:(NSUInteger)index {
    return [self getDBObserverForTargetHash:target.db_Hash keyPath:keyPath index:index];
}

- (DVDataBindObserver *)getDBObserverForTarget:(__kindof NSObject *)target
                                       keyPath:(NSString *)keyPath
                                   outBlockKey:(NSString *)key {
    return [self getDBObserverForTargetHash:target.db_Hash keyPath:keyPath outBlockKey:key];
}

- (NSArray<DVDataBindObserver *> *)getDBObserverForTargetHash:(NSString *)targetHash {
    
    NSMutableArray<DVDataBindObserver *> *dbObservers = [[NSMutableArray alloc] init];
    
    NSSet<NSString *> *chainCodesSet = [self.chainCodesForTargetHashMap[targetHash] copy];
    
    if (chainCodesSet && chainCodesSet.count > 0) {
        NSArray<NSString *> *chainCodes = [chainCodesSet allObjects];
        
        for (NSString *chainCode in chainCodes) {
            DVDataBindObserver *dbObserver = self.observerForChainCodeMap[chainCode];
            if (dbObserver && [dbObserver isContainTargetHash:targetHash]) {
                [dbObservers addObject:dbObserver];
            }
        }
    }
    
    return [dbObservers copy];
}

- (DVDataBindObserver *)getDBObserverForTargetHash:(NSString *)targetHash
                                           keyPath:(NSString *)keyPath {
    
    DVDataBindObserver *dataBindObserver = nil;

    NSSet<NSString *> *chainCodesSet = [self.chainCodesForTargetHashMap[targetHash] copy];
    
    if (chainCodesSet && chainCodesSet.count > 0) {
        NSArray<NSString *> *chainCodes = [chainCodesSet allObjects];
        
        for (NSString *chainCode in chainCodes) {
            DVDataBindObserver *dbObserver = self.observerForChainCodeMap[chainCode];
            if (dbObserver
                && [dbObserver isContainTargetHash:targetHash keyPath:keyPath]) {
                dataBindObserver = dbObserver;
                break;
            }
        }
    }
    
    return dataBindObserver;
}

- (DVDataBindObserver *)getDBObserverForTargetHash:(NSString *)targetHash
                                           keyPath:(NSString *)keyPath
                                      controlEvent:(UIControlEvents)ctrlEvent {
    
    DVDataBindObserver *dataBindObserver = nil;
    
    NSSet<NSString *> *chainCodesSet = [self.chainCodesForTargetHashMap[targetHash] copy];
    
    if (chainCodesSet && chainCodesSet.count > 0) {
        NSArray<NSString *> *chainCodes = [chainCodesSet allObjects];
        
        for (NSString *chainCode in chainCodes) {
            DVDataBindObserver *dbObserver = self.observerForChainCodeMap[chainCode];
            if (dbObserver
                && [dbObserver isContainTargetHash:targetHash keyPath:keyPath controlEvent:ctrlEvent]) {
                dataBindObserver = dbObserver;
                break;
            }
        }
    }
    
    return dataBindObserver;
}

- (DVDataBindObserver *)getDBObserverForTargetHash:(NSString *)targetHash
                                           keyPath:(NSString *)keyPath
                                             index:(NSUInteger)index {
    
    DVDataBindObserver *dataBindObserver = nil;
    
    NSSet<NSString *> *chainCodesSet = [self.chainCodesForTargetHashMap[targetHash] copy];
    
    if (chainCodesSet && chainCodesSet.count > 0) {
        NSArray<NSString *> *chainCodes = [chainCodesSet allObjects];
        
        for (NSString *chainCode in chainCodes) {
            DVDataBindObserver *dbObserver = self.observerForChainCodeMap[chainCode];
            if (dbObserver
                && [dbObserver isContainTargetHash:targetHash keyPath:keyPath index:index]) {
                dataBindObserver = dbObserver;
                break;
            }
        }
    }
    
    return dataBindObserver;
}

- (DVDataBindObserver *)getDBObserverForTargetHash:(NSString *)targetHash
                                           keyPath:(NSString *)keyPath
                                       outBlockKey:(NSString *)outBlockKey {
    
    DVDataBindObserver *dataBindObserver = nil;
    
    NSSet<NSString *> *chainCodesSet = [self.chainCodesForTargetHashMap[targetHash] copy];
    
    if (chainCodesSet && chainCodesSet.count > 0) {
        NSArray<NSString *> *chainCodes = [chainCodesSet allObjects];
        
        for (NSString *chainCode in chainCodes) {
            DVDataBindObserver *dbObserver = self.observerForChainCodeMap[chainCode];
            if (dbObserver
                && [dbObserver isContainTargetHash:targetHash keyPath:keyPath outBlockKey:outBlockKey]) {
                dataBindObserver = dbObserver;
                break;
            }
        }
    }
    
    return dataBindObserver;
}

- (NSMutableSet<NSString *> *)getChainCodesSetForTarget:(id)targer {
    NSString *targetHash = ((NSObject *)targer).db_Hash;
    NSMutableSet<NSString *> *chainCodesSet = self.chainCodesForTargetHashMap[targetHash];
    if (!chainCodesSet) {
        NSMutableSet<NSString *> *newChainCodesSet = [[NSMutableSet alloc] init];
        chainCodesSet = self.chainCodesForTargetHashMap[targetHash] = newChainCodesSet;
    }
    return chainCodesSet;
}

- (DVDataBindObserver *)getDBObserverForChainCode:(NSString *)chainCode {
    DVDataBindObserver *dbObserver = self.observerForChainCodeMap[chainCode];
    if (!dbObserver) {
        DVDataBindObserver *newObserver = [[DVDataBindObserver alloc] initWithChainCode:chainCode];
        dbObserver = self.observerForChainCodeMap[chainCode] = newObserver;
    }
    return dbObserver;
}

- (void)removeChainCodesForTargetHash:(NSString *)targetHash chainCode:(NSString *)chainCode {
    NSMutableSet<NSString *> *chainCodesSet = self.chainCodesForTargetHashMap[targetHash];
    if (chainCodesSet && [chainCodesSet containsObject:chainCode]) {
        [chainCodesSet removeObject:chainCode];
        if (chainCodesSet.count == 0) {
            chainCodesSet = nil;
            [self.chainCodesForTargetHashMap removeObjectForKey:targetHash];
        }
    }
}



@end
