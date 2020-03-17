//
//  DVDataBindObserverModel.m
//
//  Created by David.Shi on 2018/3/16.
//  Copyright © 2018 iOS. All rights reserved.
//

#import "DVDataBindObserverModel.h"
#import "NSObject+DataBind.h"

@implementation DVDataBindObserverModel

#pragma mark - <-- Instance -->
- (instancetype)initWithObserver:(id)observer
                          target:(id)target
                         keyPath:(NSString *)keyPath
                         context:(void *)context
                    convertBlock:(DBAnyAnyBlock)convertBlock
                    databindType:(DVDataBindType)dbType {
    self = [super init];
    if (self) {
        self.observer = observer;
        self.target = target;
        self.keyPath = keyPath;
        self.convertBlock = convertBlock;
        self.targetHash = [(NSObject *)target db_Hash];
        self.oldValue = [target valueForKey:keyPath];
        self.dbType = dbType;
        self.modelType = DVDataBindObserverModelType_Object;
        self.propertyType = [target db_getDBPropertyTypeWithName:keyPath];
        _context = context;
        self.index = NSUIntegerMax;
        self.oldString = @"";
    }
    return self;
}

- (instancetype)initWithObserver:(id)observer
                          target:(id)target
                         keyPath:(NSString *)keyPath
                        selector:(SEL)selector
                    controlEvent:(UIControlEvents)ctrlEvent
                    convertBlock:(DBAnyAnyBlock)convertBlock
                    databindType:(DVDataBindType)dbType {
    self = [super init];
    if (self) {
        self.observer = observer;
        self.target = target;
        self.keyPath = keyPath;
        self.convertBlock = convertBlock;
        self.targetHash = [(NSObject *)target db_Hash];
        self.oldValue = [target valueForKey:keyPath];
        self.dbType = dbType;
        self.modelType = DVDataBindObserverModelType_UI;
        self.propertyType = [target db_getDBPropertyTypeWithName:keyPath];
        self.selector = selector;
        self.ctrlEvent = ctrlEvent;
        self.index = NSUIntegerMax;
        self.oldString = @"";
    }
    return self;
}

- (instancetype)initWithObserver:(id)observer
                          target:(id)target
                         keyPath:(NSString *)keyPath
                           index:(NSUInteger)index
                    convertBlock:(DBAnyAnyBlock)convertBlock
                    databindType:(DVDataBindType)dbType {
    self = [super init];
    if (self) {
        self.observer = observer;
        self.target = target;
        self.keyPath = keyPath;
        self.convertBlock = convertBlock;
        self.targetHash = [(NSObject *)target db_Hash];
        self.dbType = dbType;
        self.modelType = DVDataBindObserverModelType_Array;
        self.propertyType = [target db_getDBPropertyTypeWithName:keyPath];
        self.index = index;
        self.oldString = @"";
        
        NSMutableArray *array = [target valueForKey:keyPath];
        if (array && index < array.count) {
            self.oldValue = array[index];
            self.propertyType = [(NSObject *)array[index] db_propertyType];
        }
    }
    return self;
}




#pragma mark - <-- Dealloc -->
- (void)dealloc {
    if (self.observer
        && self.target
        && self.keyPath
        && ((self.dbType & DVDataBindType_IN) == DVDataBindType_IN)) {
        [self.target removeObserver:self.observer forKeyPath:self.keyPath];
    }
    
    if (self.observer
        && self.target
        && self.selector != nil
        && ((self.ctrlEvent & UIControlEventAllEvents) != 0x00 )
        && ((self.dbType & DVDataBindType_IN) == DVDataBindType_IN)) {
        [self.target removeTarget:self.observer action:self.selector forControlEvents:self.ctrlEvent];
    }
    
    _observer = nil;
    _target = nil;
    _convertBlock = nil;
    _oldValue = nil;
    _selector = NULL;
    _context = nil;
}

@end
