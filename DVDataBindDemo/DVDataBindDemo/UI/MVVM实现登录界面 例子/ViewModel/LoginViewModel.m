//
//  LoginViewModel.m
//  DVDataBindDemo
//
//  Created by 施达威 on 2020/3/18.
//  Copyright © 2020 DVUntilKit. All rights reserved.
//

#import "LoginViewModel.h"

@implementation LoginViewModel

- (void)login {
    NSString *userName = self.loginModel.userName;
    NSString *password = self.loginModel.password;
    
    NSLog(@"登录成功, userName -> %@, password -> %@", userName, password);
}

- (BOOL)btnLoginEnable {
    BOOL enable = YES;
    if (!self.loginModel.userName || self.loginModel.userName.length == 0) {
        enable = NO;
    }
    else if (!self.loginModel.password || self.loginModel.password.length == 0) {
        enable = NO;
    }
    return enable;
}

@end
