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
