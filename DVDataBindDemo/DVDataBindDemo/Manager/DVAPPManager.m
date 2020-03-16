//
//  DVAPPManager.m
//   
//
//  Created by mlgPro on 2019/2/28.
//  Copyright © 2019 iOS. All rights reserved.
//

#import "DVAPPManager.h"

@implementation DVAPPManager

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static DVAPPManager *instance = nil;
    dispatch_once(&onceToken,^{
        instance = [[super allocWithZone:NULL] init];
    });
    return instance;
}

+ (id)allocWithZone:(struct _NSZone *)zone{
    return [self sharedInstance];
}


#pragma mark - <-- Property -->
- (NSMutableArray<UIViewController *> *)viewControllerStack {
    if (!_viewControllerStack) {
        _viewControllerStack = [NSMutableArray array];
    }
    return _viewControllerStack;
}


@end
