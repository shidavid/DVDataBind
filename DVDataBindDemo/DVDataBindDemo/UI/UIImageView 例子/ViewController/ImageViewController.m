//
//  ImageViewController.m
//  DVDataBindDemo
//
//  Created by mlgPro on 2020/3/17.
//  Copyright © 2020 DVUntilKit. All rights reserved.
//

#import "ImageViewController.h"
#import "ImageView.h"
#import "ImageModel.h"

@interface ImageViewController ()

@property(nonatomic, strong) ImageView *imageView;
@property(nonatomic, strong) ImageModel *imageModel;

@end

@implementation ImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initViews];
    [self initModels];
    [self bindData];
}

#pragma mark - <-- Init -->
- (void)initViews {
    self.imageView = (ImageView *)self.view;
}

- (void)initModels {
    self.imageModel = [[ImageModel alloc] init];
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
    ._inout(self.imageView.imageView, @"image")
    ._inout(self.imageModel, @"image");
    
    
    
    [self.imageView.btnChangeImage addTarget:self
                                      action:@selector(onClickForChangeImage:)
                            forControlEvents:UIControlEventTouchUpInside];
    [self.imageView.btnChangeNil addTarget:self
                                    action:@selector(onClickForChangeNil:)
                          forControlEvents:UIControlEventTouchUpInside];
}


#pragma mark - <-- Response -->
- (void)onClickForChangeImage:(UIButton *)sender {
    self.imageModel.image = [UIImage imageNamed:@"icon-dog.jpg"];
}

- (void)onClickForChangeNil:(UIButton *)sender {
    self.imageModel.image = nil;
}

@end
