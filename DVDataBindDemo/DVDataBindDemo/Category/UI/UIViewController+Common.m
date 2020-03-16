
//
//  UIViewController+Common.m
//  iOS_Template_Objc
//
//  Created by DV on 2018/1/10.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "UIViewController+Common.h"

@implementation UIViewController (Common)

#pragma mark - <-- Setter & Getter -->
- (BOOL)isHiddenNavBar {
    return self.navBarAlpha > 0 ? NO : YES;
}

- (void)setIsHiddenNavBar:(BOOL)isHiddenNavBar {
    self.navBarAlpha = (isHiddenNavBar == YES ? 0 : 1);
}



- (CGFloat)navBarAlpha {
    UINavigationBar *navBar =  self.navigationController.navigationBar;
    
    if (navBar.subviews.count == 0) return 1;
    
    if (@available(iOS 13, *)) {
        UIView *barBackgroundView = navBar.subviews[0].subviews[1];
        if (navBar.isTranslucent && barBackgroundView) {
            return barBackgroundView.alpha;
        }
    }
    else if (@available(iOS 11, *)) {
        UIView *barBackgroundView = navBar.subviews[0].subviews[1];
        if (navBar.isTranslucent && barBackgroundView) {
            return barBackgroundView.alpha;
        }
    }
    else {
        UIView *barBackgroundView = navBar.subviews[0];
        if (navBar.isTranslucent && barBackgroundView) {
            return barBackgroundView.alpha;
        }
    }
    return 1.0f;
}

- (void)setNavBarAlpha:(CGFloat)navBarAlpha {
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = navBarAlpha > 0 ? UIRectEdgeNone : UIRectEdgeTop;
    }
    
    UINavigationBar *navBar =  self.navigationController.navigationBar;
    if (navBar.subviews.count == 0) return;
    
    if (@available(iOS 13, *)) {
        UIView *barBackgroundView = navBar.subviews[0].subviews[1];
        if (navBar.isTranslucent && barBackgroundView) {
            barBackgroundView.alpha = navBarAlpha;
            for (UIView *subView in barBackgroundView.subviews) {
                subView.alpha = navBarAlpha;
            }
        }
    }
    else if (@available(iOS 11, *)) {
        UIView *barBackgroundView = navBar.subviews[0].subviews[1];
        if (navBar.isTranslucent && barBackgroundView) {
            barBackgroundView.alpha = navBarAlpha;
        }
    }
    else {
        UIView *barBackgroundView = navBar.subviews[0];
        if (navBar.isTranslucent && barBackgroundView) {
            barBackgroundView.alpha = navBarAlpha;
        }
    }
    navBar.clipsToBounds = (navBarAlpha > 0) ? NO : YES;
}


#pragma mark - <-- Method -->
+ (instancetype)viewControlWithStoryBoard {
    NSString *className = NSStringFromClass([self class]);
    UIStoryboard *sb = [UIStoryboard storyboardWithName:className bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:className];
    return vc;
}

+ (instancetype)storyBoardWithName:(NSString *)storyBoardName identifier:(NSString *)identifier {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:storyBoardName bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:identifier];
    return vc;
}

- (void)presentViewControllerWithStoryBoard:(NSString *)storyBoardName
                                 identifier:(NSString *)identifier
                                   animated:(BOOL)flag
                                 completion:(void (^)(void))completion {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:storyBoardName bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:identifier];
    [self presentViewController:vc animated:flag completion:completion];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    viewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewController animated:animated];
}

- (void)pushViewControllerWithClassName:(NSString *)className animated:(BOOL)animated {
    Class aClass = NSClassFromString(className);
    if (aClass) {
        UIViewController *vc = [aClass new];
        vc.hidesBottomBarWhenPushed = YES;
        [self pushViewController:vc animated:animated];
    }
}

- (void)popViewControllerAnimated:(BOOL)animated {
    [self.navigationController popViewControllerAnimated:animated];
}

- (void)setTabBarItemWithTitle:(NSString *)title fontSize:(CGFloat)fontSize image:(UIImage *)image {
    [self.tabBarItem setTitle:title];
    [self.tabBarItem setImage:[image imageWithRenderingMode:(UIImageRenderingModeAutomatic)]];
}


@end
