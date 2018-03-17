//
//  YHPrefixViewController.m
//  ILMARE
//
//  Created by yh_swjtu on 17/7/3.
//  Copyright © 2017年 yh_swjtu. All rights reserved.
//

#import "YHPrefixViewController.h"
#import "YHLoginViewController.h"
#import "YHPrefixHeaderView.h"
#import "YHPrefixInfoViewController.h"
#import "YHTempObjUtil.h"
#import "YHDraftViewController.h"
#import "YHNoticeViewController.h"

#define YHPrefixViewHeaderViewHeight 90

@interface YHPrefixViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) YHPrefixHeaderView *headerView;

@property (nonatomic, strong) UIButton *prefixButton;

@property (nonatomic, strong) NSArray *array;

@end

@implementation YHPrefixViewController

- (NSArray *) array{
    if (!_array){
        NSString *path = [[NSBundle mainBundle] pathForResource:@"prefixSetting" ofType:@"plist"];
        if (path){
            _array = [NSArray arrayWithContentsOfFile:path];
        }
    }
    return _array;
}

- (UIButton *) prefixButton{
    if (!_prefixButton){
        _prefixButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_prefixButton setBackgroundColor:[UIColor clearColor]];
        [_prefixButton addTarget:self action:@selector(prefixButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _prefixButton;
}

- (UITableView *) tableView{
    if (!_tableView){
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.contentInset = UIEdgeInsetsMake(YHPrefixViewHeaderViewHeight, 0, YHPrefixViewHeaderViewHeight, 0);
    }
    return _tableView;
}

- (YHPrefixHeaderView *) headerView{
    if (!_headerView){
        _headerView = [[YHPrefixHeaderView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, YHPrefixViewHeaderViewHeight)];
        [_headerView setBackgroundColor:[UIColor colorWithRed:211 / 255.0 green:69 / 255.0 blue:75 / 255.0 alpha:1]];
        [_headerView addSubview:self.prefixButton];
        self.prefixButton.frame = _headerView.bounds;
    }
    return _headerView;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *temp = self.array[section];
    return temp.count;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return self.array.count;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"aaaa"];
    if (!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"aaaa"];
    }
    NSArray *temp = self.array[indexPath.section];
    NSDictionary *dic = temp[indexPath.row];
    cell.textLabel.text = dic[@"name"];
    [cell.imageView setImage:[UIImage imageNamed:dic[@"iconName"]]];
    if ([dic[@"name"] isEqualToString:@"草稿箱"]){
        NSMutableArray *tempArray = [YHTempObjUtil tempMutableArray];
        if (tempArray){
            [cell.detailTextLabel setText:[NSString stringWithFormat:@"%zd", tempArray.count]];
        }
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.headerView];
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"登录" style:UIBarButtonItemStylePlain target:self action:@selector(test)];
    self.navigationItem.rightBarButtonItem = right;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(saveTempObj) name:@"YHSaveTempObj" object:nil];
}

- (void) saveTempObj{
    [self.tableView reloadData];
}

- (void) test{
    YHLoginViewController *login = [[YHLoginViewController alloc] init];
    [self presentViewController:login animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void) scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint point = scrollView.contentOffset;
    if (point.y <= -YHPrefixViewHeaderViewHeight){
        self.headerView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, -point.y);
        [self.headerView setNeedsDisplay];
    }else{
        if (point.y <= 0 && point.y > -YHPrefixViewHeaderViewHeight){
            CGFloat offset = - point.y - YHPrefixViewHeaderViewHeight;
            self.headerView.frame = CGRectMake(0, offset, [UIScreen mainScreen].bounds.size.width, YHPrefixViewHeaderViewHeight);
        }else{
            self.headerView.frame = CGRectMake(0, -YHPrefixViewHeaderViewHeight, [UIScreen mainScreen].bounds.size.width, YHPrefixViewHeaderViewHeight);
        }
    }
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1 && indexPath.row == 3){
        YHDraftViewController *draft = [[YHDraftViewController alloc] init];
        [self.navigationController pushViewController:draft animated:YES];
    }else if (indexPath.section == 0 && indexPath.row == 0){
        YHNoticeViewController *notice = [[YHNoticeViewController alloc] init];
        notice.title = @"公告栏";
        [self.navigationController pushViewController:notice animated:YES];
    }
}

- (void) prefixButtonClick{
    YHPrefixInfoViewController *prefixInfo = [[YHPrefixInfoViewController alloc] init];
    [prefixInfo.view setBackgroundColor:[UIColor whiteColor]];
    [self.navigationController pushViewController:prefixInfo animated:YES];
}

@end
