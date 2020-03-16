//
//  UIViewController+AOP.m
//  French
//
//  Created by DV on 2019/7/31.
//  Copyright © 2019 iOS. All rights reserved.
//

#import "UIViewController+AOP.h"

@implementation UIViewController (AOP)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        // 页面正在启动
        [self exchangeInstanceMethodWithOriginalSel:@selector(viewDidLoad)
                                        swizzledSel:@selector(aop_base_viewDidLoad)];
        [self exchangeInstanceMethodWithOriginalSel:@selector(aop_base_viewDidLoad)
                                        swizzledSel:@selector(aop_data_viewDidLoad)];
        [self exchangeInstanceMethodWithOriginalSel:@selector(aop_data_viewDidLoad)
                                        swizzledSel:@selector(aop_ui_viewDidLoad)];
        
        // 页面准备进入
        [self exchangeInstanceMethodWithOriginalSel:@selector(viewWillAppear:)
                                        swizzledSel:@selector(aop_base_viewWillAppear:)];
        [self exchangeInstanceMethodWithOriginalSel:@selector(aop_base_viewWillAppear:)
                                        swizzledSel:@selector(aop_data_viewWillAppear:)];
        [self exchangeInstanceMethodWithOriginalSel:@selector(aop_data_viewWillAppear:)
                                        swizzledSel:@selector(aop_ui_viewWillAppear:)];
        
        // 页面已经呈现
        [self exchangeInstanceMethodWithOriginalSel:@selector(viewDidAppear:)
                                        swizzledSel:@selector(aop_base_viewDidAppear:)];
        [self exchangeInstanceMethodWithOriginalSel:@selector(aop_base_viewDidAppear:)
                                        swizzledSel:@selector(aop_data_viewDidAppear:)];
        [self exchangeInstanceMethodWithOriginalSel:@selector(aop_data_viewDidAppear:)
                                        swizzledSel:@selector(aop_ui_viewDidAppear:)];
      
        // 页面准备离开
        [self exchangeInstanceMethodWithOriginalSel:@selector(viewWillDisappear:)
                                        swizzledSel:@selector(aop_base_viewWillDisappear:)];
        [self exchangeInstanceMethodWithOriginalSel:@selector(aop_base_viewWillDisappear:)
                                        swizzledSel:@selector(aop_data_viewWillDisappear:)];
        [self exchangeInstanceMethodWithOriginalSel:@selector(aop_data_viewWillDisappear:)
                                        swizzledSel:@selector(aop_ui_viewWillDisappear:)];
        
        // 页面已经关闭
        [self exchangeInstanceMethodWithOriginalSel:@selector(viewDidDisappear:)
                                        swizzledSel:@selector(aop_base_viewDidDisappear:)];
        [self exchangeInstanceMethodWithOriginalSel:@selector(aop_base_viewDidDisappear:)
                                        swizzledSel:@selector(aop_data_viewDidDisappear:)];
        [self exchangeInstanceMethodWithOriginalSel:@selector(aop_data_viewDidDisappear:)
                                        swizzledSel:@selector(aop_ui_viewDidDisappear:)];
        
        // 内存溢出警告
        [self exchangeInstanceMethodWithOriginalSel:@selector(didReceiveMemoryWarning)
                                        swizzledSel:@selector(aop_base_didReceiveMemoryWarning)];
        

        // Debug层
        [self exchangeInstanceMethodWithOriginalSel:@selector(aop_ui_viewDidLoad)
                                        swizzledSel:@selector(aop_debug_viewDidLoad)];
        [self exchangeInstanceMethodWithOriginalSel:@selector(aop_ui_viewWillAppear:)
                                        swizzledSel:@selector(aop_debug_viewWillAppear:)];
        [self exchangeInstanceMethodWithOriginalSel:@selector(aop_ui_viewDidAppear:)
                                        swizzledSel:@selector(aop_debug_viewDidAppear:)];
        [self exchangeInstanceMethodWithOriginalSel:@selector(aop_ui_viewWillDisappear:)
                                        swizzledSel:@selector(aop_debug_viewWillDisappear:)];
        [self exchangeInstanceMethodWithOriginalSel:@selector(aop_ui_viewDidDisappear:)
                                        swizzledSel:@selector(aop_debug_viewDidDisappear:)];
    });
}


#pragma mark - <-------------------- ViewController 第一层 基础层 !!!!!!! 慎重修改 !!!!!!!!!! -------------------->
- (void)aop_base_viewDidLoad {
    if (self.isUIViewController) {
        [self aop_base_viewDidLoad];
    } else {
        [self aop_debug_viewDidLoad];
    }
}

