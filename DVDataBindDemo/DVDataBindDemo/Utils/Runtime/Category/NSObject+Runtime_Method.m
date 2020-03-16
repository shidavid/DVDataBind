//
//  NSObject+Runtime_Method.m
//  French
//
//  Created by DV on 2019/8/12.
//  Copyright © 2019 iOS. All rights reserved.
//

#import "NSObject+Runtime_Method.h"
#import <objc/runtime.h>
#import <objc/message.h>


@implementation NSObject (Runtime_Method)

- (NSArray<NSString *> *)methodList {
    NSMutableArray<NSString *>*list = [NSMutableArray array];
    
    unsigned int count;
    Method *methodList = class_copyMethodList([self class], &count);
    for (unsigned int i = 0; i < count; i++) {
        Method method = methodList[i];
        SEL methodSEL = method_getName(method);
        NSString *methodName = NSStringFromSelector(methodSEL);
        [list addObject:methodName];
    }
    free(methodList);
    
    return [list copy];
}


#pragma mark - <-- Property -->
- (id)runtime_delegate {
    id temp = objc_getAssociatedObject(self, _cmd);
    if (temp == nil) {
        NSString *subClassName = [NSString stringWithFormat:@"%@_%lx_Delegate",
                                  NSStringFromClass([self class]),
                                  (unsigned long)[self hash]];
        Class subClass = [DVRuntime newSubClassWithName:subClassName base:[NSObject class]];
        id subInstance = [[subClass alloc] init];
        temp = self.runtime_delegate = subInstance;
        
        IMP imp = imp_implementationWithBlock(^(id object){
            NSLog(@"已经注销了%@",[object class]);
            objc_disposeClassPair([object class]);
        });
        class_addMethod(subClass, NSSelectorFromString(@"dealloc"), imp, "v@:@");
    }
    return temp;
}

