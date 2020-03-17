//
//  AppDelegate+Notification.m
//  MM
//
//  Created by DV on 2019/8/27.
//  Copyright © 2019 iOS. All rights reserved.
//

#import "AppDelegate+Notification.h"

@implementation AppDelegate (Notification)

- (void)addGlobalNotification {
    // 注册键盘通知
    //键盘的frame值将要发生变化
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector (keyboardWillChangeFrameNotification:) name:UIKeyboardWillChangeFrameNotification object:nil];
//
//    //键盘的frame值发生变化
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector (keyboardDidChangeFrameNotification:) name:UIKeyboardDidChangeFrameNotification object:nil];
    
    // 即将显示
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector (keyboardWillShowNotification:) name:UIKeyboardWillShowNotification object:nil];
    
    // 显示
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector (keyboardDidShowNotification:) name:UIKeyboardDidShowNotification object:nil];
    
    // 即将隐藏
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHideNotification:) name:UIKeyboardWillHideNotification object:nil];
    
//    // 隐藏
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(keyboardDidHideNotification:) name:UIKeyboardDidHideNotification object:nil];
}

- (void)removeGlobalNotification {
    //键盘的frame值将要发生变化
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
    //键盘的frame值发生变化
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidChangeFrameNotification object:nil];
    // 即将显示
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    // 显示
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    // 即将隐藏
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    // 隐藏
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
}



#pragma mark - <-- 键盘监听方法 -->
/**
 {
    UIKeyboardAnimationCurveUserInfoKey = 7;
    UIKeyboardAnimationDurationUserInfoKey = "0.25";
    UIKeyboardBoundsUserInfoKey = "NSRect: {{0, 0}, {375, 258}}";
    UIKeyboardCenterBeginUserInfoKey = "NSPoint: {187.5, 796}";
    UIKeyboardCenterEndUserInfoKey = "NSPoint: {187.5, 538}";
    UIKeyboardFrameBeginUserInfoKey = "NSRect: {{0, 667}, {375, 258}}";
    UIKeyboardFrameEndUserInfoKey = "NSRect: {{0, 409}, {375, 258}}";
    UIKeyboardIsLocalUserInfoKey = 1;
 }
 
    当输入框被触发时:
    UIKeyboardWillChangeFrameNotification -->
    UIKeyboardWillShowNotification -->
    UIKeyboardDidChangeFrameNotification -->
    UIKeyboardDidShowNotification
 
    当输入框退出时:
    UIKeyboardWillChangeFrameNotification -->
    UIKeyboardWillHideNotification -->
    UIKeyboardDidChangeFrameNotification -->
    UIKeyboardDidHideNotification
 
 */
- (void) keyboardWillChangeFrameNotification: (NSNotification *)notif {
//    NSLog(@"键盘的frame值将要发生变化");
}

- (void) keyboardDidChangeFrameNotification: (NSNotification *)notif {
//    NSLog(@"键盘的frame值已经发生变化");
//    NSLog(@"%@",notif);
}

- (void)keyboardWillShowNotification: (NSNotification *)notif {
//    NSLog(@"键盘即将显示:%@",notif.userInfo);
    
    CGFloat beginHeight = [notif.userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue].size.height;
    CGFloat endHeight = [notif.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    
    if (DVInfo.isPhoneX_All) {
        endHeight += 80;
    }
    
    UIViewController *vc = DVManager.app.currentViewController;
    UIView *txtField = (UIView *)[self.window performSelector:@selector(firstResponder)];
    
    if (vc && txtField ){ //}&& (beginHeight == endHeight)) {
        CGFloat kbMinY = DVFrame.height - endHeight;
        CGRect txtFrame = [txtField convertRect:txtField.bounds toView:vc.view];
        CGFloat txtMaxY = CGRectGetMaxY(txtFrame);
        
        if (txtMaxY > kbMinY) {
            CGRect viewFrame = vc.view.lastFrame;
            viewFrame.origin.y -= (txtMaxY - kbMinY + 30);
            
            [UIView animateWithDuration:0.2 animations:^{
                vc.view.frame = viewFrame;
            }];
        }
    }
}

- (void) keyboardDidShowNotification: (NSNotification *)notif {
//    NSLog(@"键盘显示:%@",notif.userInfo);
  
    
}

- (void) keyboardWillHideNotification:(NSNotification *)notif {
    UIViewController *vc = DVManager.app.currentViewController;
    if (vc) {
        [UIView animateWithDuration:0.2 animations:^{
            vc.view.frame = vc.view.lastFrame;
        }];
    }
}

- (void) keyboardDidHideNotification:(NSNotification *)notif {
//    NSLog(@"键盘隐藏");
}

@end
