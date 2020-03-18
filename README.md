>前言：2年前空闲时间玩了Vue.js, 发现数据双向绑定，开发起来如此轻松简洁，我了解iOS也有类似的框架 ReactiveCocoa,  ReactiveCocoa有点复杂和笨重，我只需要简单点的数据绑定，所以写了一个轻量级的数据绑定，麻烦大家看一下，有问题请指点下

***
###1.介绍:
>1) 不限定只能UI与Model绑定，只要支持KVC的数据都能绑定
>2) 使用链式编程，支持多项绑定
>3)  支持单向数据流/双向数据流
>4) 支持 字符串,整形,浮点型,布尔类型 之间数据自动转换 (对象类型除外)
>5) 支持过滤, 转换, 观察数组某一位数据变化
>6) 无需继承父类, 无需手动解绑, 自动解绑和释放内存

***
###2.思路
***
###3.用法
- DVDataBind 必须用 in 或 inout 开头, 后面绑定先后顺序随便, 任意组合, 不影响结果
- in 只发送新数据, inout 可接受和发送新数据, out 只接受新数据

##### 1. 普通绑定
```
// a1、a2、b、c 正常情况是同一类型, 如果不同类型查看下面 "3.转换"
DVDataBind
._in(objectA, @"a1")
._inout(objectA, @"a2")
._inout(objectB, @"b")
._out(objectC, @"c");
```

##### 2. UI 绑定
```
/*
  UI: 支持 UIControlEvents
  property: 通过触发 UIControlEvents 会产生数据变化的 属性名
*/
._inout_ui(UI, @"property", UIControlEvents)


举例:
/*
 view  -> UITextField *textField;
 model -> NSString *text;
*/
DVDataBind
._inout_ui(view.textField, @"text", UIControlEventEditingChanged)
._inout(model, "text");

/*
 view  -> UILabel *label;
 model -> NSString *text;
 UILabel 不支持 UIControlEvents
*/
DVDataBind
._in(model, "text");
._out(view.label, @"text");

/*
 view  -> UISwitch * switch;
 model -> BOOL isON;
*/
DVDataBind
._inout_ui(view.switch, @"on", UIControlEventValueChanged)
._inout(model, "isON");

/*
 view  -> UIImageView *imageView;
 model -> UIImage *image;
 UIImageView 不支持 UIControlEvents
*/
DVDataBind
._in(model, "image");
._out(view.imageView, @"image");

/*
 view  -> UISlider *slider;
 model -> float value;
*/
DVDataBind
._inout_ui(view.slider, @"value", UIControlEventValueChanged)
._inout(model, "value");

/*
 view  -> UIProgressView *progressView;
 model -> float value;
*/
DVDataBind
._inout_ui(view.progressView, @"progress", UIControlEventValueChanged)
._inout(model, "value");

/*
  view  -> UISegmentedControl *segmented;
  model -> int index;
*/
DVDataBind
._inout_ui(view.segmented, @"selectedSegmentIndex", UIControlEventValueChanged)
._inout(model, "index");

/*
 view  -> UIStepper *stepper;
 model -> int index;
*/
DVDataBind
._inout_ui(view.stepper, @"value", UIControlEventValueChanged)
._inout(model, "index");

/*
 view  -> UIButton *button;
 点击Button改变的是highlighted值，highlighted容易打错, 还是建议用 addTarget
*/
DVDataBind
._in_ui(view.button, @"highlighted", UIControlEventTouchUpInside)
._out_key_any(@"自定义", ^{
        
});
```



##### 3.转换

```
/*
普通对象转换
ClassA a;
ClassB b;
*/
DVDataBind
._inout_cv(objectA, @"a", ^ClassA *(ClassB *value) {
    // 处理程序
    return 转换为ClassA的数据更新 objectA.a;
})
._inout_cv(objectB, @"b", ^ClassB *(ClassA *value) {
    // 处理程序
    return 转换为ClassB的数据更新 objectB.b;
} );


特殊情况:
/*
view  -> UITextField *textField;
model -> NSString *text;
model -> int number;
支持 字符串,整形,浮点型,布尔类型 之间数据自动转换 (对象类型除外)
如果text为非数字, 则number为0
*/
DVDataBind
._inout_ui(view.textField, @"text", UIControlEventEditingChanged)
._inout(model, "text")
._inout(model, "number"); 

/*
view  -> UITextField *textField;
view  -> UILabel *label;
model -> NSString *text;
model -> int number;
这里 更新值有 NSString, int 类型，上面说过这些类型之间自动转换
model->text 获取更新值自动转为NSString, 处理完返回NSString 再去更新自己
model->number 获取更新值自动转为NSNumber, 处理完返回NSNumber 再去更新自己
*/
DVDataBind
._inout_ui(view. textField, @"text", UIControlEventEditingChanged)
._out_cv(view. label, @"text", ^NSString *(NSString *text) {
    NSString *tempText = [NSString stringWithFormat:@"AAA - %@ - BBB",text];
    return tempText;
})
._inout_cv(self.textModel, @"text", ^NSString *(NSString *text) {
    NSString *tempText = [NSString stringWithFormat:@"CCC - %@ - DDD",text];
    return tempText;
} )
._inout_cv(self.textModel, @"number", ^NSNumber *(NSNumber *num) {
    int value = [num intValue];
    return @(value + 123456);
});

```