- (void)setRuntime_delegate:(id)runtime_delegate {
    objc_setAssociatedObject(self,
                             @selector(runtime_delegate),
                             runtime_delegate,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


#pragma mark - <-- Method  -->
- (void)addInstanceMethod:(nonnull SEL)selector block:(id)block {
    NSString *className = NSStringFromClass([self class]);
    NSString *hashStr= [NSString stringWithFormat:@"%lx",(unsigned long)[self hash]];
    
    if (![className hasSuffix:hashStr]) {
        NSString *subClassName = [NSString stringWithFormat:@"%@_%@",className,hashStr];
        Class subClass = [DVRuntime newSubClassWithName:subClassName base:[self class]];
        [self changeToClass:subClass];
        [self exchangeInstanceMethodWithOriginalSel:NSSelectorFromString(@"dealloc")
                                        swizzledSel:NSSelectorFromString(@"aop_runtime_subClass_dealloc")];
    }
    
    IMP imp = imp_implementationWithBlock(block);
    class_addMethod([self class], selector, imp, "");
}

- (void)addDelegateMethod:(nonnull SEL)selector block:(id)block {
    IMP imp = imp_implementationWithBlock(block);
    class_addMethod([self.runtime_delegate class], selector, imp, "");
}

+ (void)addPublicMethod:(nonnull SEL)selector block:(id)block {
    IMP imp = imp_implementationWithBlock(block);
    class_addMethod([self class], selector, imp, "");
}

+ (void)addClassMethod:(nonnull SEL)selector block:(id)block {
    IMP imp = imp_implementationWithBlock(block);
    class_addMethod(object_getClass([self class]), selector, imp, "");
}



#pragma mark - <------------------------------ 完美分割线 ------------------------------>
#pragma mark - <-- 添加 实例 方法 -->
- (void)addInstanceMethod:(SEL)selector i_block:(int(^)())block {
    [self addInstanceMethod:selector block:block];
}

- (void)addInstanceMethod:(SEL)selector I_block:(NSInteger(^)())block {
    [self addInstanceMethod:selector block:block];
}

- (void)addInstanceMethod:(SEL)selector f_block:(float(^)())block {
    [self addInstanceMethod:selector block:block];
}

- (void)addInstanceMethod:(SEL)selector d_block:(double(^)())block {
    [self addInstanceMethod:selector block:block];
}

- (void)addInstanceMethod:(SEL)selector b_block:(BOOL(^)())block {
    [self addInstanceMethod:selector block:block];
}

- (void)addInstanceMethod:(SEL)selector o_block:(id _Nullable(^)())block {
    [self addInstanceMethod:selector block:block];
}

- (void)addInstanceMethod:(SEL)selector v_block:(void(^)())block {
    [self addInstanceMethod:selector block:block];
}


#pragma mark - <-- 添加 协议 方法 -->
- (void)addDelegateMethod:(SEL)selector i_block:(int(^)())block {
    [self addDelegateMethod:selector block:block];
}

- (void)addDelegateMethod:(SEL)selector I_block:(NSInteger(^)())block {
    [self addDelegateMethod:selector block:block];
}

- (void)addDelegateMethod:(SEL)selector f_block:(float(^)())block {
    [self addDelegateMethod:selector block:block];
}

- (void)addDelegateMethod:(SEL)selector d_block:(double(^)())block {
    [self addDelegateMethod:selector block:block];
}

- (void)addDelegateMethod:(SEL)selector b_block:(BOOL(^)())block {
    [self addDelegateMethod:selector block:block];
}

- (void)addDelegateMethod:(SEL)selector o_block:(id(^)())block {
    [self addDelegateMethod:selector block:block];
}

- (void)addDelegateMethod:(SEL)selector v_block:(void(^)())block {
    [self addDelegateMethod:selector block:block];
}


#pragma mark - <-- 添加 本类 公共方法 -->
+ (void)addPublicMethod:(SEL)selector i_block:(int(^)())block {
    [self addPublicMethod:selector block:block];
}

+ (void)addPublicMethod:(SEL)selector I_block:(NSInteger(^)())block {
    [self addPublicMethod:selector block:block];
}

+ (void)addPublicMethod:(SEL)selector f_block:(float(^)())block {
    [self addPublicMethod:selector block:block];
}

+ (void)addPublicMethod:(SEL)selector d_block:(double(^)())block {
    [self addPublicMethod:selector block:block];
}

+ (void)addPublicMethod:(SEL)selector b_block:(BOOL(^)())block {
    [self addPublicMethod:selector block:block];
}

+ (void)addPublicMethod:(SEL)selector o_block:(id(^)())block {
    [self addPublicMethod:selector block:block];
}

+ (void)addPublicMethod:(SEL)selector v_block:(void(^)())block {
    [self addPublicMethod:selector block:block];
}


#pragma mark - <-- 添加 本类 公共类方法 -->
+ (void)addClassMethod:(SEL)selector i_block:(int(^)())block {
    [self addClassMethod:selector block:block];
}

+ (void)addClassMethod:(SEL)selector I_block:(NSInteger(^)())block {
    [self addClassMethod:selector block:block];
}

+ (void)addClassMethod:(SEL)selector f_block:(float(^)())block {
    [self addClassMethod:selector block:block];
}

+ (void)addClassMethod:(SEL)selector d_block:(double(^)())block {
    [self addClassMethod:selector block:block];
}

+ (void)addClassMethod:(SEL)selector b_block:(BOOL(^)())block {
    [self addClassMethod:selector block:block];
}

+ (void)addClassMethod:(SEL)selector o_block:(id(^)())block {
    [self addClassMethod:selector block:block];
}

+ (void)addClassMethod:(SEL)selector v_block:(void(^)())block {
    [self addClassMethod:selector block:block];
}



#pragma mark - <-- 交换实现方法-->
- (void)exchangeInstanceMethodWithOriginalSel:(SEL)originalSelector
                                  swizzledSel:(SEL)swizzledSelector {
    [DVRuntime exchangeInstanceMethodWithOriginalClass:[self class]
                                           originalSel:originalSelector
                                         swizzledClass:[self class]
                                           swizzledSel:swizzledSelector];
}

+ (void)exchangeInstanceMethodWithOriginalSel:(SEL)originalSelector
                                  swizzledSel:(SEL)swizzledSelector {
    [DVRuntime exchangeInstanceMethodWithOriginalClass:[self class]
                                           originalSel:originalSelector
                                         swizzledClass:[self class]
                                           swizzledSel:swizzledSelector];
}



#pragma mark - <-- 执行方法 -->
- (void)performSuperSelector:(SEL)aSelector param:(id)param {
    struct objc_super superReceiver = {
        self,
        [self superclass]
    };
    ((void(*)(id,SEL,id))objc_msgSendSuper)((__bridge id)(&superReceiver),aSelector,param);
}

- (void)performSuperSelector:(SEL)aSelector param1:(id)param1 param2:(id)param2 {
    struct objc_super superReceiver = {
        self,
        [self superclass]
    };
    ((void(*)(id,SEL,id,id))objc_msgSendSuper)((__bridge id)(&superReceiver),aSelector,param1,param2);
}

- (void)performSuperSelector:(SEL)aSelector param1:(id)param1 param2:(id)param2 param3:(id)param3 {
    struct objc_super superReceiver = {
        self,
        [self superclass]
    };
    ((void(*)(id,SEL,id,id,id))objc_msgSendSuper)((__bridge id)(&superReceiver),aSelector,param1,param2,param3);
}


#pragma mark - <-- AOP -->
- (void)aop_runtime_subClass_dealloc {
    NSString *subClassName = NSStringFromClass([self class]);
    NSString *hashStr= [NSString stringWithFormat:@"%lx",(unsigned long)[self hash]];

    [self aop_runtime_subClass_dealloc];

    if ([subClassName hasSuffix:hashStr]) {
        NSLog(@"已经注销了%@",subClassName);
        objc_disposeClassPair(NSClassFromString(subClassName));
    }
}



@end
