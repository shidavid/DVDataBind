//
//  DVDataBindObserver.m
//  iOS_Test
//
//  Created by DV on 2018/8/9.
//  Copyright © 2018 iOS. All rights reserved.
//

#import "DVDataBindObserver.h"
#import "DVDataBindObserverModel.h"
#import "NSObject+DataBind.h"
#import "NSString+DataBind.h"
#import "NSNumber+DataBind.h"

@interface DVDataBindObserver ()

@property(nonatomic, copy, readwrite) NSString *chainCode;

@property(nonatomic, strong) NSMutableDictionary<NSString *, DVDataBindObserverModel *> *modelForTargetKeyHashMap;
@property(nonatomic, strong) NSMutableDictionary<NSString *, DBVoidAnyBlock> *outBlockForKeyMap;
@property(nonatomic, copy) DBBoolAnyBlock filterBlock;

@end


@implementation DVDataBindObserver

#pragma mark - <-- Instance -->
- (instancetype)initWithChainCode:(NSString *)chainCode {
    self = [super init];
    if (self) {
        self.chainCode = chainCode;
    }
    return self;
}

- (void)dealloc {
    if (_modelForTargetKeyHashMap) {
        [_modelForTargetKeyHashMap removeAllObjects];
    }
    if (_outBlockForKeyMap) {
        [_outBlockForKeyMap removeAllObjects];
    }
    _filterBlock = nil;
}


#pragma mark - <-- Property -->
- (NSUInteger)bindCount {
    return self.modelForTargetKeyHashMap.allValues.count;
}

- (NSMutableDictionary<NSString *,DVDataBindObserverModel *> *)modelForTargetKeyHashMap {
    if (_modelForTargetKeyHashMap == nil) {
        _modelForTargetKeyHashMap = [[NSMutableDictionary alloc] init];
    }
    return _modelForTargetKeyHashMap;
}

- (NSMutableDictionary<NSString *,DBVoidAnyBlock> *)outBlockForKeyMap {
    if (_outBlockForKeyMap == nil) {
        _outBlockForKeyMap = [[NSMutableDictionary alloc] init];
    }
    return _outBlockForKeyMap;
}


#pragma mark - <-------------------- Private Method -------------------->
- (NSString *)getTargetKeyHash:(__kindof NSObject *)target keyPath:(NSString *)keyPath {
    return [NSString stringWithFormat:@"%@_%@", target.db_Hash, keyPath];
}

- (void)bindDBTargetModelWithTarget:(__kindof NSObject *)target {
    DVDataBindTargetModel *dbTargetModel = target.db_targetModel;
    if (dbTargetModel == nil) {
        NSString *targetHash = target.db_Hash;
        dbTargetModel = [[DVDataBindTargetModel alloc] initWithTargetHash:targetHash];
        target.db_targetModel = dbTargetModel;
    }
}


#pragma mark - <-------------------- Public Method -------------------->
#pragma mark - <-- 判断包含 -->
- (BOOL)isContainTarget:(id)target {
    NSString *targetHash = [(NSObject *)target db_Hash];
    return [self isContainTargetHash:targetHash];
}

- (BOOL)isContainTarget:(id)target
                keyPath:(NSString *)keyPath {
    NSString *targetHash = [(NSObject *)target db_Hash];
    return [self isContainTargetHash:targetHash keyPath:keyPath];
}

- (BOOL)isContainTarget:(id)target
                keyPath:(NSString *)keyPath
           controlEvent:(UIControlEvents)ctrlEvent {
    NSString *targetHash = [(NSObject *)target db_Hash];
    return [self isContainTargetHash:targetHash keyPath:keyPath controlEvent:ctrlEvent];
}

- (BOOL)isContainTarget:(id)target
                keyPath:(NSString *)keyPath
                  index:(NSUInteger)index {
    NSString *targetHash = [(NSObject *)target db_Hash];
    return [self isContainTargetHash:targetHash keyPath:keyPath index:index];
}

