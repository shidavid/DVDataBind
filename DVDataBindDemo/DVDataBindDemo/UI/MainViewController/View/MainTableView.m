//
//  MainTableView.m
//  DVDataBindDemo
//
//  Created by mlgPro on 2020/3/16.
//  Copyright © 2020 DVUntilKit. All rights reserved.
//

#import "MainTableView.h"

@interface MainTableView () <UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) NSArray<NSString *> *keys;

@end


@implementation MainTableView

#pragma mark - <-- Initializer -->
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)dealloc{
    self.delegate = nil;
    self.dataSource = nil;
    
    _models = nil;
    _mtvDelegate = nil;
}


#pragma mark - <-- Property -->
- (void)setModels:(NSDictionary<NSString *,NSString *> *)models {
    _models = models;
    _keys = models.allKeys;
    [self reloadData];
}


#pragma mark - <-- Init -->
- (void)initViews {
    self.delegate = self;
    self.dataSource = self;
    [self registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}


#pragma mark - Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.keys ? self.keys.count : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    if (cell && self.keys && indexPath.row < self.keys.count) {
        cell.textLabel.text = self.keys[indexPath.row];
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.mtvDelegate && self.keys && indexPath.row < self.keys.count) {
        NSString *key = self.keys[indexPath.row];
        NSString *value = self.models[key];
        [self.mtvDelegate MainTableView:self didSelectItem:value];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}

@end
