//
//  FirstViewController.m
//  AnimationTest
//
//  Created by yeqiang on 2017/4/27.
//  Copyright © 2017年 yeqiang. All rights reserved.
//

#import "FirstViewController.h"
#import "AnimationViewController.h"

@interface FirstViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)setUI {
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self.view);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"firstCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = self.dataArray[indexPath.row];
    cell.textLabel.numberOfLines = 0;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    static NSString *identifier = @"header";
    UITableViewHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
    if (!header) {
        header = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:identifier];
    }
    header.textLabel.text = [NSString stringWithFormat:@"第%ld组", section];
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath*)indexPath {
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section {
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AnimationViewController *animationVC = [[AnimationViewController alloc] init];
    animationVC.type = indexPath.row;
    [self.navigationController pushViewController:animationVC animated:YES];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = self.headerView;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
        _headerView.backgroundColor = [UIColor redColor];
    }
    return _headerView;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] initWithObjects:@"平移动画", @"输入框摇晃动画", @"平移动画", nil];
    }
    return _dataArray;
}

@end
