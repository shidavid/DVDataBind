//
//  SegmentedView.m
//  DVDataBindDemo
//
//  Created by mlgPro on 2020/3/17.
//  Copyright © 2020 DVUntilKit. All rights reserved.
//

#import "SegmentedView.h"

@implementation SegmentedView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.stepper.minimumValue = 0;
    self.stepper.maximumValue = 4;
    
    self.btnChangeIndex.titleColor = [UIColor whiteColor];
    self.btnChangeIndex.backgroundImage = [UIImage imageWithColor:[UIColor Blue]];
    self.btnChangeIndex.backgroundImageForHighlighted = [UIImage imageWithColor:[UIColor Blue].darkColor];
}

@end
