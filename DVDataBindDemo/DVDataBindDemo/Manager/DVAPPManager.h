//
//  DVAPPManager.h
//   
//
//  Created by mlgPro on 2019/2/28.
//  Copyright © 2019 iOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface DVAPPManager : NSObject

#pragma mark - <-- Property -->
@property(nonatomic, weak) AppDelegate *appDelegate;

/// 当前ViewController
@property(nonatomic, weak) UIViewController *currentViewController;

@property(nonatomic, weak) UIViewController *topViewController;

@property(nonatomic, strong) NSMutableArray<UIViewController *> *viewControllerStack;

#pragma mark - <-- SharedInstance -->
+ (instancetype)sharedInstance;

@end

NS_ASSUME_NONNULL_END
