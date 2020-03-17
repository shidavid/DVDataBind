//
//  TextFieldView.h
//  DVDataBindDemo
//
//  Created by mlgPro on 2020/3/17.
//  Copyright © 2020 DVUntilKit. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TextFieldView : UIView

@property (weak, nonatomic) IBOutlet UILabel *lblNormal;
@property (weak, nonatomic) IBOutlet UILabel *lblConvert;

@property (weak, nonatomic) IBOutlet UITextField *textField1;
@property (weak, nonatomic) IBOutlet UITextField *textField2;

@property (weak, nonatomic) IBOutlet UIButton *btnChangeNum;
@property (weak, nonatomic) IBOutlet UIButton *btnChangeText;

@end

NS_ASSUME_NONNULL_END
