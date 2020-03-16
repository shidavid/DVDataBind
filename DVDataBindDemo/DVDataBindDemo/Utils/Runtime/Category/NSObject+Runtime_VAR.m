//
//  NSObject+Runtime_VAR.m
//  French
//
//  Created by DV on 2019/8/12.
//  Copyright © 2019 iOS. All rights reserved.
//

#import "NSObject+Runtime_VAR.h"
#import <objc/runtime.h>

@implementation NSObject (Runtime_VAR)

- (PropertyType)propertyType {
    if ([self isKindOfClass:[NSNumber class]]) {
        NSNumber *num = (NSNumber *)self;
        const char *type = num.objCType;
        [self getPropertyRealType:type];
    }
    else if ([self isKindOfClass:[NSString class]]) {
        return PropertyType_NSString;
    }
    else if ([self isKindOfClass:[NSArray class]]) {
        return PropertyType_NSArray;
    }
    else if ([self isKindOfClass:[NSDictionary class]]) {
        return PropertyType_NSArray;
    }
    else if ([self isKindOfClass:[NSSet class]]) {
        return PropertyType_NSSet;
    }
    else if ([self isKindOfClass:[NSObject class]] ) {
        return PropertyType_NSObject;
    }
    
    return PropertyType_Void;
}

- (NSArray<NSString *> *)propertyList {
    NSMutableArray<NSString*> *list = [NSMutableArray array];
    
    unsigned int count;
    objc_property_t *propertyList = class_copyPropertyList([self class], &count);
    for (unsigned int i = 0; i < count; i++) {
        objc_property_t property = propertyList[i];
        char const *propertyName =  property_getName(property);
        [list addObject:[NSString stringWithUTF8String:propertyName]];
    }
    free(propertyList);
    
    return [list copy];
}

- (NSArray<NSString *> *)ivarList {
    NSMutableArray<NSString *>*list = [NSMutableArray array];
    
    unsigned int count;
    Ivar *ivarList = class_copyIvarList([self class], &count);
    for (unsigned int i = 0; i < count; i++) {
        Ivar ivar = ivarList[i];
        char const *ivarName = ivar_getName(ivar);
        [list addObject:[NSString stringWithUTF8String:ivarName]];
    }
    free(ivarList);
    
    return [list copy];
}

- (NSArray<DVRuntimeObjectModel *> *)propertyListInDetail {
    NSMutableArray<DVRuntimeObjectModel *> *list = [NSMutableArray array];
    
    unsigned int count;
    objc_property_t *propertyList = class_copyPropertyList([self class], &count);
    
    for (unsigned int i = 0; i < count; i++) {
        
        objc_property_t property = propertyList[i];
        char const *propertyName = property_getName(property);
        char const *propertyType = property_copyAttributeValue(property, "T");
        
        DVRuntimeObjectModel *object = [[DVRuntimeObjectModel alloc] init];
        object.name = [NSString stringWithUTF8String:propertyName];
        object.value = [self valueForKey:object.name];
        object.className = [NSString stringWithUTF8String:propertyType];
        
        if ([object.value isKindOfClass:[NSNumber class]]) {
            object.type = PropertyType_NSNumber;
        }
        else{
            object.type = PropertyType_NSObject;
        }
        
        [list addObject:object];
    }
    
    free(propertyList);
    return [list copy];
}

- (NSArray<DVRuntimeObjectModel *> *)ivarListInDetail {
    NSMutableArray<DVRuntimeObjectModel *> *list = [NSMutableArray array];
    
    unsigned int count;
    Ivar *ivarList = class_copyIvarList([self class], &count);
    
    for (unsigned int i = 0; i < count; i++) {
        
        Ivar ivar = ivarList[i];
        char const *ivarName = ivar_getName(ivar);
        char const *ivarType = ivar_getTypeEncoding(ivar);
        
        DVRuntimeObjectModel *object = [[DVRuntimeObjectModel alloc] init];
        object.name = [NSString stringWithUTF8String:ivarName];
        object.value = [self valueForKey:object.name];
        object.className = [NSString stringWithUTF8String:ivarType];
        
        if ([object.value isKindOfClass:[NSNumber class]]) {
            object.type = PropertyType_NSNumber;
        }
        else{
            object.type = PropertyType_NSObject;
        }
        
        [list addObject:object];
    }
    
    free(ivarList);
    return [list copy];
}

- (NSArray<DVRuntimeObjectModel *> *)allListInDetail {
    return [NSArray arrayWithObjects:self.propertyListInDetail,self.ivarListInDetail, nil];
}


#pragma mark - <-- Method -->
- (void)cleanAllProperyValue {
    NSArray<DVRuntimeObjectModel *> *propertyList = self.propertyListInDetail;
    
    for (DVRuntimeObjectModel *object in propertyList) {
        if (object.type == PropertyType_NSNumber) {
            [self setValue:@(0) forKey:object.name];
        }
        else{
            [self setValue:nil forKey:object.name];
        }
    }
}

