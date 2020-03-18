//
//  LoginView.m
//  DVDataBindDemo
//
//  Created by 施达威 on 2020/3/18.
//  Copyright © 2020 DVUntilKit. All rights reserved.
//

#import "LoginView.h"

@implementation LoginView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.userNameText setNeedsLayout];
    [self.passwordText setNeedsLayout];
    
    
    UIView *userNameLeftView = ({
        UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(8, 8, 24, 24)];
        image.image = [UIImage imageNamed:@"user.png"];
        [v addSubview:image];
        v;
    });
    
    UIView *passwordLeftView = ({
        UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(8, 8, 24, 24)];
        image.image = [UIImage imageNamed:@"password.png"];
        [v addSubview:image];
        v;
    });
   
    
    self.userNameText.textColor = [UIColor Gray];
    self.userNameText.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.userNameText.leftView = userNameLeftView;
    self.userNameText.leftViewMode = UITextFieldViewModeAlways;
    
    self.passwordText.textColor = [UIColor Gray];
    self.passwordText.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.passwordText.leftView = passwordLeftView;
    self.passwordText.leftViewMode = UITextFieldViewModeAlways;
    self.passwordText.secureTextEntry = YES;
    
    self.btnLogin.enabled = NO;
    self.btnLogin.layer.cornerRadius = 8;
    self.btnLogin.clipsToBounds = YES;
    self.btnLogin.titleColor = [UIColor Blue];
    self.btnLogin.backgroundImage = [UIImage imageWithColor:[UIColor whiteColor]];
    self.btnLogin.backgroundImageForHighlighted = [UIImage imageWithColor:[UIColor darkGrayColor]];
}

@end
