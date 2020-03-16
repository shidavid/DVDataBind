//
//  UITableView+DV.m
//   
//
//  Created by DV on 2018/2/9.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "UITableView+Common.h"

@implementation UITableView (Common)

- (UITableViewCell *)dequeueReusableCellWithClass:(Class)cellClass forIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self dequeueReusableCellWithIdentifier:NSStringFromClass(cellClass)
                                                       forIndexPath:indexPath];
    
    return cell ? cell : [[cellClass alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:NSStringFromClass(cellClass)];
}

- (void)registerClass:(Class)cellClass {
    [self registerClass:cellClass forCellReuseIdentifier:NSStringFromClass(cellClass)];
}

- (void)registerNibWithClass:(Class)cellClass {
    NSString *cellName = NSStringFromClass(cellClass);
    UINib *nib = [UINib nibWithNibName:cellName bundle:nil];
    [self registerNib:nib forCellReuseIdentifier:cellName];
}

@end
