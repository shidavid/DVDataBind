//
//  SwitchViewController.m
//  DVDataBindDemo
//
//  Created by mlgPro on 2020/3/17.
//  Copyright © 2020 DVUntilKit. All rights reserved.
//

#import "SwitchViewController.h"
#import "SwitchView.h"
#import "SwitchModel.h"

@interface SwitchViewController ()

@property(nonatomic, strong) SwitchView *swView;
@property(nonatomic, strong) SwitchModel *swModel;

@end

@implementation SwitchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     
    [self initViews];
    [self initModels];
    [self bindData];
}

#pragma mark - <-- Init -->
- (void)initViews {
    self.swView = (SwitchView *)self.view;
}

- (void)initModels {
    self.swModel = [[SwitchModel alloc] init];
}

- (void)bindData {
    __weak __typeof(self)weakSelf = self;
    
    DVDataBind
    ._inout(self.swModel, @"isON")
    ._in_ui(self.swView.inSW1, @"on", UIControlEventValueChanged)
    ._in_ui(self.swView.inSW2, @"on", UIControlEventValueChanged)
    ._in_ui(self.swView.inSW3, @"on", UIControlEventValueChanged)
    ._inout_ui(self.swView.inoutSW1, @"on", UIControlEventValueChanged)
    ._inout_ui(self.swView.inoutSW2, @"on", UIControlEventValueChanged)
    ._inout_ui(self.swView.inoutSW3, @"on", UIControlEventValueChanged)
    ._out(self.swView.outSW1, @"on")
    ._out(self.swView.outSW2, @"on")
    ._out(self.swView.outSW3, @"on")
    ._out_not(self.swView.notSW, @"on")
    ._inout_ui(self.swView.textField, @"text", UIControlEventEditingChanged)
    ._out(self.swView.btnChangeEnable , @"enabled")
    ._out_key_any(@"自定义名", ^{
        BOOL isON = weakSelf.swModel.isON;
        // 可断点查看 model的isON 是否同步改变
        NSLog(@"[SwitchViewController LOG]: swModel -> isON 为 %@", isON ? @"YES" : @"NO");
    });
    
    
    DVDataBind
    ._in_ui(self.swView.btnChangeIsON, @"highlighted", UIControlEventTouchUpInside)
    ._out_key_any(@"自定义", ^{
        weakSelf.swModel.isON = !weakSelf.swModel.isON;  //model绑定了UI，直接改变model的数据会自动更新UI
    });
}

@end
