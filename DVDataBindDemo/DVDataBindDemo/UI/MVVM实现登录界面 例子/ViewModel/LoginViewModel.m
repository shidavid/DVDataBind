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

@end
