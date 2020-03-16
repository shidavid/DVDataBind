//
//  UILabel+DV.m
//   
//
//  Created by 施达威 on 2018/2/8.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "UILabel+Common.h"

@implementation UILabel (Common)

- (CGFloat)fontSize {
    return [self.font pointSize];
}

- (void)setFontSize:(CGFloat)fontSize {
    self.font = [self.font fontWithSize:fontSize];
}

- (void)wordSpaceToFitWidth:(CGFloat)width {
    if (self.text.length <= 1) {
        return;
    }
    
    UILabel *lblTmp = [[UILabel alloc] init];
    lblTmp.text = self.text;
    lblTmp.font = self.font;
    [lblTmp sizeToFit];

    
    float wordSpace = (float)(width - CGRectGetWidth(lblTmp.frame)) / (float)(self.text.length - 1);
    [self changeWordSpace:wordSpace];
}

- (CGFloat)heightFromFitWidth:(CGFloat)width {
    UILabel *lblTmp = [[UILabel alloc] init];
    lblTmp.text = self.text;
    lblTmp.font = self.font;
    [lblTmp sizeToFit];
    
    CGFloat lblMaxW = lblTmp.frame.size.width;
    CGFloat lblMaxH = lblTmp.frame.size.height;
    return ceilf(lblMaxW/width) * lblMaxH;
}

- (void)changeLineSpace:(float)space {
    NSString *labelText = self.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:space];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    self.attributedText = attributedString;
//    [label sizeToFit];
}

- (void)changeWordSpace:(float)space {
    NSString *labelText = self.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(space)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    self.attributedText = attributedString;
//    [label sizeToFit];
}

- (void)changeLineSpace:(float)lineSpace wordSpace:(float)wordSpace {
    NSString *labelText = self.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(wordSpace)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    self.attributedText = attributedString;
//    [label sizeToFit];
}

- (void)addUnderLineWithString:(NSString *)string {
    NSDictionary *attr = @{NSUnderlineStyleAttributeName:@(1)};
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:string attributes:attr];
    self.attributedText = attrStr;
}

@end

