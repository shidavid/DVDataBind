//
//  TextFieldViewController.m
//  DVDataBindDemo
//
//  Created by mlgPro on 2020/3/17.
//  Copyright © 2020 DVUntilKit. All rights reserved.
//

#import "TextFieldViewController.h"
#import "TextFieldView.h"
#import "TextFieldModel.h"

@interface TextFieldViewController ()

@property(nonatomic, strong) TextFieldView *textView;
@property(nonatomic, strong) TextFieldModel *textModel;

@end

@implementation TextFieldViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initViews];
    [self initModels];
    [self bindData];
}

#pragma mark - <-- Init -->
- (void)initViews {
    self.textView = (TextFieldView *)self.view;
}

- (void)initModels {
    self.textModel = [[TextFieldModel alloc] init];
}

- (void)bindData {
    __weak __typeof(self)weakSelf = self;
    
    DVDataBind
    ._inout(self.textModel, @"num")
    ._inout(self.textModel, @"text")
    ._out(self.textView.lblNormal, @"text")
    ._out_cv(self.textView.lblConvert, @"text", ^NSString *(NSString *text) {
        NSString *tempText = [NSString stringWithFormat:@"AAA - %@ - BBB",text];
        return tempText;
    })
    ._inout_ui(self.textView.textField1, @"text", UIControlEventEditingChanged)
    ._inout_ui(self.textView.textField2, @"text", UIControlEventEditingChanged)
    ._filter(^BOOL(id value) {  // 返回YES 则正常数据更新
        if ([value isKindOfClass:[NSString class]]) {
            NSString *text = (NSString *)value;
            return text.length <= 20;
        }
        return YES;
    })
    ._out_key_any(@"自定义名", ^{
        int num = weakSelf.textModel.num;
        NSString *text = weakSelf.textModel.text;
        // 可断点查看 model的属性 是否同步改变
        NSLog(@"[TextFieldViewController LOG]: textModel -> num 为 %d", num);
        NSLog(@"[TextFieldViewController LOG]: textModel -> text 为 %@", text);
    });
    
    
    
    [self.textView.btnChangeNum addTarget:self
                                   action:@selector(onClickForChangeNum:)
                         forControlEvents:UIControlEventTouchUpInside];
    [self.textView.btnChangeText addTarget:self
                                   action:@selector(onClickForChangeText:)
                         forControlEvents:UIControlEventTouchUpInside];
}


#pragma mark - <-- Response -->
- (void)onClickForChangeNum:(UIButton *)sender {
    self.textModel.num = 123456;
}

- (void)onClickForChangeText:(UIButton *)sender {
    self.textModel.text = @"Hello World";
}



@end
