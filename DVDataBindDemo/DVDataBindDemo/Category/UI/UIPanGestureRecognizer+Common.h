//
//  UIPanGestureRecognizer+Common.h
//  DVKit
//
//  Created by mlgPro on 2020/1/18.
//  Copyright © 2020 DVKit. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIPanGestureRecognizer (Common)

- (void)setXTranslationWithView:(UIView *)view;
- (void)setYTranslationWithView:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
