//
//  LoginViewModel.h
//  DVDataBindDemo
//
//  Created by 施达威 on 2020/3/18.
//  Copyright © 2020 DVUntilKit. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// ViewModel 是关于 View的Model
@interface LoginViewModel : NSObject

@property(nonatomic, copy) NSString *userName;
@property(nonatomic, copy) NSString *password;

- (BOOL)btnLoginEnable;

- (BOOL)filterUserName:(NSString *)userName;

- (BOOL)filterPassword:(NSString *)password;

- (void)login;

@end

NS_ASSUME_NONNULL_END
