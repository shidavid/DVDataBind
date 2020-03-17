//
//  TextFieldView.m
//  DVDataBindDemo
//
//  Created by mlgPro on 2020/3/17.
//  Copyright © 2020 DVUntilKit. All rights reserved.
//

#import "TextFieldView.h"

@implementation TextFieldView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.btnChangeNum.titleColor = [UIColor whiteColor];
    self.btnChangeNum.backgroundImage = [UIImage imageWithColor:[UIColor Blue]];
    self.btnChangeNum.backgroundImageForHighlighted = [UIImage imageWithColor:[UIColor Blue].darkColor];
    
    self.btnChangeText.titleColor = [UIColor whiteColor];
    self.btnChangeText.backgroundImage = [UIImage imageWithColor:[UIColor Blue]];
    self.btnChangeText.backgroundImageForHighlighted = [UIImage imageWithColor:[UIColor Blue].darkColor];
}

@end
