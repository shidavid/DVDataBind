//
//  SwitchView.h
//  DVDataBindDemo
//
//  Created by mlgPro on 2020/3/17.
//  Copyright © 2020 DVUntilKit. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SwitchView : UIView

@property (weak, nonatomic) IBOutlet UISwitch *inSW1;
@property (weak, nonatomic) IBOutlet UISwitch *inSW2;
@property (weak, nonatomic) IBOutlet UISwitch *inSW3;

@property (weak, nonatomic) IBOutlet UISwitch *inoutSW1;
@property (weak, nonatomic) IBOutlet UISwitch *inoutSW2;
@property (weak, nonatomic) IBOutlet UISwitch *inoutSW3;

@property (weak, nonatomic) IBOutlet UISwitch *outSW1;
@property (weak, nonatomic) IBOutlet UISwitch *outSW2;
@property (weak, nonatomic) IBOutlet UISwitch *outSW3;
@property (weak, nonatomic) IBOutlet UISwitch *notSW;

@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (weak, nonatomic) IBOutlet UIButton *btnChangeEnable;

@property (weak, nonatomic) IBOutlet UIButton *btnChangeIsON;

@end

NS_ASSUME_NONNULL_END
