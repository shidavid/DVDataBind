//
//  LoginViewModel.h
//  DVDataBindDemo
//
//  Created by 施达威 on 2020/3/18.
//  Copyright © 2020 DVUntilKit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LoginViewModel : NSObject

@property(nonatomic, weak) LoginModel *loginModel;

- (BOOL)btnLoginEnable;

- (BOOL)filterUserName:(NSString *)userName;

- (BOOL)filterPassword:(NSString *)password;

- (void)login;

@end

NS_ASSUME_NONNULL_END
