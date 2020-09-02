//
//  NSString+DataBind.h
//
//  Created by David.Shi on 2018/3/16.
//  Copyright © 2018 DVKit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DVDataBindDefine.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSString (DataBind)

- (unsigned int)db_unsignedIntValue;
- (unsigned long long)db_unsignedLongLongValue;

- (NSNumber *)db_covertToNumberForType:(DBPropertyType)type;

@end

NS_ASSUME_NONNULL_END
