//
//  LoginViewController.m
//  DVDataBindDemo
//
//  Created by 施达威 on 2020/3/18.
//  Copyright © 2020 DVUntilKit. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginView.h"
#import "LoginViewModel.h"

@interface LoginViewController ()

@property(nonatomic, strong) LoginView *loginView;
@property(nonatomic, strong) LoginModel *loginModel;
@property(nonatomic, strong) LoginViewModel *loginViewModel;

@end


@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initViews];
    [self initModels];
    [self bindData];
}

#pragma mark - <-- Init -->
- (void)initViews {
    self.loginView = (LoginView *)self.view;
    self.loginView.backgroundColor = [UIColor Blue];
}

- (void)initModels {
    self.loginModel = [[LoginModel alloc] init];
    
    self.loginViewModel = [[LoginViewModel alloc] init];
    self.loginViewModel.loginModel = self.loginModel;
}

- (void)bindData {
    __weak __typeof(self)weakSelf = self;
    
    DVDataBind
    ._in_ui(self.loginView.userNameText, @"text", UIControlEventEditingChanged)
    ._out(self.loginModel, @"userName")
    ._filter(^BOOL(NSString *text) {
        return [weakSelf.loginViewModel filterUserName:text];
    })
    ._out_key_any(@"login.userName.text", ^{
        weakSelf.loginView.btnLogin.enabled = [weakSelf.loginViewModel btnLoginEnable];
    });
    
    
    DVDataBind
    ._in_ui(self.loginView.passwordText, @"text", UIControlEventEditingChanged)
    ._out_cv(self.loginModel, @"password", ^(NSString *text){
        // textField.secureTextEntry = YES时, text为密文, 需要转换
        return [NSString stringWithUTF8String:text.UTF8String];
    })
    ._filter(^BOOL(NSString *text) {
        NSString *tempText = [NSString stringWithUTF8String:text.UTF8String];
        return [weakSelf.loginViewModel filterPassword:tempText];
    })
    ._out_key_any(@"login.passwordText.text", ^{
        weakSelf.loginView.btnLogin.enabled = [weakSelf.loginViewModel btnLoginEnable];
    });
    
    
    DVDataBind
    ._in_ui(self.loginView.btnLogin, @"highlighted", UIControlEventTouchUpInside)
    ._out_key_any(@"login.btnLogin.login", ^{
        [weakSelf.loginViewModel login];
    });
}


@end
