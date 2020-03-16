//
//  AppDelegate.m
//  DVDataBindDemo
//
//  Created by David.Shi on 2018/3/16.
//  Copyright © 2018 DVUntilKit. All rights reserved.
//

#import "AppDelegate.h"
#import "RootNavigationController.h"
#import "MainViewController.h"
#import "AppDelegate+UISetting.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window setBackgroundColor:[UIColor whiteColor]];
    [self initMainViewController:self.window];
    [self.window makeKeyAndVisible];
    
    [self UISetting];
    
    return YES;
}

- (void)initMainViewController:(UIWindow *)window {
    MainViewController *mainVC = [[MainViewController alloc] init];
    RootNavigationController *rootNC = [[RootNavigationController alloc] initWithRootViewController:mainVC];
    
    [window setRootViewController:rootNC];
}



@end
