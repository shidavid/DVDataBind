//
//  MainViewController.m
//  DVDataBindDemo
//
//  Created by mlgPro on 2020/3/16.
//  Copyright © 2020 DVUntilKit. All rights reserved.
//

#import "MainViewController.h"
#import "MainTableView.h"
#import "MainViewModel.h"
    
@interface MainViewController () <MainTableViewDelegate>

@property(nonatomic, strong) MainTableView *mainView;

@property(nonatomic, strong) MainViewModel *mainViewModel;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self initViews];
    [self initModels];
    [self loadData];
}

#pragma mark - <-- Init -->
- (void)initViews {
    self.mainView = ({
        MainTableView *v;
        v = [[MainTableView alloc] initWithFrame:DVFrame.frame_not_nav];
        v.mtvDelegate = self;
        v;
    });
    
    [self.view addSubview:self.mainView];
}

- (void)initModels {
    self.mainViewModel = [[MainViewModel alloc] init];
}

- (void)loadData {
    self.mainView.models = self.mainViewModel.tableItems;
}


#pragma mark - <-- Delegate -->
- (void)MainTableView:(MainTableView *)view didSelectItem:(NSString *)item {
    Class class = NSClassFromString(item);
    
    if (!class) return;
    
    __kindof UIViewController *vc = [[class alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