- (void)cleanAllIvarValue {
    NSArray<DVRuntimeObjectModel *> *ivarList = self.ivarListInDetail;
    
    for (DVRuntimeObjectModel *object in ivarList) {
        if (object.type == PropertyType_NSNumber) {
            [self setValue:@(0) forKey:object.name];
        }
        else{
            [self setValue:nil forKey:object.name];
        }
    }
}

- (PropertyType)getPropertyTypeWithName:(NSString *)propertyName {
    objc_property_t property = class_getProperty([self class], propertyName.UTF8String);
    const char* propertyType = property_getAttributes(property);
    return [self getPropertyRealType:propertyType];
}

- (PropertyType)getPropertyRealType:(const char *)property_attr {
    PropertyType type = PropertyType_Void;
    char t = property_attr[1];

    if (strcmp(&t, @encode(char)) == 0) {
        type = PropertyType_Char;
    } else if (strcmp(&t, @encode(int)) == 0) {
        type = PropertyType_Int;
    } else if (strcmp(&t, @encode(short)) == 0) {
        type = PropertyType_Short;
    } else if (strcmp(&t, @encode(long)) == 0) {
        type = PropertyType_Long;
    } else if (strcmp(&t, @encode(long long)) == 0) {
        type = PropertyType_LongLong;
    } else if (strcmp(&t, @encode(unsigned char)) == 0) {
        type = PropertyType_UChar;
    } else if (strcmp(&t, @encode(unsigned int)) == 0) {
        type = PropertyType_UInt;
    } else if (strcmp(&t, @encode(unsigned short)) == 0) {
        type = PropertyType_UShort;
    } else if (strcmp(&t, @encode(unsigned long)) == 0) {
        type = PropertyType_ULong;
    } else if (strcmp(&t, @encode(unsigned long long)) == 0) {
        type = PropertyType_ULongLong;
    } else if (strcmp(&t, @encode(NSInteger)) == 0) {
        type = PropertyType_NSInteger;
    } else if (strcmp(&t, @encode(NSUInteger)) == 0) {
        type = PropertyType_NSUInteger;
    } else if (strcmp(&t, @encode(float)) == 0) {
        type = PropertyType_Float;
    } else if (strcmp(&t, @encode(double)) == 0) {
        type = PropertyType_Double;
    } else if (strcmp(&t, @encode(_Bool)) == 0 || strcmp(&t, @encode(bool)) == 0) {
        type = PropertyType_Bool;
    } else if (strcmp(&t, @encode(void)) == 0) {
        type = PropertyType_Void;
    } else if (strcmp(&t, @encode(char *)) == 0) {
        type = PropertyType_Chars;
    } else if (strcmp(&t, @encode(id)) == 0) {
        type = PropertyType_Id;
    } else if (strcmp(&t, @encode(Class)) == 0) {
        type = PropertyType_Class;
    } else if (strcmp(&t, @encode(SEL)) == 0) {
        type = PropertyType_Sel;
    }
    return type;
}

//- (char *)getPropertyRealType:(const char *)property_attr {
//    char * type;
//
//    char t = property_attr[1];
//
//    if (strcmp(&t, @encode(char)) == 0) {
//        type = "char";
//    } else if (strcmp(&t, @encode(int)) == 0) {
//        type = "int";
//    } else if (strcmp(&t, @encode(short)) == 0) {
//        type = "short";
//    } else if (strcmp(&t, @encode(long)) == 0) {
//        type = "long";
//    } else if (strcmp(&t, @encode(long long)) == 0) {
//        type = "long long";
//    } else if (strcmp(&t, @encode(unsigned char)) == 0) {
//        type = "unsigned char";
//    } else if (strcmp(&t, @encode(unsigned int)) == 0) {
//        type = "unsigned int";
//    } else if (strcmp(&t, @encode(unsigned short)) == 0) {
//        type = "unsigned short";
//    } else if (strcmp(&t, @encode(unsigned long)) == 0) {
//        type = "unsigned long";
//    } else if (strcmp(&t, @encode(unsigned long long)) == 0) {
//        type = "unsigned long long";
//    } else if (strcmp(&t, @encode(float)) == 0) {
//        type = "float";
//    } else if (strcmp(&t, @encode(double)) == 0) {
//        type = "double";
//    } else if (strcmp(&t, @encode(_Bool)) == 0 || strcmp(&t, @encode(bool)) == 0) {
//        type = "BOOL";
//    } else if (strcmp(&t, @encode(void)) == 0) {
//        type = "void";
//    } else if (strcmp(&t, @encode(char *)) == 0) {
//        type = "char *";
//    } else if (strcmp(&t, @encode(id)) == 0) {
//        type = "id";
//    } else if (strcmp(&t, @encode(Class)) == 0) {
//        type = "Class";
//    } else if (strcmp(&t, @encode(SEL)) == 0) {
//        type = "SEL";
//    } else {
//        type = "";
//    }
//    return type;
//}

@end
