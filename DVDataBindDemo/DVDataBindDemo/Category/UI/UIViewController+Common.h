//
//  UIViewController+Common.h
//  iOS_Template_Objc
//
//  Created by DV on 2018/1/10.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (Common)

#pragma mark - <-- Property -->
/** 导航栏是否隐藏 */
@property(nonatomic, assign) BOOL isHiddenNavBar;

/** 导航栏透明度 */
@property(nonatomic, assign) CGFloat navBarAlpha;


#pragma mark - <-- Method -->
+ (instancetype)viewControlWithStoryBoard;

+ (instancetype)storyBoardWithName:(NSString *)storyBoardName identifier:(NSString *)identifier;

- (void)presentViewControllerWithStoryBoard:(NSString *)storyBoardName
                                 identifier:(NSString *)identifier
                                   animated:(BOOL)flag
                                 completion:(void (^ __nullable)(void))completion;

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated;

- (void)pushViewControllerWithClassName:(NSString *)className animated:(BOOL)animated;

- (void)popViewControllerAnimated:(BOOL)animated;

- (void)setTabBarItemWithTitle:(NSString *)title
                      fontSize:(CGFloat)fontSize
                         image:(UIImage *)image;

@end

NS_ASSUME_NONNULL_END
