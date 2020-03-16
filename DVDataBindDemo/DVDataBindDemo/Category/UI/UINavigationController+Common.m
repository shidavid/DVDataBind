//
//  UINavigationController+DV.m
//   
//
//  Created by DV on 2018/2/9.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "UINavigationController+Common.h"

@implementation UINavigationController (Common)

- (void)pushViewControllerWithStoryBoard:(NSString *)storyBoardName
                              identifier:(NSString *)identifier
                                animated:(BOOL)flag {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:storyBoardName bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:identifier];
    [self pushViewController:vc animated:flag];
}


@end
