//
//  MainTableView.m
//  DVDataBindDemo
//
//  Created by mlgPro on 2020/3/16.
//  Copyright © 2020 DVUntilKit. All rights reserved.
//

#import "MainTableView.h"

@interface MainTableView () <UITableViewDelegate, UITableViewDataSource>

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
- (void)setModels:(NSArray<NSString *> *)models {
    _models = models;
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
    return self.models ? self.models.count : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    if (cell && self.models && indexPath.row < self.models.count) {
        cell.textLabel.text = self.models[indexPath.row];
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.mtvDelegate && self.models && indexPath.row < self.models.count) {
        [self.mtvDelegate MainTableView:self didSelectItem:self.models[indexPath.row]];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}

@end
