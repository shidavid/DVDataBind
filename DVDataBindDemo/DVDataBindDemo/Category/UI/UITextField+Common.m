
//
//  UITextField+DV.m
//   
//
//  Created by DV on 2018/2/9.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "UITextField+Common.h"

@implementation UITextField (Common)

#pragma mark - <-- Property -->
- (BOOL)isHiddenKeyBoardByReturnKeyDone {
    return [self targetForAction:@selector(handleKeyboardHiddenEvent:) withSender:self] != nil;
}

- (void)setIsHiddenKeyBoardByReturnKeyDone:(BOOL)isHiddenKeyBoardByReturnKeyDone {
    if (isHiddenKeyBoardByReturnKeyDone == YES) {
        self.returnKeyType = UIReturnKeyDone;
        [self addTarget:self action:@selector(handleKeyboardHiddenEvent:) forControlEvents:UIControlEventEditingDidEndOnExit];
    } else {
        self.returnKeyType = UIReturnKeyDefault;
        [self removeTarget:self action:@selector(handleKeyboardHiddenEvent:) forControlEvents:UIControlEventEditingDidEndOnExit];
    }
}

- (void)handleKeyboardHiddenEvent:(id)sender {
    [self resignFirstResponder];
}


#pragma mark - <-- Method -->
- (void)addLeftView:(UIView *)view {
    UIView *leftView = self.leftView != nil ? self.leftView : [[UIView alloc] init];
    
    if (self.leftView != nil) {
        view.frame = CGRectMake(leftView.width, 0, view.width, self.height);
        leftView.frame = CGRectMake(0, 0, leftView.width+view.width, self.height);
    } else {
        view.frame = CGRectMake(0, 0, view.width, self.height);
        leftView.frame = CGRectMake(0, 0, view.width, self.height);
    }
    
    [leftView addSubview:view];
    self.leftView = leftView;
    self.leftViewMode = UITextFieldViewModeAlways;
}



@end
