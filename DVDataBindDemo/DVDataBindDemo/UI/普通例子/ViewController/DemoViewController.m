//
//  DemoViewController.m
//  DVDataBindDemo
//
//  Created by mlgPro on 2020/3/18.
//  Copyright © 2020 DVUntilKit. All rights reserved.
//

#import "DemoViewController.h"
#import "DemoView.h"
#import "DemoModel.h"

@interface DemoViewController ()

@property(nonatomic, strong) DemoView *demoView;
@property(nonatomic, strong) DemoModel *demoModel;

@end

@implementation DemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self initViews];
    [self initModels];
    [self bindData];
}

#pragma mark - <-- Init -->
- (void)initViews {
    self.demoView = (DemoView *)self.view;
}

- (void)initModels {
    self.demoModel = [[DemoModel alloc] init];
}

- (void)bindData {
    
    __weak __typeof(self)weakSelf = self;
    
    DVDataBind
    ._inout(self.demoModel, @"text")
    ._inout_ui(self.demoView.textField, @"text", UIControlEventEditingChanged)
    ._out(self.demoView.label, @"text")
    ._out_key_any(@"com.text", ^(NSString *text) {
        NSString *pText = weakSelf.demoModel.text;
        NSLog(@"demoModel 最新值为 %@", pText);
    });
    
    [self.demoView.button addTarget:self
                             action:@selector(onClickForButton:)
                   forControlEvents:UIControlEventTouchUpInside];
}


#pragma mark - <-- Response -->
- (void)onClickForButton:(UIButton *)sender {
    self.demoModel.text = @"Hello World";
}


@end