- (void)aop_base_viewWillAppear:(BOOL)animated {
    if (self.isUIViewController) {
        [DVManager.app.viewControllerStack addObject:self];
        DVManager.app.currentViewController = self;
        [self aop_base_viewWillAppear:animated];
    } else {
        [self aop_debug_viewWillAppear:animated];
    }
}

- (void)aop_base_viewDidAppear:(BOOL)animated {
    if (self.isUIViewController) {
        [self aop_base_viewDidAppear:animated];
    } else {
        [self aop_debug_viewDidAppear:animated];
    }
}

- (void)aop_base_viewWillDisappear:(BOOL)animated {
    if (self.isUIViewController) {
        NSMutableArray<UIViewController *> *vcStack = DVManager.app.viewControllerStack;
        [vcStack removeLastObject];
        if (vcStack.count > 0) {
            DVManager.app.currentViewController = vcStack.lastObject;
        }
        
        [self aop_base_viewWillDisappear:animated];
    } else {
        [self aop_debug_viewWillDisappear:animated];
    }
}

- (void)aop_base_viewDidDisappear:(BOOL)animated {
    if (self.isUIViewController) {
        [self aop_base_viewDidDisappear:animated];
    } else {
        [self aop_debug_viewDidDisappear:animated];
    }
}

- (void)aop_base_didReceiveMemoryWarning {
    [self aop_base_didReceiveMemoryWarning];
}

- (BOOL)isUIViewController {
    return !([NSStringFromClass(self.class) hasPrefix:@"UI"] || [NSStringFromClass(self.class) hasPrefix:@"_UI"]);
}


#pragma mark - <-------------------- ViewController 第二层 数据处理层 -------------------->
- (void)aop_data_viewDidLoad {
    [self aop_data_viewDidLoad];
}

- (void)aop_data_viewWillAppear:(BOOL)animated {
    NSLog(@">->->->->-> 进入: %@",[self class]);
    
    [self aop_data_viewWillAppear:animated];
}

- (void)aop_data_viewDidAppear:(BOOL)animated {
    [self aop_data_viewDidAppear:animated];
}

- (void)aop_data_viewWillDisappear:(BOOL)animated {
    NSLog(@"<-<-<-<-<-< 退出: %@",[self class]);
   
    [self aop_data_viewWillDisappear:animated];
}

- (void)aop_data_viewDidDisappear:(BOOL)animated {
    [self aop_data_viewDidDisappear:animated];
}


#pragma mark - <-------------------- ViewController 第三层 UI层 -------------------->
- (void)aop_ui_viewDidLoad {
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        [self setEdgesForExtendedLayout:(UIRectEdgeNone)];
    }
    self.view.backgroundColor = [UIColor whiteColor];
    
//    if ([self respondsToSelector:@selector(initViews)]) {
//        [self performSelector:@selector(initViews)];
//    }
//    if ([self respondsToSelector:@selector(initModels)]) {
//        [self performSelector:@selector(initModels)];
//    }
//    if ([self respondsToSelector:@selector(bindViewModel)]) {
//        [self performSelector:@selector(bindViewModel)];
//    }
//    if ([self respondsToSelector:@selector(loadData)]) {
//        [self performSelector:@selector(loadData)];
//    }
    
    [self aop_ui_viewDidLoad];
}

- (void)aop_ui_viewWillAppear:(BOOL)animated {
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                             style:UIBarButtonItemStylePlain target:nil
                                                                            action:nil];
    [self aop_ui_viewWillAppear:animated];
}

- (void)aop_ui_viewDidAppear:(BOOL)animated {
    [self aop_ui_viewDidAppear:animated];
}

- (void)aop_ui_viewWillDisappear:(BOOL)animated {
    [self aop_ui_viewWillDisappear:animated];
}

- (void)aop_ui_viewDidDisappear:(BOOL)animated {
    [self aop_ui_viewDidDisappear:animated];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    [self.view endEditing:YES];
}



#pragma mark - <-------------------- ViewController 第四层 DEBUG层 -------------------->
- (void)aop_debug_viewDidLoad {
    
    [self aop_debug_viewDidLoad];
}

- (void)aop_debug_viewWillAppear:(BOOL)animated {
    
    [self aop_debug_viewWillAppear:animated];
}

- (void)aop_debug_viewDidAppear:(BOOL)animated {
    
    [self aop_debug_viewDidAppear:animated];
}

- (void)aop_debug_viewWillDisappear:(BOOL)animated {
    
    [self aop_debug_viewWillDisappear:animated];
}

- (void)aop_debug_viewDidDisappear:(BOOL)animated {
    
    [self aop_debug_viewDidDisappear:animated];
}

@end
