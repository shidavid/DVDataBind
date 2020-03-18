//
//  DemoView.m
//  DVDataBindDemo
//
//  Created by mlgPro on 2020/3/18.
//  Copyright © 2020 DVUntilKit. All rights reserved.
//

#import "DemoView.h"

@implementation DemoView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.button.titleColor = [UIColor whiteColor];
    self.button.backgroundImage = [UIImage imageWithColor:[UIColor Blue]];
    self.button.backgroundImageForHighlighted = [UIImage imageWithColor:[UIColor Blue].darkColor];
}

@end