##### 4.数组
```
// array必须为NSMutableArray类型, 绑定前必须初始化, 数组可提前赋值, 也可以为空
._inout_arr(objectA, @"array", 1)

// 更新数组某位必须该方法
NSMutableArray *pArray = [objectA mutableArrayValueForKey:@"array"];
pArray[0] = @(123456);
pArray[1] = @"Hellow World";
pArray[2] = object;
```

##### 5.取反
```
// a类型为BOOL类型
._out_not(objectA, @"a");

举例:
/*
 view -> UITextField *textField;
 view  -> UISwitch * switch;
 view  -> UISwitch * switchNot;
 当textField.text长度不为0,  则switch.on = YES, switchNot.on = NO
 当 switch.on = NO, switchNot.on = YES
*/
DVDataBind
._in_ui(view.textField, @"text", UIControlEventEditingChanged)
._inout_ui(view.switch, @"on", UIControlEventValueChanged)
._out_not(view.switchNot, @"on")
```

##### 6.输出Block
- 支持绑定多个输出Block, 更新数据不支持自动转换
```
// 自定义名不能一样, 类型为更新数据类型 （类型、变量可不写）
._out_key_any(@"自定义名1", ^(Class 变量){
     // 处理代码1
 })
._out_key_any(@"自定义名2", ^(Class 变量){
     // 处理代码2
 })
._out_key_any(@"自定义名3", ^{
     // 处理代码3
 });


举例:
// 整形、浮点型、布尔类型 类型必须用NSNumber
._out_key_any(@"自定义名", ^(NSNumber *num){ 
     // 处理代码
 });

//更新值只是NSString类型
._out_key_any(@"自定义名", ^(NSString *text){  
     // 处理代码
 });

// 如果更新数据类型多样,就用id
._out_key_any(@"自定义名", ^(id value){
    //判断value为哪个Class, 进行处理
 });
```



##### 7.过滤
- 一个数据链只能绑定一个过滤, 更新数据不支持自动转换
```
._filter(^BOOL(Class 变量) {  
    return YES/NO; // 返回YES 则正常数据更新, NO不更新
})


举例:
//更新值只是NSString类型
._filter(^BOOL(NSString *text) {  
    return text.length <= 20; //限制字符串长度为20
})

//更新值只是NSNumber类型
._filter(^BOOL(NSNumber *num) {  
    return [num intValue] <= 100; //限制数字最大为100
})

//如果更新值为多类型,例如有NSString,NSNumber, 则写id
._filter(^BOOL(id value) {  
    //判断value为哪个Class, 进行处理  
    return YES/NO;
})

```

##### 8.中途增加绑定
```
```

##### 9.解绑
- 已经支持 当对象内存释放自动解绑, 无需手动解绑, 如果想手动解绑可用以下API
```
// 解绑objectA的所有 property
[DVDataBind unbindWithTarget:objectA];
// 解绑objectA的 a
[DVDataBind unbindWithTarget:objectA property:@"a"];
// 解绑objectA的 控件a
[DVDataBind unbindWithTarget:objectA property:@"a" controlEvent:UIControlEventValueChanged];
// 解绑objectA的 数组a 的某位
[DVDataBind unbindWithTarget:objectA property:@"a" index:1];
// 解绑objectA的 a 所在数据链的 输出Block "XXX"
[DVDataBind unbindWithTarget: objectA property:@"a" outBlockKey:@"XXX"];
```

***
###4.结语:
github地址: https://github.com/shidavid/DVDataBind
谢谢大家观看,有兴趣麻烦点个星星关注下
