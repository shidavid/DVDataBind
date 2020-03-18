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
