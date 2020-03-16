//
//  DVDataBindTargetModel.h
//
//  Created by David.Shi on 2018/3/16.
//  Copyright © 2018 iOS. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DVDataBindTargetModel : NSObject

@property(nonatomic, copy) NSString *targetHash;

- (instancetype)initWithTargetHash:(NSString *)targetHash;

@end

NS_ASSUME_NONNULL_END
