//
//  MainTableView.h
//  DVDataBindDemo
//
//  Created by mlgPro on 2020/3/16.
//  Copyright © 2020 DVUntilKit. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class MainTableView;
@protocol MainTableViewDelegate <NSObject>

- (void)MainTableView:(MainTableView *)view didSelectItem:(NSString *)item;

@end


@interface MainTableView : UITableView

@property(nonatomic, weak) id<MainTableViewDelegate> mtvDelegate;
@property(nonatomic, strong) NSDictionary<NSString *, NSString *> *models;


@end

NS_ASSUME_NONNULL_END
