//
//  NSString+DataBind.m
//
//  Created by David.Shi on 2018/3/16.
//  Copyright © 2018 DVKit. All rights reserved.
//

#import "NSString+DataBind.h"

@implementation NSString (DataBind)

- (unsigned int)db_unsignedIntValue {
    uint value = self.intValue;
    
    if (value == INT_MAX) {
        NSString *s1 = [self substringToIndex:5];
        NSString *s2 = [self substringFromIndex:5];
        int v1 = s1.intValue;
        int v2 = s2.intValue;
        value = v1 * 10e5 + v2;
    }
    
    return value;
}

- (unsigned long long)db_unsignedLongLongValue {
    unsigned long long value = self.longLongValue;
    
    if (value == LONG_LONG_MAX) {
        NSString *s1 = [self substringToIndex:10];
        NSString *s2 = [self substringFromIndex:10];
        unsigned long long v1 = s1.longLongValue;
        unsigned long long v2 = s2.longLongValue;
        value = v1 * 10e10 + v2;
    }
    
    return value;
}

- (NSNumber *)db_covertToNumberForType:(DBPropertyType)type {
    NSNumber *num = @(0);

    if (type == DBPropertyType_NSInteger) {
        num = [NSNumber numberWithInteger:self.integerValue];
    } else if (type == DBPropertyType_NSUInteger) {
        num = [NSNumber numberWithUnsignedLongLong:self.db_unsignedLongLongValue];
    } else if (type == DBPropertyType_Int) {
        num = [NSNumber numberWithInt:self.intValue];
    } else if (type == DBPropertyType_UInt) {
        num = [NSNumber numberWithUnsignedInt:self.db_unsignedIntValue];
    } else if (type == DBPropertyType_Float) {
        num = [NSNumber numberWithFloat:self.floatValue];
    } else if (type == DBPropertyType_Double) {
        num = [NSNumber numberWithDouble:self.doubleValue];
    } else if (type == DBPropertyType_Bool) {
        num = [NSNumber numberWithBool:self.length > 0];
    } else if (type == DBPropertyType_Char) {
        num = [NSNumber numberWithChar:(char)self.integerValue];
    } else if (type == DBPropertyType_UChar) {
        num = [NSNumber numberWithUnsignedChar:(unsigned char)self.integerValue];
    } else if (type == DBPropertyType_Short) {
        num = [NSNumber numberWithShort:(short)self.integerValue];
    } else if (type == DBPropertyType_UShort) {
        num = [NSNumber numberWithUnsignedShort:(unsigned short)self.integerValue];
    }
    
    return num;
}

@end
