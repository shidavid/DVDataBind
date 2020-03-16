//
//  UIToolbar+Common.m
//  French
//
//  Created by DV on 2019/3/29.
//  Copyright © 2019 iOS. All rights reserved.
//

#import "UIToolbar+Common.h"

@implementation UIToolbar (Common)

- (void)spaceToFit {
    if (self.items && self.items.count > 1) {
        NSUInteger count = self.items.count * 2 - 1;
        
        UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        NSMutableArray<UIBarButtonItem *> *items = [self.items mutableCopy];
        
        for (NSUInteger i = 1; i < count; i+=2) {
            [items insertObject:spaceItem atIndex:i];
        }
        
        [self setItems:[items copy] animated:NO];
    }
}

@end
