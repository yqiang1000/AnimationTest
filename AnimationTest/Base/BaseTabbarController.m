//
//  BaseTabbarController.m
//  AnimationTest
//
//  Created by yeqiang on 2017/4/27.
//  Copyright © 2017年 yeqiang. All rights reserved.
//

#import "BaseTabbarController.h"
#import "BaseNavigationController.h"
#import "BaseViewController.h"
@interface BaseTabbarController ()

@end

@implementation BaseTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUI];
}

- (void)setUI {
    
    NSArray *name = @[@"First", @"Second", @"Third", @"Fourth", @"Fifth"];
    NSMutableArray *controllers = [[NSMutableArray alloc] initWithCapacity:4];
    for (int i = 0; i < name.count ; i++) {
        NSString *classStr = [NSString stringWithFormat:@"%@ViewController", name[i]];
        Class class = NSClassFromString(classStr);
        BaseViewController *viewController = (BaseViewController *)[[class alloc] init];
        viewController.title = name[i];
        BaseNavigationController *naviVC = [[BaseNavigationController alloc] initWithRootViewController:viewController];
        [controllers addObject:naviVC];
    }
    self.viewControllers = controllers;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
