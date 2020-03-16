//
//  NSString+DataBind.m
//
//  Created by David.Shi on 2018/3/16.
//  Copyright © 2018 DVKit. All rights reserved.
//

#import "NSString+DataBind.h"

@implementation NSString (DataBind)

- (NSNumber *)db_covertToNumberForType:(DBPropertyType)type {
    NSNumber *num = @(0);

    if (type == DBPropertyType_NSInteger) {
        num = [NSNumber numberWithInteger:self.integerValue];
    } else if (type == DBPropertyType_NSUInteger) {
        num = [NSNumber numberWithUnsignedInteger:(NSUInteger)self.integerValue];
    } else if (type == DBPropertyType_Int) {
        num = [NSNumber numberWithInt:self.intValue];
    } else if (type == DBPropertyType_UInt) {
        num = [NSNumber numberWithUnsignedInt:(unsigned int)self.intValue];
    } else if (type == DBPropertyType_Float) {
        num = [NSNumber numberWithFloat:self.floatValue];
    } else if (type == DBPropertyType_Double) {
        num = [NSNumber numberWithDouble:self.doubleValue];
    } else if (type == DBPropertyType_Bool) {
        num = [NSNumber numberWithBool:self.length > 0];
    } else if (type == DBPropertyType_Char) {
        num = [NSNumber numberWithChar:(char)self.intValue];
    } else if (type == DBPropertyType_UChar) {
        num = [NSNumber numberWithUnsignedChar:(unsigned char)self.intValue];
    } else if (type == DBPropertyType_Short) {
        num = [NSNumber numberWithShort:(short)self.intValue];
    } else if (type == DBPropertyType_UShort) {
        num = [NSNumber numberWithUnsignedShort:(unsigned short)self.intValue];
    }
    
    return num;
}

@end
