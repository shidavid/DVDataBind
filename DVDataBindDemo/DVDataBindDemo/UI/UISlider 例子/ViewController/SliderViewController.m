//
//  SliderViewController.m
//  DVDataBindDemo
//
//  Created by mlgPro on 2020/3/17.
//  Copyright © 2020 DVUntilKit. All rights reserved.
//

#import "SliderViewController.h"
#import "SliderView.h"
#import "SliderModel.h"

@interface SliderViewController ()

@property(nonatomic, strong) SliderView *sliderView;
@property(nonatomic, strong) SliderModel *sliderModel;

@end

@implementation SliderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initViews];
    [self initModels];
    [self bindData];
    [self loadData];
}

#pragma mark - <-- Init -->
- (void)initViews {
    self.sliderView = (SliderView *)self.view;
}

- (void)initModels {
    self.sliderModel = [[SliderModel alloc] init];
}

- (void)bindData {
    /**
     1）DVDataBind 必须用 in 或 inout 开头, 后面绑定先后顺序随便, 任意组合, 不影响结果
     2）in 只发送新数据, inout 可接受和发送新数据, out 只接受新数据
     3）字符串、整形、浮点型、布鲁尔类型 之间会自动转换, (除了对象类型，对象属性 必须类型一致)
     4）无需手动解绑, 自动解绑和释放内存
     
     
     (1) ._inout(self.textModel, @"num")
     绑定 普通
     第一个变量是 目标
     第二个变量是 目标拥有的 属性名
    */
    
    DVDataBind
    ._inout(self.sliderModel, @"sliderValue")
    ._out(self.sliderView.lblTitle, @"text")
    ._inout_ui(self.sliderView.slider, @"value", UIControlEventValueChanged)
    ._out_cv(self.sliderView.progressView, @"progress", ^NSNumber *(NSNumber *value) {
        float tempValue = [value floatValue];
        tempValue = tempValue / 100.f;
        return @(tempValue);
    });
    
    
    
    [self.sliderView.btnChangeValue addTarget:self
                                       action:@selector(onClickForChangeValue:)
                             forControlEvents:UIControlEventTouchUpInside];
}

- (void)loadData {
    self.sliderModel.sliderValue = 20;
}

#pragma mark - <-- Response -->
- (void)onClickForChangeValue:(UIButton *)sender {
    self.sliderModel.sliderValue = 50;
}

@end