- (BOOL)isContainTarget:(id)target
                keyPath:(NSString *)keyPath
            outBlockKey:(NSString *)key {
    NSString *targetHash = [(NSObject *)target db_Hash];
    return [self isContainTargetHash:targetHash keyPath:keyPath outBlockKey:key];
}

- (BOOL)isContainTargetHash:(NSString *)targetHash {
    NSArray<NSString *> *targetKeyHashs = self.modelForTargetKeyHashMap.allKeys;
    BOOL isContainTarget = NO;
    
    for (NSString *targetKeyHash in targetKeyHashs) {
        if ([targetKeyHash hasPrefix:targetHash]) {
            isContainTarget = YES;
            break;
        }
    }
    
    return isContainTarget;
}

- (BOOL)isContainTargetHash:(NSString *)targetHash
                    keyPath:(NSString *)keyPath {
    NSString *targetKeyHash = [NSString stringWithFormat:@"%@_%@",targetHash,keyPath];
    return self.modelForTargetKeyHashMap[targetKeyHash] ? YES : NO;
}

- (BOOL)isContainTargetHash:(NSString *)targetHash
                    keyPath:(NSString *)keyPath
               controlEvent:(UIControlEvents)ctrlEvent {
    NSString *targetKeyHash = [NSString stringWithFormat:@"%@_%@",targetHash,keyPath];
    DVDataBindObserverModel *model = self.modelForTargetKeyHashMap[targetKeyHash];
    return (model && model.ctrlEvent == ctrlEvent) ? YES : NO;
}

- (BOOL)isContainTargetHash:(NSString *)targetHash
                    keyPath:(NSString *)keyPath
                      index:(NSUInteger)index {
    NSString *targetKeyHash = [NSString stringWithFormat:@"%@_%@",targetHash,keyPath];
    DVDataBindObserverModel *model = self.modelForTargetKeyHashMap[targetKeyHash];
    return (model && model.index == index) ? YES : NO;
}

- (BOOL)isContainTargetHash:(NSString *)targetHash
                    keyPath:(NSString *)keyPath
                outBlockKey:(NSString *)key {
    NSString *targetKeyHash = [NSString stringWithFormat:@"%@_%@",targetHash,keyPath];
    DVDataBindObserverModel *model = self.modelForTargetKeyHashMap[targetKeyHash];
    return (model && self.outBlockForKeyMap[key]) ? YES : NO;
}


#pragma mark - <-- 绑定 -->
- (void)bindWithTarget:(id)target
               keyPath:(NSString *)keyPath
          convertBlock:(DBAnyAnyBlock)convertBlock
          dataBindType:(DVDataBindType)dbType {
    
    NSString *targetKeyHash = [self getTargetKeyHash:target keyPath:keyPath];
    if (self.modelForTargetKeyHashMap[targetKeyHash]) {
        [self.modelForTargetKeyHashMap removeObjectForKey:targetKeyHash];
    }
    
    if ((dbType & DVDataBindType_IN) == DVDataBindType_IN) {
        [target addObserver:self
                 forKeyPath:keyPath
                    options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew
                    context:nil];
    }
   
    DVDataBindObserverModel *obsModel;
    obsModel = [[DVDataBindObserverModel alloc] initWithObserver:self
                                                          target:target
                                                         keyPath:keyPath
                                                         context:nil
                                                    convertBlock:convertBlock
                                                    databindType:dbType];
    self.modelForTargetKeyHashMap[targetKeyHash] = obsModel;
    
    [self bindDBTargetModelWithTarget:target];
}

