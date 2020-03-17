//
//  SwitchView.m
//  DVDataBindDemo
//
//  Created by mlgPro on 2020/3/17.
//  Copyright © 2020 DVUntilKit. All rights reserved.
//

#import "SwitchView.h"

@implementation SwitchView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.btnChangeEnable.titleColor = [UIColor whiteColor];
    self.btnChangeEnable.backgroundImage = [UIImage imageWithColor:[UIColor Blue]];
    self.btnChangeEnable.backgroundImageForHighlighted = [UIImage imageWithColor:[UIColor Blue].darkColor];
    
    self.btnChangeIsON.titleColor = [UIColor whiteColor];
    self.btnChangeIsON.backgroundImage = [UIImage imageWithColor:[UIColor Blue]];
    self.btnChangeIsON.backgroundImageForHighlighted = [UIImage imageWithColor:[UIColor Blue].darkColor];
}

@end
