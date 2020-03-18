//
//  ArrayViewController.m
//  DVDataBindDemo
//
//  Created by mlgPro on 2020/3/17.
//  Copyright © 2020 DVUntilKit. All rights reserved.
//

#import "ArrayViewController.h"
#import "ArrayView.h"
#import "ArrayModel.h"


@interface ArrayViewController ()

@property(nonatomic, strong) ArrayView *arrayView;
@property(nonatomic, strong) ArrayModel *arrayModel;

@end

@implementation ArrayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initViews];
    [self initModels];
    [self bindData];
}

#pragma mark - <-- Init -->
- (void)initViews {
    self.arrayView = (ArrayView *)self.view;
}

- (void)initModels {
    self.arrayModel = [[ArrayModel alloc] init];
    [self.arrayModel.array addObject:@""];
    [self.arrayModel.array addObject:@(0)];
}

- (void)bindData {
    __weak __typeof(self)weakSelf = self;
    
    DVDataBind
    ._inout_ui(self.arrayView.textField1, @"text", UIControlEventEditingChanged)
    ._inout_arr(self.arrayModel, @"array", 0)
    ._out_key_any(@"com.array.0", ^{
        NSString *text = weakSelf.arrayModel.array[0];
        NSLog(@"[ArrayViewController LOG]: array第0位 -> %@",text);
    });
    
    DVDataBind
    ._inout_ui(self.arrayView.textField2, @"text", UIControlEventEditingChanged)
    ._inout_arr(self.arrayModel, @"array", 1)
    ._out_key_any(@"com.array.1", ^ {
        NSNumber *value = weakSelf.arrayModel.array[1];
        NSString *text = [value stringValue];
        NSLog(@"[ArrayViewController LOG]: array第1位 -> %@",text);
    });
    

    [self.arrayView.btnChange1 addTarget:self
                                  action:@selector(onClickForChange1:)
                        forControlEvents:UIControlEventTouchUpInside];
    [self.arrayView.btnChange2 addTarget:self
                                  action:@selector(onClickForChange2:)
                        forControlEvents:UIControlEventTouchUpInside];
}


#pragma mark - <-- Response -->
- (void)onClickForChange1:(UIButton *)sender {
    NSMutableArray *array = [self.arrayModel mutableArrayValueForKey:@"array"];
    array[0] = @"Hello World";
}

- (void)onClickForChange2:(UIButton *)sender {
    NSMutableArray *array = [self.arrayModel mutableArrayValueForKey:@"array"];
    array[1] = @(123456);
}

@end
