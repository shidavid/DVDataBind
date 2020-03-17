//
//  ArrayView.m
//  DVDataBindDemo
//
//  Created by mlgPro on 2020/3/17.
//  Copyright © 2020 DVUntilKit. All rights reserved.
//

#import "ArrayView.h"

@implementation ArrayView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.btnChange1.titleColor = [UIColor whiteColor];
    self.btnChange1.backgroundImage = [UIImage imageWithColor:[UIColor Blue]];
    self.btnChange1.backgroundImageForHighlighted = [UIImage imageWithColor:[UIColor Blue].darkColor];
    
    self.btnChange2.titleColor = [UIColor whiteColor];
    self.btnChange2.backgroundImage = [UIImage imageWithColor:[UIColor Blue]];
    self.btnChange2.backgroundImageForHighlighted = [UIImage imageWithColor:[UIColor Blue].darkColor];
}

@end
