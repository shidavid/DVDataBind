//
//  UICollectionView+Common.h
//  French
//
//  Created by DV on 2019/3/12.
//  Copyright © 2019 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UICollectionView (Common)

#pragma mark - <-- Method -->
/**
 *  获取已注册的Cell,若为nil,自动初始化
 *  @param cellClass 已注册Cell的类
 */
- (__kindof UICollectionViewCell *)dequeueReusableCellWithClass:(Class)cellClass
                                                   forIndexPath:(NSIndexPath *)indexPath;

///
- (__kindof UICollectionReusableView *)dequeueReusableSupplementaryViewOfKind:(NSString *)elementKind
                                                                    withClass:(Class)viewClass
                                                                 forIndexPath:(NSIndexPath *)indexPath;

///
- (void)registerClass:(Class)cellClass;

///
- (void)registerClassForSectionHeader:(Class)viewClass;

///
- (void)registerClassForSectionFooter:(Class)viewClass;

@end

NS_ASSUME_NONNULL_END
