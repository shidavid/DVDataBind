//
//  SliderView.m
//  DVDataBindDemo
//
//  Created by mlgPro on 2020/3/17.
//  Copyright © 2020 DVUntilKit. All rights reserved.
//

#import "SliderView.h"

@implementation SliderView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.slider.minimumValue = 0;
    self.slider.maximumValue = 100;
    
    self.btnChangeValue.titleColor = [UIColor whiteColor];
    self.btnChangeValue.backgroundImage = [UIImage imageWithColor:[UIColor Blue]];
    self.btnChangeValue.backgroundImageForHighlighted = [UIImage imageWithColor:[UIColor Blue].darkColor];
}

@end
