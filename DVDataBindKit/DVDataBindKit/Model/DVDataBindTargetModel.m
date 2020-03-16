//
//  DVDataBindTargetModel.m
//
//  Created by David.Shi on 2018/3/16.
//  Copyright © 2018 iOS. All rights reserved.
//

#import "DVDataBindTargetModel.h"
#import "DVDataBindObserverManager.h"

@implementation DVDataBindTargetModel

#pragma mark - <-- Instance -->
- (instancetype)initWithTargetHash:(NSString *)targetHash {
    self = [super init];
    if (self) {
        self.targetHash = targetHash;
    }
    return self;
}


#pragma mark - <-- Dealloc -->
- (void)dealloc {
    [[DVDataBindObserverManager sharedInstance] unbindWithTargetHash:self.targetHash];
}

@end
