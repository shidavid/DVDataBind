//
//  NSNumber+DataBind.m
//
//  Created by David.Shi on 2018/3/16.
//  Copyright © 2018 DVKit. All rights reserved.
//

#import "NSNumber+DataBind.h"

@implementation NSNumber (DataBind)

- (NSNumber *)db_covertToNumberForType:(DBPropertyType)type {
    NSNumber *num = @(0);

    if (type == DBPropertyType_NSInteger) {
        num = [NSNumber numberWithInteger:self.integerValue];
    } else if (type == DBPropertyType_NSUInteger) {
        num = [NSNumber numberWithUnsignedInteger:self.unsignedIntegerValue];
    } else if (type == DBPropertyType_Int) {
        num = [NSNumber numberWithInt:self.intValue];
    } else if (type == DBPropertyType_UInt) {
        num = [NSNumber numberWithUnsignedInt:self.unsignedIntValue];
    } else if (type == DBPropertyType_Float) {
        num = [NSNumber numberWithFloat:self.floatValue];
    } else if (type == DBPropertyType_Double) {
        num = [NSNumber numberWithDouble:self.doubleValue];
    } else if (type == DBPropertyType_Bool) {
        num = [NSNumber numberWithBool:self.boolValue];
    } else if (type == DBPropertyType_Char) {
        num = [NSNumber numberWithChar:self.charValue];
    } else if (type == DBPropertyType_UChar) {
        num = [NSNumber numberWithUnsignedChar:self.unsignedCharValue];
    } else if (type == DBPropertyType_Short) {
        num = [NSNumber numberWithShort:self.shortValue];
    } else if (type == DBPropertyType_UShort) {
        num = [NSNumber numberWithUnsignedShort:self.unsignedShortValue];
    }
    
    return num;
}

@end
