//
//  NSObject+Runtime_Class.m
//  French
//
//  Created by DV on 2019/8/12.
//  Copyright © 2019 iOS. All rights reserved.
//

#import "NSObject+Runtime_Class.h"
#import <objc/runtime.h>

@implementation NSObject (Runtime_Class)

#pragma mark - <-- 获取信息 -->
- (Class)getClass {
    return [self class];
}

+ (Class)getClass {
    return [self class];
}

- (Class)getMetaClass {
    return object_getClass([self class]);
}

+ (Class)getMetaClass {
    return object_getClass([self class]);
}

- (NSString *)getClassName {
    return NSStringFromClass([self class]);
}

+ (NSString *)getClassName {
    return NSStringFromClass([self class]);
}


#pragma mark - <-- Method -->
- (void)changeToClass:(Class)aClass {
    object_setClass(self, aClass);
}

@end
