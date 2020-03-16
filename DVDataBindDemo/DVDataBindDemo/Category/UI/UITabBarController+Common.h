//
//  UITabBarController+Common.h
//  French
//
//  Created by DV on 2019/3/29.
//  Copyright © 2019 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#pragma mark - <-------------------- Define -------------------->
@protocol UITabBarControllerDataSource<NSObject>

- (NSUInteger)numberOfTabItems;

- (UIViewController *)tabItemAtIndex:(NSUInteger)index;

@end


#pragma mark - <-------------------- Class -------------------->
@interface UITabBarController (Common)

@property(nonatomic, weak) id<UITabBarControllerDataSource> dataSource;

- (void)reload;

- (void)setTabBarItems:(NSArray<UIViewController *> *)viewControllers;
- (void)insertTabItem:(UIViewController *)viewController atIndex:(NSInteger)index;
- (void)insertTabItemAtFirst:(UIViewController *)viewController;
- (void)insertTabItemAtLast:(UIViewController *)viewController;

- (void)removeAllTabItems;
- (void)removeTabItem:(NSInteger)index;
- (void)removeFirstTabItem;
- (void)removeLastTabItem;

@end

NS_ASSUME_NONNULL_END
