//
//  MainViewModel.m
//  DVDataBindDemo
//
//  Created by mlgPro on 2020/3/16.
//  Copyright © 2020 DVUntilKit. All rights reserved.
//

#import "MainViewModel.h"

@implementation MainViewModel

- (NSDictionary<NSString *,NSString *> *)tableItems {
    return @{
        @"UISwitch 例子" : @"SwitchViewController",
        @"UITextField 例子" : @"TextFieldViewController",
        @"UIImageView 例子" : @"ImageViewController",
        @"UISlider 例子" : @"SliderViewController",
        @"UISegmentControl 例子" : @"SegmentedViewController",
        @"数组 例子" : @"ArrayViewController",
    };
}

@end
