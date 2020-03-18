//
//  SegmentedViewController.m
//  DVDataBindDemo
//
//  Created by mlgPro on 2020/3/17.
//  Copyright © 2020 DVUntilKit. All rights reserved.
//

#import "SegmentedViewController.h"
#import "SegmentedView.h"
#import "SegmentedModel.h"

@interface SegmentedViewController ()

@property(nonatomic, strong) SegmentedView *segView;
@property(nonatomic, strong) SegmentedModel *segModel;

@end

@implementation SegmentedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initViews];
    [self initModels];
    [self bindData];
}

#pragma mark - <-- Init -->
- (void)initViews {
    self.segView = (SegmentedView *)self.view;
}

- (void)initModels {
    self.segModel = [[SegmentedModel alloc] init];
}

- (void)bindData {
 
    DVDataBind
    ._inout(self.segModel, @"index")
    ._inout_ui(self.segView.segmented, @"selectedSegmentIndex", UIControlEventValueChanged)
    ._inout_ui(self.segView.stepper, @"value", UIControlEventValueChanged);
    
    
    [self.segView.btnChangeIndex addTarget:self
                                    action:@selector(onClickForChangeIndex:)
                          forControlEvents:UIControlEventTouchUpInside];
}


#pragma mark - <-- Response -->
- (void)onClickForChangeIndex:(UIButton *)sender {
    self.segModel.index = 3;
}

@end
