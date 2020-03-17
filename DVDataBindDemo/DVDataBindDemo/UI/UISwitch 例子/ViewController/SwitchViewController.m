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
    
    /**
     DVDataBind 必须用 in 或 inout 开头, 后面绑定先后顺序随便, 任意组合, 不影响结果
     in 只发送新数据, inout 可接受和发送新数据, out 只接受新数据
     字符串、整形、浮点型、布鲁尔类型 之间会自动转换, (除了对象类型，对象属性 必须类型一致)
   
     
     1) ._inout(self.swModel, @"isON")
     绑定 普通
     第一个变量是 目标
     第二个变量是 目标拥有的 属性名
   
     
     2) ._inout_ui(self.swView.inoutSW1, @"on", UIControlEventValueChanged)
     绑定 UI类
     第一个变量是 目标
     第二个变量是 目标 通过触发控件事件会产生数据变化的 属性名
     第三个变量是 控件事件
    */
    DVDataBind
    ._inout(self.swModel, @"isON")
    ._in_ui(self.swView.inSW1, @"on", UIControlEventValueChanged)
    ._in_ui(self.swView.inSW2, @"on", UIControlEventValueChanged)
    ._in_ui(self.swView.inSW3, @"on", UIControlEventValueChanged)
    ._inout_ui(self.swView.inoutSW1, @"on", UIControlEventValueChanged)
    ._inout_ui(self.swView.inoutSW2, @"on", UIControlEventValueChanged)
    ._inout_ui(self.swView.inoutSW3, @"on", UIControlEventValueChanged)
    ._out_ui(self.swView.outSW1, @"on", UIControlEventValueChanged)
    ._out_ui(self.swView.outSW2, @"on", UIControlEventValueChanged)
    ._out_ui(self.swView.outSW3, @"on", UIControlEventValueChanged)
    ._inout_ui(self.swView.textField, @"text", UIControlEventEditingChanged)
    ._out(self.swView.btnChangeEnable , @"enabled"); // 因为这里只是改变enable属性，没有手动触发控件事件，可不写控件事件
    
    
    
    [self.swView.btnChangeIsON addTarget:self
                                  action:@selector(onClickForChanageIsON:)
                        forControlEvents:UIControlEventTouchUpInside];
}


#pragma mark - <-- Response -->
- (void)onClickForChanageIsON:(UIButton *)sender {
    self.swModel.isON = !self.swModel.isON;  //model绑定了UI，直接改变model的数据会自动更新UI
}

@end
