//
//  AppDelegate+UISetting.m
//
//  Created by David.Shi on 2018/1/27.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "AppDelegate+UISetting.h"

@implementation AppDelegate (UISetting)

#pragma mark - <-- Method -->
- (void)UISetting {
    
    //Bar
    [self setAppStatusBar];
    [self setNavigationBar];
    [self setTabBar];
    
    //Control
    [self setButton];
    [self setTextField];
    
    //View
    [self setTableView];
}


#pragma mark - <-- Bar -->
- (void)setAppStatusBar {
    UIApplication *application = [UIApplication sharedApplication];
    
    //状态栏风格
    application.statusBarStyle = UIStatusBarStyleLightContent;
    //状态栏是否隐藏
//    application.statusBarHidden = NO;
}

- (void)setNavigationBar {
    UINavigationBar *naviBar = [UINavigationBar appearance];
    
    ///导航栏背景色
    [naviBar setBarTintColor: [UIColor blackColor]];
    
    ///导航栏标题文字颜色
    [naviBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    ///导航栏左右项文字颜色
    [naviBar setTintColor:[UIColor whiteColor]];
    
    ///导航栏风格
    [naviBar setBarStyle:UIBarStyleDefault];
    
    ///导航栏是否为半透明  NO为不透明
//    naviBar.translucent = YES;
    
}

- (void)setTabBar {
    UITabBar *tabBar = [UITabBar appearance];
    
    //TabBar背景色
//    [tabBar setBarTintColor:[UIColor whiteColor]];
    
    //TabBar选项颜色
//    [tabBar setTintColor:DVColor.theme];
    
    //TabBar风格
//    [tabBar setBarStyle:UIBarStyleDefault];
    
    //TabBar是否半透明 NO为不透明
//    tabBar.translucent = NO;
    
    
    UITabBarItem *tabBarItem = [UITabBarItem appearance];
    
    NSDictionary *normalAttri = @{
//                                 NSFontAttributeName:[UIFont labelFontSize],    //字体
                                 NSForegroundColorAttributeName:[UIColor grayColor], //字体颜色
                                 };
    
    NSDictionary *selectedAttri = @{
//                                 NSFontAttributeName:[UIFont labelFontSize],    //字体
                                 NSForegroundColorAttributeName:[UIColor darkGrayColor], //字体颜色
                                  };
    
    [tabBarItem setTitleTextAttributes:normalAttri   forState:(UIControlStateNormal)];
    [tabBarItem setTitleTextAttributes:selectedAttri forState:(UIControlStateSelected)];
}


#pragma mark - <-- Control -->
- (void)setButton {
    UIButton *btn = [UIButton appearance];
    
    ///同时只能允许一个button点击
    [btn setExclusiveTouch:YES];
}

- (void)setTextField {
    UITextField *txtField = [UITextField appearance];
    
    //设置 点击输入键盘的done,自动隐藏
    txtField.isHiddenKeyBoardByReturnKeyDone = YES;
}


#pragma mark - <-- View -->
- (void)setTableView {
    UITableView *tableView = [UITableView appearance];
    
    
    
    
    UITableViewCell *cell = [UITableViewCell appearance];
    
   
    
    
}



@end
