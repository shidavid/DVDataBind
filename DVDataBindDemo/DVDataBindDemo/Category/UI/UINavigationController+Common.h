//
//  UINavigationController+DV.h
//   
//
//  Created by DV on 2018/2/9.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (Common)

#pragma mark - <-- Method -->
- (void)pushViewControllerWithStoryBoard:(NSString *)storyBoardName
                              identifier:(NSString *)identifier
                                animated:(BOOL)flag;

@end
