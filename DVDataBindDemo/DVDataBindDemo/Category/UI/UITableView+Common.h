//
//  UITableView+DV.h
//   
//
//  Created by DV on 2018/2/9.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - <-------------------- UITableView (Common) -------------------->
@interface UITableView (Common)

/**
 *  获取已注册的Cell,若为nil,自动初始化
 *  @param cellClass 已注册Cell的类
 */
- (__kindof UITableViewCell *)dequeueReusableCellWithClass:(Class)cellClass
                                              forIndexPath:(NSIndexPath *)indexPath;

- (void)registerClass:(Class)cellClass;

- (void)registerNibWithClass:(Class)cellClass;

@end
