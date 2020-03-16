//
//  OneOnOneViewontroller.m
//  DVDataBindDemo
//
//  Created by mlgPro on 2020/3/16.
//  Copyright © 2020 DVUntilKit. All rights reserved.
//

#import "OneOnOneViewontroller.h"
#import "OneOnOneView.h"
#import "OneOnOneModel.h"

@interface OneOnOneViewontroller ()

@property(nonatomic, strong) OneOnOneView *oneView;
@property(nonatomic, strong) OneOnOneModel *oneModel;

@end

@implementation OneOnOneViewontroller

- (void)viewDidLoad {
    [super viewDidLoad];
     
    [self initViews];
    [self initModels];
    [self bindData];
    [self loadData];
}

#pragma mark - <-- Init -->
- (void)initViews {
    self.oneView = [OneOnOneView viewWithNib];
    self.oneView.frame = DVFrame.frame_not_nav;
}

- (void)initModels {
    self.oneModel = [[OneOnOneModel alloc] init];
}

- (void)bindData {
    __weak __typeof(self)weakSelf = self;
    
    DVDataBind
    ._inout
}

- (void)loadData {
    
    
}

@end
