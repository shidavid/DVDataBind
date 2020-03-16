//
//  UITabBarController+Common.m
//  French
//
//  Created by DV on 2019/3/29.
//  Copyright © 2019 iOS. All rights reserved.
//

#import "UITabBarController+Common.h"
#import <objc/runtime.h>

@implementation UITabBarController (Common)

static char kAssociatedObjectKey_dataSource;

#pragma mark - <-- Property -->
- (id<UITabBarControllerDataSource>)dataSource {
    return ((id<UITabBarControllerDataSource>(^)(void))objc_getAssociatedObject(self, &kAssociatedObjectKey_dataSource))();
}

- (void)setDataSource:(id<UITabBarControllerDataSource>)dataSource {
    __weak __typeof(dataSource)weakDataSource = dataSource;
    id<UITabBarControllerDataSource>(^Block)(void) = ^{
        return weakDataSource;
    };
    
    objc_setAssociatedObject(self, &kAssociatedObjectKey_dataSource, Block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    if (dataSource != nil) {
        [self reload];
    }
}


#pragma mark - <-- Method -->
- (void)reload{
    id<UITabBarControllerDataSource> weakDataSource = self.dataSource;
    if (weakDataSource!= nil) {
        NSUInteger count = weakDataSource.numberOfTabItems;
        NSMutableArray<UIViewController*>* viewCtrls = [NSMutableArray array];
        for (NSUInteger i = 0; i<count; i++) {
            [viewCtrls addObject: [weakDataSource tabItemAtIndex:i]];
        }
        self.viewControllers = [viewCtrls copy];
    }
}

- (void)setTabBarItems:(NSArray<UIViewController *> *)viewControllers {
    if ([self.viewControllers count] > 0) {
        self.viewControllers = nil;
    }
    self.viewControllers = viewControllers;
}


- (void)insertTabItem:(UIViewController *)viewController atIndex:(NSInteger)index{
    NSMutableArray<UIViewController *>*viewCtrls = [NSMutableArray arrayWithArray:self.viewControllers];
    [viewCtrls insertObject:viewController atIndex:index];
    self.viewControllers = viewCtrls;
}

- (void)insertTabItemAtFirst:(UIViewController *)viewController{
    NSMutableArray<UIViewController *>*viewCtrls = [NSMutableArray arrayWithArray:self.viewControllers];
    [viewCtrls insertObject:viewController atIndex:0];
    self.viewControllers = viewCtrls;
}

- (void)insertTabItemAtLast:(UIViewController *)viewController {
    NSMutableArray<UIViewController *>*viewCtrls = [NSMutableArray arrayWithArray:self.viewControllers];
    [viewCtrls addObject:viewController];
    self.viewControllers = viewCtrls;
}

- (void)removeAllTabItems {
    self.viewControllers = nil;
}

- (void)removeTabItem:(NSInteger)index {
    NSMutableArray<UIViewController *>*viewCtrls = [NSMutableArray arrayWithArray:self.viewControllers];
    [viewCtrls removeObjectAtIndex:index];
    self.viewControllers = viewCtrls;
}

- (void)removeFirstTabItem {
    NSMutableArray<UIViewController *>*viewCtrls = [NSMutableArray arrayWithArray:self.viewControllers];
    [viewCtrls removeObjectAtIndex:0];
    self.viewControllers = viewCtrls;
}

- (void)removeLastTabItem {
    NSMutableArray<UIViewController *>*viewCtrls = [NSMutableArray arrayWithArray:self.viewControllers];
    [viewCtrls removeLastObject];
    self.viewControllers = viewCtrls;
}

@end
