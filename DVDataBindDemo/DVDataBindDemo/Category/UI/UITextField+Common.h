//
//  UITextField+DV.h
//   
//
//  Created by DV on 2018/2/9.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (Common)

///自动隐藏键盘
@property(nonatomic, assign) BOOL isHiddenKeyBoardByReturnKeyDone;

///增加左边View
- (void)addLeftView:(UIView *)view;

@end
