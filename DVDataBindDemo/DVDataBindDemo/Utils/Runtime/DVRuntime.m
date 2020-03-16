//
//  DVRuntime.m
//  French
//
//  Created by DV on 2019/8/12.
//  Copyright © 2019 iOS. All rights reserved.
//

#import "DVRuntime.h"
#import <objc/runtime.h>

@implementation DVRuntime

#pragma mark - <-- Class -->
+ (Class)newSubClassWithName:(NSString *)subClassName base:(Class)baseClass {
    Class subClass = NSClassFromString(subClassName);
    if (!subClass) {
        subClass = objc_allocateClassPair(baseClass, [subClassName UTF8String], 0);
        objc_registerClassPair(subClass);
    }
    return  subClass;
}

+ (void)deleteClass:(Class)aClass {
    if (aClass) {
        objc_disposeClassPair(aClass);
    }
}

+ (void)deleteClassWithName:(NSString *)className {
    Class aClass = NSClassFromString(className);
    if (aClass) {
        objc_disposeClassPair(aClass);
    }
}


#pragma mark - <-- Method -->
+ (const char *)getMethodTypeWithProtocol:(Protocol *)protocol
                                 selector:(SEL)selector
                               isRequired:(BOOL)isRequiredMethod
                         isInstanceMethod:(BOOL)isInstanceMethod {
    struct objc_method_description description = protocol_getMethodDescription(protocol,
                                                                               selector,
                                                                               isRequiredMethod,
                                                                               isInstanceMethod);
    return description.types;
}

+ (const char *)getMethodTypeWithClass:(Class)aClass
                              selector:(SEL)selector
                      isInstanceMethod:(BOOL)isInstanceMethod {
    
    const char *type = "";
    
    if (isInstanceMethod && [aClass instancesRespondToSelector:selector]) {
        Method method = class_getInstanceMethod([aClass class], selector);
        type = method_getTypeEncoding(method);
    } else if ([aClass respondsToSelector:selector]) {
        Method method = class_getClassMethod(object_getClass([aClass class]), selector);
        type =  method_getTypeEncoding(method);
    }
    
    return type;
}

+ (void)exchangeInstanceMethodWithOriginalClass:(Class)oClass
                                    originalSel:(SEL)originalSelector
                                  swizzledClass:(Class)sClass
                                    swizzledSel:(SEL)swizzledSelector {
    
    Method originalMethod = class_getInstanceMethod(oClass, originalSelector);
    Method swizzleMethod = class_getInstanceMethod(sClass, swizzledSelector);
    
    BOOL didAddMethod = class_addMethod(sClass,
                                        originalSelector,
                                        method_getImplementation(swizzleMethod),
                                        method_getTypeEncoding(swizzleMethod));
    
    if (didAddMethod) {
        class_replaceMethod(oClass,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzleMethod);
    }
}

+ (SEL)convertGetSelFromSetSel:(SEL)setSel {
    NSString *setName = NSStringFromSelector(setSel);
    NSString *getName = [self convertGetNameFromSetName:setName];
    return NSSelectorFromString(getName);
}

+ (NSString *)convertGetNameFromSetName:(NSString *)setName {
    NSString *head = [[setName substringWithRange:NSMakeRange(3, 1)] lowercaseString];
    NSString *body = [setName substringWithRange:NSMakeRange(4, setName.length-5)];
    NSString *getName = [head stringByAppendingString:body];
    return getName;
}

@end
