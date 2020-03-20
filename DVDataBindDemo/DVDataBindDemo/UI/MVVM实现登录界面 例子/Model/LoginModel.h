//
//  LoginModel.h
//  DVDataBindDemo
//
//  Created by 施达威 on 2020/3/18.
//  Copyright © 2020 DVUntilKit. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// 这个 Model 是服务器的数据
@interface LoginModel : NSObject

@property(nonatomic, copy) NSString *userName;
@property(nonatomic, copy) NSString *password;

@end

NS_ASSUME_NONNULL_END
