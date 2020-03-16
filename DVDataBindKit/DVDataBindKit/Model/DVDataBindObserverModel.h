//
//  DVDataBindObserverModel.h
//
//  Created by David.Shi on 2018/3/16.
//  Copyright © 2018 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DVDataBindDefine.h"
#import "DVDataBind.h"


NS_ASSUME_NONNULL_BEGIN


@interface DVDataBindObserverModel : NSObject {
@public
    void *_Nullable _context;
}

#pragma mark - <-- Property -->
@property(nonatomic, weak) id observer;
@property(nonatomic, weak) id target;
@property(nonatomic, copy) NSString *keyPath;
@property(nonatomic, copy, nullable) DBAnyAnyBlock convertBlock;
@property(nonatomic, copy) NSString *targetHash;
@property(nonatomic, weak) id oldValue;
//@property(nonatomic, assign) id oldValueForObject;
@property(nonatomic, assign) DVDataBindType dbType;
@property(nonatomic, assign) DVDataBindObserverModelType modelType;

//UI
@property(nonatomic, assign) SEL selector;
@property(nonatomic, assign) UIControlEvents ctrlEvent;

//Array
@property(nonatomic, assign) NSUInteger index;


#pragma mark - <-- Instance -->
- (instancetype)initWithObserver:(id)observer
                          target:(id)target
                         keyPath:(NSString *)keyPath
                         context:(nullable void *)context
                    convertBlock:(nullable DBAnyAnyBlock)convertBlock
                    databindType:(DVDataBindType)dbType;

- (instancetype)initWithObserver:(id)observer
                          target:(id)target
                         keyPath:(NSString *)keyPath
                        selector:(nullable SEL)selector
                    controlEvent:(UIControlEvents)ctrlEvent
                    convertBlock:(nullable DBAnyAnyBlock)convertBlock
                    databindType:(DVDataBindType)dbType;

- (instancetype)initWithObserver:(id)observer
                          target:(id)target
                         keyPath:(NSString *)keyPath
                           index:(NSUInteger)index
                    convertBlock:(nullable DBAnyAnyBlock)convertBlock
                    databindType:(DVDataBindType)dbType;

@end

NS_ASSUME_NONNULL_END
