//
//  NSObject+DataBind.m
//
//  Created by David.Shi on 2018/3/16.
//  Copyright © 2018 iOS. All rights reserved.
//

#import "NSObject+DataBind.h"
#import <objc/runtime.h>

@implementation NSObject (DataBind)

#pragma mark - <-- Property -->
- (BOOL)db_isDidChanged {
    NSNumber *boolValue = objc_getAssociatedObject(self, _cmd);
    return [boolValue boolValue];
}

- (void)setDb_isDidChanged:(BOOL)db_isDidChanged {
    objc_setAssociatedObject(self, @selector(db_isDidChanged), @(db_isDidChanged), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (DVDataBindTargetModel *)db_targetModel {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setDb_targetModel:(DVDataBindTargetModel *)db_targetModel {
    objc_setAssociatedObject(self, @selector(db_targetModel), db_targetModel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)db_ctrl_targetKeyHash {
    NSString *targetKeyHash = objc_getAssociatedObject(self, _cmd);
    return targetKeyHash ? targetKeyHash : @"";
}

- (void)setDb_ctrl_targetKeyHash:(NSString *)db_ctrl_targetKeyHash {
    objc_setAssociatedObject(self, @selector(db_ctrl_targetKeyHash), db_ctrl_targetKeyHash, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)db_Hash {
    return [NSString stringWithFormat:@"%lx", (unsigned long)[self hash]];
}


#pragma mark - <-- Method -->
- (DBPropertyType)db_getDBPropertyTypeWithName:(NSString *)propertyName {
    objc_property_t property = class_getProperty([self class], propertyName.UTF8String);
    const char *property_attr =  property_copyAttributeValue(property, "T");
    
    return [self db_getPropertyRealType:property_attr];
}

- (DBPropertyType)db_getPropertyRealType:(const char *)property_attr {
    DBPropertyType type = DBPropertyType_Void;
    char t = property_attr[0];

    if (t == '@') {
        
        NSString *attr = [NSString stringWithUTF8String:property_attr];
        
        if ([attr containsString:@"NSString"]) {
            type = DBPropertyType_NSString;
        } else if ([attr containsString:@"NSNumber"]) {
            type = DBPropertyType_NSNumber;
        } else if ([attr containsString:@"NSArray"]) {
            type = DBPropertyType_NSArray;
        } else if ([attr containsString:@"NSDictionary"]) {
            type = DBPropertyType_NSDictionary;
        } else if ([attr containsString:@"NSSet"]){
            type = DBPropertyType_NSSet;
        } else {
            type = DBPropertyType_NSObject;
        }
        
    } else if (t == 'q') {
        type = DBPropertyType_NSInteger;
    } else if (t == 'Q') {
        type = DBPropertyType_NSUInteger;
    } else if (t == 'i') {
        type = DBPropertyType_Int;
    } else if (t == 'I') {
        type = DBPropertyType_UInt;
    } else if (t == 'f') {
        type = DBPropertyType_Float;
    } else if (t == 'd') {
        type = DBPropertyType_Double;
    } else if (t == 'B') {
        type = DBPropertyType_Bool;
    } else if (t == 'c') {
        type = DBPropertyType_Char;
    } else if (t == 'C') {
        type = DBPropertyType_UChar;
    } else if (t == 's') {
        type = DBPropertyType_Short;
    } else if (t == 'S') {
        type = DBPropertyType_UShort;
    } else if (t == 'v') {
        type = DBPropertyType_Void;
    } else if (t == '*') {
        type = DBPropertyType_Chars;
    } else if (t == ':') {
        type = DBPropertyType_Sel;
    } else if (t == '#') {
        type = DBPropertyType_Class;
    }
    return type;
}

@end
