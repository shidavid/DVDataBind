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
    
    
    /**
     1）DVDataBind 必须用 in 或 inout 开头, 后面绑定先后顺序随便, 任意组合, 不影响结果
     2）in 只发送新数据, inout 可接受和发送新数据, out 只接受新数据
     3）字符串、整形、浮点型、布鲁尔类型 之间会自动转换, (除了对象类型，对象属性 必须类型一致)
     4）无需手动解绑, 自动解绑和释放内存
     
     
     (1) ._inout(self.textModel, @"num")
     绑定 普通
     第一个变量是 目标
     第二个变量是 目标拥有的 属性名
   
     (2) ._inout_ui(self.textView.textField1, @"text", UIControlEventEditingChanged)
     绑定 UI类
     第一个变量是 目标
     第二个变量是 目标 通过触发控件事件会产生数据变化的 属性名
     第三个变量是 控件事件
     
     (3) ._inout_cv(目标, @"属性", ^A类型 *(B类型 *变量名) { //A类型为 属性 的类型, B类型为 更新数据类型
             // 处理过程
             return 处理过的数据; // 属性则更新为 处理过的数据
         })
     
     (4) ._filter(^BOOL(类型 变量名){  //类型为 更新数据类型
            // 处理过程
            return YES/NO;  // 返回YES, 则正常更新数据
        })
        
        注意:
        如果更新值为 整形、浮点型、BOOL型，则类型必须是NSNumber
        ._filter(^BOOL(NSNumber *变量名){ return YES/NO; })
     
        如果更新值为多种类型，则写成 id
        ._filter(^BOOL(id 变量名){ return YES/NO; })
    */
    DVDataBind
    ._inout(self.textModel, @"num")
    ._inout(self.textModel, @"text")
    ._out(self.textView.lblNormal, @"text")
    ._out_cv(self.textView.lblConvert, @"text", ^NSString *(NSString *text) {
        // 手动转换
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
