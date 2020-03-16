//
//  DVManager.h
//   
//
//  Created by mlgPro on 2018/1/9.
//  Copyright © 2018年 com.znjk.test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DVAPPManager.h"


/**
 *  APP运行时 生命周期内 数据管理 数据缓存 中间态 其他类型管理
 *  APP关闭将失去所有数据 不保存
 *  APP 中间件管理
 */
//TODO: Manager 尽量是 变量 或者 实现Delegate 的 服务管理  类，尽量少写方法，方法封装成工具类
@interface DVManager : NSObject

/// APP管理
@property(nonatomic, class, readonly) DVAPPManager *app;

@end
