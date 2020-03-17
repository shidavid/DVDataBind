//
//  ImageView.m
//  DVDataBindDemo
//
//  Created by mlgPro on 2020/3/17.
//  Copyright © 2020 DVUntilKit. All rights reserved.
//

#import "ImageView.h"

@implementation ImageView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.btnChangeImage.titleColor = [UIColor whiteColor];
    self.btnChangeImage.backgroundImage = [UIImage imageWithColor:[UIColor Blue]];
    self.btnChangeImage.backgroundImageForHighlighted = [UIImage imageWithColor:[UIColor Blue].darkColor];
    
    self.btnChangeNil.titleColor = [UIColor whiteColor];
    self.btnChangeNil.backgroundImage = [UIImage imageWithColor:[UIColor Blue]];
    self.btnChangeNil.backgroundImageForHighlighted = [UIImage imageWithColor:[UIColor Blue].darkColor];
}

@end
