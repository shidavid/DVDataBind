//
//  UICollectionView+Common.m
//  French
//
//  Created by DV on 2019/3/12.
//  Copyright © 2019 iOS. All rights reserved.
//

#import "UICollectionView+Common.h"
#import <objc/runtime.h>


@implementation UICollectionView (Common)


#pragma mark - <-- Method -->
- (UICollectionViewCell *)dequeueReusableCellWithClass:(Class)cellClass forIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell * cell = [self dequeueReusableCellWithReuseIdentifier:NSStringFromClass(cellClass)
                                                                  forIndexPath:indexPath];
    return cell ? cell : [[cellClass alloc] init];
}

- (UICollectionReusableView *)dequeueReusableSupplementaryViewOfKind:(NSString *)elementKind withClass:(Class)viewClass forIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *view = [self dequeueReusableSupplementaryViewOfKind:elementKind
                                                              withReuseIdentifier:NSStringFromClass(viewClass)
                                                                     forIndexPath:indexPath];
    return view ? view : [[viewClass alloc] init];
}

- (void)registerClass:(Class)cellClass {
    [self registerClass:cellClass forCellWithReuseIdentifier:NSStringFromClass(cellClass)];
}

- (void)registerClassForSectionHeader:(Class)viewClass {
    [self registerClass:viewClass forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                         withReuseIdentifier:NSStringFromClass(viewClass)];
}

- (void)registerClassForSectionFooter:(Class)viewClass {
    [self registerClass:viewClass forSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                                         withReuseIdentifier:NSStringFromClass(viewClass)];
}

@end