- (void)bindWithTarget:(id)target
               keyPath:(NSString *)keyPath
          controlEvent:(UIControlEvents)ctrlEvent
          convertBlock:(DBAnyAnyBlock)convertBlock
          dataBindType:(DVDataBindType)dbType {
   
    NSString *targetKeyHash = [self getTargetKeyHash:target keyPath:keyPath];
    if (self.modelForTargetKeyHashMap[targetKeyHash]) {
        [self.modelForTargetKeyHashMap removeObjectForKey:targetKeyHash];
    }
    
    if ((dbType & DVDataBindType_IN) == DVDataBindType_IN) {
        [target addTarget:self
                   action:@selector(onRespondForUIByEvents:)
         forControlEvents:ctrlEvent];
    }
    
    DVDataBindObserverModel *obsModel;
    obsModel = [[DVDataBindObserverModel alloc] initWithObserver:self
                                                          target:target
                                                         keyPath:keyPath
                                                        selector:@selector(onRespondForUIByEvents:)
                                                    controlEvent:ctrlEvent
                                                    convertBlock:convertBlock
                                                    databindType:dbType];
    self.modelForTargetKeyHashMap[targetKeyHash] = obsModel;
    
    ((NSObject *)target).db_ctrl_targetKeyHash = targetKeyHash;
    
    [self bindDBTargetModelWithTarget:target];
}

- (void)bindWithTarget:(id)target
               keyPath:(NSString *)keyPath
                 index:(NSUInteger)index
          convertBlock:(DBAnyAnyBlock)convertBlock
          dataBindType:(DVDataBindType)dbType {
    
    NSString *targetKeyHash = [self getTargetKeyHash:target keyPath:keyPath];
    if (self.modelForTargetKeyHashMap[targetKeyHash]) {
        [self.modelForTargetKeyHashMap removeObjectForKey:targetKeyHash];
    }
    
    if ((dbType & DVDataBindType_IN) == DVDataBindType_IN) {
        [target addObserver:self
                 forKeyPath:keyPath
                    options:NSKeyValueObservingOptionNew
                    context:nil];
    }
    
    DVDataBindObserverModel *obsModel;
    obsModel = [[DVDataBindObserverModel alloc] initWithObserver:self
                                                          target:target
                                                         keyPath:keyPath
                                                           index:index
                                                    convertBlock:convertBlock
                                                    databindType:dbType];
    self.modelForTargetKeyHashMap[targetKeyHash] = obsModel;
    
    [self bindDBTargetModelWithTarget:target];
}

- (void)bindWithOutBlock:(DBVoidAnyBlock)outBlock key:(NSString *)key {
    NSString *tempKey = key;
    if (!tempKey || [tempKey isEqualToString:@""]) {
        tempKey = @"com.databind.common";
    }
    
    [self.outBlockForKeyMap setObject:outBlock forKey:tempKey];
}

- (void)bindWithFilterBlock:(DBBoolAnyBlock)filterBlock {
    self.filterBlock = filterBlock;
}


#pragma mark - <-- 解绑 -->
- (void)unbindWithTarget:(id)target {
    NSString *targetHash = [(NSObject *)target db_Hash];
    [self unbindWithTargetHash:targetHash];
}

- (void)unbindWithTarget:(id)target keyPath:(NSString *)keyPath {
    NSString *targetHash = [(NSObject *)target db_Hash];
    [self unbindWithTargetHash:targetHash keyPath:keyPath];
}

- (void)unbindWithOutBlockKey:(NSString *)key {
    NSString *tempKey = key;
    if (!tempKey || [tempKey isEqualToString:@""]) {
        tempKey = @"com.databind.common";
    }
    
    [self.outBlockForKeyMap removeObjectForKey:tempKey];
}

- (void)unbindWithTargetHash:(NSString *)targetHash {
    NSArray<NSString *> *targetKeyHashs = [self.modelForTargetKeyHashMap.allKeys copy];
    
    for (NSString *targetKeyHash in targetKeyHashs) {
        DVDataBindObserverModel *obsModel = self.modelForTargetKeyHashMap[targetKeyHash];
        if (obsModel && [obsModel.targetHash isEqualToString:targetHash]) {
            [self.modelForTargetKeyHashMap removeObjectForKey:targetKeyHash];
        }
    }
}

- (void)unbindWithTargetHash:(NSString *)targetHash keyPath:(NSString *)keyPath {
    NSString *targetKeyHash = [NSString stringWithFormat:@"%@_%@", targetHash, keyPath];
    [self.modelForTargetKeyHashMap removeObjectForKey:targetKeyHash];
}


