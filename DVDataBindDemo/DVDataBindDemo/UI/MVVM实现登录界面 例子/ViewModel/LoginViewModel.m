//
//  LoginViewModel.m
//  DVDataBindDemo
//
//  Created by 施达威 on 2020/3/18.
//  Copyright © 2020 DVUntilKit. All rights reserved.
//

#import "LoginViewModel.h"
#import "LoginModel.h"


@implementation LoginViewModel

- (BOOL)btnLoginEnable {
    return (self.userName && self.userName.length > 0
            && self.password && self.password.length > 0);
}

- (BOOL)filterUserName:(NSString *)userName {
    // 这里可加 userName判断处理
    return userName.length <= 15;
}

- (BOOL)filterPassword:(NSString *)password {
    // 这里可加 password判断处理
    return password.length <= 20;
}

- (void)login {
    // Model是服务器请求数据, ViewModel是关于View的Model
    LoginModel *model = [[LoginModel alloc] init];
    model.userName = self.userName;
    model.password = self.password;
    
    // 这里post model 到服务器
    NSLog(@"登录成功, userName -> %@, password -> %@", model.userName, model.password);
}

@end
