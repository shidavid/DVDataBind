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