#pragma mark - <-------------------- 响应数据 -------------------->
#pragma mark - <-- KVO Override -->
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                       context:(void *)context {
    
    id oldValue = nil;
    id newValue = nil;
    NSIndexSet *indexSet = change[NSKeyValueChangeIndexesKey];
    
    if (indexSet) {
        // 数组变化
        NSUInteger index = indexSet.firstIndex;
        if (![self isContainTarget:object keyPath:keyPath index:index]) {
            return;
        }
        
        NSString *targetKeyHash = [self getTargetKeyHash:object keyPath:keyPath];
        DVDataBindObserverModel *obsModel = self.modelForTargetKeyHashMap[targetKeyHash];
        oldValue = obsModel.oldValue;
        
        NSMutableArray *array = [object valueForKey:keyPath];
        if (array && index < array.count) newValue = array[index];
        
        if ([self filterArrayWithObject:object
                                keyPath:keyPath
                                  index:index
                               oldValue:oldValue
                               newValue:newValue]) {
            [self updateValue:newValue fromObject:object fromKeyPath:keyPath];
        }
    }
    else {
        // 普通对象 和 UI对象
        if (((NSObject *)object).db_isDidChanged == YES) {
            ((NSObject *)object).db_isDidChanged = NO;
            return;
        }
        
        oldValue = change[NSKeyValueChangeOldKey];
        newValue = change[NSKeyValueChangeNewKey];
        
        if ([self filterObjectWithObject:object
                                 keyPath:keyPath
                                oldValue:oldValue
                                newValue:newValue]) {
            [self updateValue:newValue fromObject:object fromKeyPath:keyPath];
        }
    }
}

 
#pragma mark - <-- UI Respond -->
- (void)onRespondForUIByEvents:(id)sender {
    
    UIControl *ctrl = (UIControl *)sender;
    DVDataBindObserverModel *obsModel = self.modelForTargetKeyHashMap[ctrl.db_ctrl_targetKeyHash];
    
    if (!obsModel
        || (ctrl != obsModel.target)
        || ((ctrl.allControlEvents & obsModel.ctrlEvent) != obsModel.ctrlEvent)) {
        return;
    }
    
    NSString *keyPath = obsModel.keyPath;
    id oldValue = (obsModel.propertyType == DBPropertyType_NSString ? obsModel.oldString : obsModel.oldValue);
    id newValue = [ctrl valueForKey:obsModel.keyPath];
    
    
    if ([self filterUIWithObject:ctrl keyPath:keyPath oldValue:oldValue newValue:newValue]) {
        obsModel.oldValue = newValue;
        if (obsModel.propertyType == DBPropertyType_NSString) obsModel.oldString = newValue;
        [self updateValue:newValue fromObject:ctrl fromKeyPath:obsModel.keyPath];
    }
}


#pragma mark - <-- Filter -->
- (BOOL)filterObjectWithObject:(id)object
                       keyPath:(NSString *)keyPath
                      oldValue:(id)oldValue
                      newValue:(id)newValue {
    if (!self.filterBlock || self.filterBlock(newValue)) return YES;
    
    ((NSObject *)object).db_isDidChanged = YES;
    [object setValue:oldValue forKey:keyPath];
    return NO;
}

- (BOOL)filterUIWithObject:(id)object
                   keyPath:(NSString *)keyPath
                  oldValue:(id)oldValue
                  newValue:(id)newValue {
    
    if (!self.filterBlock || self.filterBlock(newValue)) return YES;
    
    ((NSObject *)object).db_isDidChanged = YES;
    [object setValue:oldValue forKey:keyPath];
    return NO;
}

- (BOOL)filterArrayWithObject:(id)object
                      keyPath:(NSString *)keyPath
                        index:(NSUInteger)index
                     oldValue:(id)oldValue
                     newValue:(id)newValue {
    
    if (!self.filterBlock || self.filterBlock(newValue)) return YES;
    
//    ((NSObject *)object).db_isDidChanged = YES;
    NSMutableArray *array = (NSMutableArray *)[object valueForKey:keyPath];
    if (array && index < array.count) {
        array[index] = oldValue;
    }
    return NO;
}


