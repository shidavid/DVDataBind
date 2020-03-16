//
//  UIBarButtonItem+Common.m
//  French
//
//  Created by DV on 2019/3/29.
//  Copyright © 2019 iOS. All rights reserved.
//

#import "UIBarButtonItem+Common.h"

@implementation UIBarButtonItem (Common)

+ (instancetype)spaceItem {
    return [[self alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
}

@end
