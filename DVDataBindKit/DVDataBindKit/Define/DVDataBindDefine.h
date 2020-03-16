//
//  DVDataBindDefine.h
//
//  Created by David.Shi on 2018/3/16.
//  Copyright © 2018 DVKit. All rights reserved.
//

#ifndef DVDataBindDefine_h
#define DVDataBindDefine_h

#ifndef DV_DATABIND_TYPE
#define DV_DATABIND_TYPE
typedef NS_OPTIONS(NSUInteger, DVDataBindType) {
    DVDataBindType_IN           = 0x001,
    DVDataBindType_OUT          = 0x010,
    DVDataBindType_IN_OUT       = 0x011,
    DVDataBindType_IN_NOT       = 0x101,
    DVDataBindType_OUT_NOT      = 0x110,
    DVDataBindType_IN_OUT_NOT   = 0x111,
    
    DVDataBindType_NOT          = 0x100,
};
#endif


typedef NS_ENUM(NSUInteger, DVDataBindObserverModelType) {
    DVDataBindObserverModelType_Object,
    DVDataBindObserverModelType_UI,
    DVDataBindObserverModelType_Array,
};


#ifndef DBPROPERTY_TYPE
#define DBPROPERTY_TYPE
typedef NS_ENUM(NSUInteger, DBPropertyType) {
    DBPropertyType_NSObject     = 0x1000,
    DBPropertyType_NSString     = 0x2000,
    DBPropertyType_NSArray      = 0x3000,
    DBPropertyType_NSDictionary = 0x4000,
    DBPropertyType_NSSet        = 0x5000,
    
    DBPropertyType_NSNumber     = 0x5000,
    DBPropertyType_Int          = 0x5001,
    DBPropertyType_UInt         = 0x5002,
    DBPropertyType_Short        = 0x5003,
    DBPropertyType_UShort       = 0x5004,
    DBPropertyType_NSInteger    = 0x5005,
    DBPropertyType_NSUInteger   = 0x5006,
    DBPropertyType_Char         = 0x5007,
    DBPropertyType_UChar        = 0x5008,
    DBPropertyType_Chars        = 0x5009,
    DBPropertyType_Float        = 0x5010,
    DBPropertyType_Double       = 0x5011,
    DBPropertyType_Bool         = 0x5012,
    
    DBPropertyType_Void         = 0x6000,
    DBPropertyType_Class        = 0x7000,
    DBPropertyType_Sel          = 0x8000,
};
#endif

#endif /* DVDataBindDefine_h */