#pragma mark - <-- Value Update -->
- (id)convertValue:(id)value
        targetType:(DBPropertyType)targetType
             isNot:(BOOL)isNot {
    
    id tempValue = value;
        
    if ((targetType & DBPropertyType_NSNumber) == DBPropertyType_NSNumber) {
        if ([value isKindOfClass:[NSString class]]) {
            tempValue = [(NSString *)value db_covertToNumberForType:targetType];
        }
        else if ([value isKindOfClass:[NSNumber class]]) {
            tempValue = [(NSNumber *)value db_covertToNumberForType:targetType];
        }
        
        if (targetType == DBPropertyType_Bool && isNot) {
            BOOL boolValue = [(NSNumber *)tempValue boolValue];
            tempValue = [NSNumber numberWithBool:!boolValue];
        }
    }
    else if (targetType == DBPropertyType_NSString) {
        if ([value isKindOfClass:[NSNumber class]]) {
            tempValue = [(NSNumber *)value stringValue];
        }
    }
    
    return tempValue;
}

- (void)updateValue:(id)newValue fromObject:(id)object fromKeyPath:(NSString *)keyPath {
    if (newValue == nil) return;
    
    NSArray<NSString *> *targetKeyHashs = [self.modelForTargetKeyHashMap.allKeys copy];
    NSArray<DBVoidAnyBlock> *outBlocks = [self.outBlockForKeyMap.allValues copy];
 
    for (NSString *targetKeyHash in targetKeyHashs) {
        
        DVDataBindObserverModel *obsModel = self.modelForTargetKeyHashMap[targetKeyHash];
    
        if (!obsModel) continue;
        
        id target = obsModel.target;
        DBPropertyType targetType = obsModel.propertyType;
        NSString *keyPaths = obsModel.keyPath;
        DVDataBindType outDbType = (obsModel.dbType & DVDataBindType_OUT);
        DVDataBindType notDbTyoe = (obsModel.dbType & DVDataBindType_NOT);
        DVDataBindObserverModelType modelType = obsModel.modelType;
        
        if (!target || !keyPaths || outDbType != DVDataBindType_OUT) continue;
        
        if (modelType == DVDataBindObserverModelType_Object || modelType == DVDataBindObserverModelType_UI ) {
            
            if (target == object && [keyPaths isEqualToString:keyPath]) continue;
            if ([target valueForKey:keyPaths] == newValue
                && !obsModel.convertBlock
                && notDbTyoe != DVDataBindType_NOT) continue;
            
            ((NSObject *)target).db_isDidChanged = YES;
            
            
            id tempNewValue = newValue;
            BOOL isNot = (notDbTyoe == DVDataBindType_NOT);
            
            if (obsModel.convertBlock) {
                tempNewValue = [self convertValue:tempNewValue targetType:targetType isNot:YES];
                tempNewValue = obsModel.convertBlock(tempNewValue);
            } else {
                tempNewValue = [self convertValue:tempNewValue targetType:targetType isNot:isNot];
            }
            
            if ([tempNewValue isKindOfClass:[NSNull class]]) tempNewValue = nil;
            
            if (targetType == DBPropertyType_NSString) obsModel.oldString = tempNewValue;
            obsModel.oldValue = tempNewValue;
            [target setValue:tempNewValue forKey:keyPaths];
        }
        else if (modelType == DVDataBindObserverModelType_Array) {
            
            NSMutableArray *array = (NSMutableArray *)[obsModel.target valueForKey:obsModel.keyPath];
            
            if (array && obsModel.index < array.count && array[obsModel.index] != newValue) {
                
                id tempNewValue = newValue;
                tempNewValue = [self convertValue:tempNewValue targetType:targetType isNot:YES];
                
                if ([tempNewValue isKindOfClass:[NSNull class]]) tempNewValue = nil;
                obsModel.oldValue = tempNewValue;
                array[obsModel.index] = tempNewValue;
            }
        }
    }
 
    for (DBVoidAnyBlock outBlock in outBlocks) {
        outBlock(newValue);
    }
}





@end
