//
//  DVDataBindKit.h
//  DVDataBindKit
//
//  Created by mlgPro on 2018/3/16.
//  Copyright © 2018 DVUntilKit. All rights reserved.
//

#import <Foundation/Foundation.h>

#if __has_include(<DVDataBindKit/DVDataBindKit.h>)
//! Project version number for DVDataBindKit.
FOUNDATION_EXPORT double DVDataBindKitVersionNumber;

//! Project version string for DVDataBindKit.
FOUNDATION_EXPORT const unsigned char DVDataBindKitVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <DVDataBindKit/PublicHeader.h>


#import <DVDataBindKit/DVDataBind.h>

#else

#import "DVDataBind.h"

#endif


