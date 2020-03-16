//
//  NSObject+DataBind.h
//
//  Created by David.Shi on 2018/3/16.
//  Copyright © 2018 iOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DVDataBindDefine.h"
#import "DVDataBindTargetModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (DataBind)

@property(nonatomic, assign) BOOL db_isDidChanged;

@property(nonatomic, strong) DVDataBindTargetModel *db_targetModel;

@property(nonatomic, copy) NSString *db_ctrl_targetKeyHash;

@property(nonatomic, copy, readonly) NSString *db_Hash;


/// 获取属性property类型, 任意类型
- (DBPropertyType)db_getDBPropertyTypeWithName:(NSString *)propertyName;


@end

NS_ASSUME_NONNULL_END
