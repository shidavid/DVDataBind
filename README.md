详情请看简书 ：https://www.jianshu.com/p/2a2ce5bf2306

>前言：2年前空闲时间玩了Vue.js, 发现利用数据双向绑定，开发如此轻松简洁，我了解iOS也有类似的框架 ReactiveCocoa,  ReactiveCocoa有点复杂和笨重，我只需要简单点的数据绑定，所以写了一个轻量级的数据绑定，麻烦大家看一下，有问题请指点下

***
### 1.介绍:
例子:
```
DVDataBind
._inout(self.demoModel, @"text")
._inout_ui(self.demoView.textField, @"text", UIControlEventEditingChanged)
._out(self.demoView.label, @"text")

// 点击button
- (void)onClickForButton:(UIButton *)sender {
    self.demoModel.text = @"Hello World";
}
```
![](https://upload-images.jianshu.io/upload_images/2145107-cc563c47d312d653.gif?imageMogr2/auto-orient/strip)


>1) 不限定只能UI与Model绑定，只要支持KVC的数据都能绑定
>2) 使用链式编程，支持多项绑定
>3)  支持单向数据流/双向数据流
>4) 支持 字符串,整形,浮点型,布尔类型 之间数据自动转换 (对象类型除外)
>5) 支持过滤, 转换, 观察数组某一位数据变化
>6) 无需继承父类，无需手动解绑， 当目标对象内存释放，DataBind自动解绑和释放内存






***
### 2.思路
1. A 与 B 双向数据绑定，Ain数据变化更新Aout、Bout数据，Bin同理
![](https://upload-images.jianshu.io/upload_images/2145107-30f94ef259dd2e57.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

2. 有时候 A 与 B 双向绑定，B 与 C 双向绑定, 其实相当于 A、B、C 一起绑定在一条数据链Chain上, 每当有一个in数据变化, 发送新数据到Chain上，再由Chain更新所有的out数据
![](https://upload-images.jianshu.io/upload_images/2145107-3df76354611cd9af.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

这样实现单向/双向数据流
![](https://upload-images.jianshu.io/upload_images/2145107-871579167ad13e50.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


3. 利用KVO, 数据链就相当于Obverse，每个Observer用一个ChainCode标记，Observer观察每个in数据变化，并更新到所有Out数据
![](https://upload-images.jianshu.io/upload_images/2145107-e7ed12a7e7c9d0c0.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)



***
### 3.用法
- DVDataBind 必须用 _in 或 _inout 开头, 后面绑定顺序先后随意, 任意组合, 不影响结果
- _in 只发送新数据，_inout 可接受和发送新数据，_out 只接受新数据
- 目标对象必须支持KVC
- 目标对象不能为nil, property可为nil
- Swift也能使用, 只不过更新数据不能直接 object.property = xxx , 需要 object.setValue(xxx, forKey: "property")

##### 1. 普通绑定
```
/*
  object为目标对象， property是object拥有的属性
  object不能为nil，property可为nil
*/
._inout(object, @"property")


举例:
/*
  objectA -> a1, a2
  objectB -> b
  objectC -> c
  a1、a2、b、c 正常情况为同一类型, 如果不同类型查看下面 "3.转换"
*/
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
  property: 通过触发 UIControlEvents 会产生数据变化的 属性
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
- 支持 字符串,整形,浮点型,布尔类型 之间数据自动转换 (对象类型除外)
```
/*
普通对象转换
ClassA objectA -> a;
ClassB objectB -> b;
*/
DVDataBind
._inout_cv(objectA, @"a", ^ClassA *(ClassB *变量) {
    // 处理程序
    return 转换为ClassA的数据更新 objectA.a;
})
._inout_cv(objectB, @"b", ^ClassB *(ClassA *变量) {
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
/*
  objectA -> array
  array必须为NSMutableArray类型, 绑定前必须初始化, 数组可提前赋值, 也可以为空
*/
._inout_arr(objectA, @"array", 1)

// 更新数组某位必须该方法
NSMutableArray *pArray = [objectA mutableArrayValueForKey:@"array"];
pArray[0] = @(123456);
pArray[1] = @"Hellow World";  //这里更改了第1位数据, 响应
pArray[2] = object;
```

##### 5.取反
```
// property类型为BOOL类型
._out_not(objectA, @"property");


举例:
/*
  view -> UITextField *textField;
  view -> UISwitch * switch;
  view -> UISwitch * switchNot;
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
// 整形、浮点型、布尔类型，必须是NSNumber 类型
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

//更新值为整形、浮点型、布尔类型，必须是NSNumber类型
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
// 一开始绑定生成一条数据链
DVDataBind
._inout(objectA, @"a")
._inout(objectB, @"b")

// 将objectBB.bb 加入 objectA.a 的数据链中,
// objectA.a、objectB.b、objectBB.bb在同一数据链上
DVDataBind
._inout(objectA, @"a")
._inout(objectBB, @"bb")

// 相当于
DVDataBind
._inout(objectA, @"a")
._inout(objectB, @"b")
._inout(objectBB, @"bb")
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
### 4.如何导入项目
1. 编译DVDataBindKitShell
![](https://upload-images.jianshu.io/upload_images/2145107-9b7b9e7e1b84708f.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/800)

2. 生成Framework拖入项目
![](https://upload-images.jianshu.io/upload_images/2145107-d63774bc448d86c6.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/800)

3. 项目 Target -> Build Settings -> Linking ->Other Linker Flags 添加参数:  -all_load  -ObjC
![](https://upload-images.jianshu.io/upload_images/2145107-b6f41ef854380dff.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/800)








*** 
### 5.结语:
github地址: https://github.com/shidavid/DVDataBind
谢谢大家观看,有兴趣麻烦点个星星关注下 😁😁😁
