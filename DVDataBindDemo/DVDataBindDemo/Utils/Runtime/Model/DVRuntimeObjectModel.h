//
//  DVRuntimeObjectModel.h
//  French
//
//  Created by DV on 2019/8/12.
//  Copyright © 2019 iOS. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#pragma mark - <-------------------- Define -------------------->
/**
 ————————————————
 |Code   Meaning  |
 ————————————————
 c      A char
 i      An int
 s      A short
 l      A long  // l is treated as a 32-bit quantity on 64-bit programs.
 q      A long long
 C      An unsigned char
 I      An unsigned int
 S      An unsigned short
 L      An unsigned long
 Q      An unsigned long long
 f      A float
 d      A double
 B      A C++ bool or a C99 _Bool
 v      A void
 *      A character string (char *)
 @      An object (whether statically typed or typed id)
 #      A class object (Class)
 :      A method selector (SEL)
 [array type]   An array
 {name=type...} A structure
 (name=type...) A union
 bnum   A bit field of num bits
 ^type  A pointer to type
 ?  An unknown type (among other things, this code is used for function pointers)
 
 */
#pragma mark - Todo
#ifndef PROPERTY_TYPE
#define PROPERTY_TYPE
typedef NS_ENUM(NSUInteger, PropertyType) {
    PropertyType_NSObject,
    PropertyType_NSNumber,
    PropertyType_NSString,
    PropertyType_NSArray,
    PropertyType_NSDictionary,
    PropertyType_NSSet,
    
    PropertyType_Void,
    PropertyType_Id,
    PropertyType_Class,
    PropertyType_Sel,
    
    PropertyType_Int,
    PropertyType_UInt,
    PropertyType_Short,
    PropertyType_UShort,
    PropertyType_Long,
    PropertyType_ULong,
    PropertyType_LongLong,
    PropertyType_ULongLong,
    PropertyType_NSInteger,
    PropertyType_NSUInteger,
    PropertyType_Char,
    PropertyType_UChar,
    PropertyType_Chars,
    PropertyType_Float,
    PropertyType_Double,
    PropertyType_Bool,
};
#endif


#pragma mark - <-------------------- Class -------------------->
@interface DVRuntimeObjectModel : NSObject

@property(nonatomic, copy)   NSString *name;
@property(nonatomic, strong) id value;
@property(nonatomic, assign) PropertyType type;
@property(nonatomic, copy)   NSString *className;

@end

NS_ASSUME_NONNULL_END
