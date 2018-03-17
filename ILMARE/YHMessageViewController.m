//
//  YHMessageViewController.m
//  ILMARE
//
//  Created by yh_swjtu on 17/7/3.
//  Copyright © 2017年 yh_swjtu. All rights reserved.
//

#import "YHMessageViewController.h"
#import "YHMJRefreshUtil.h"
#import "YHMessageUtil.h"
#import "YHMessage.h"
#import "YHBlogObjWrapper.h"
#import "YHMBProgressHUDUtil.h"
#import "YHMessageTableViewCell.h"
#import "YHMessageDetailViewController.h"

@interface YHMessageViewController ()<UITableViewDelegate, UITableViewDataSource>{
    NSInteger _pageIndex,_totalPage;
    NSString *_identifier;
}

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *array;

@property (nonatomic, strong) MJRefreshNormalHeader *headerRefresh;

@property (nonatomic, strong) MJRefreshAutoFooter *footerRefresh;

@end

@implementation YHMessageViewController

- (UITableView *) tableView{
    if (!_tableView){
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 70;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 60, 0, 0);
        UIView *footerView = [[UIView alloc] init];
        footerView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 20);
        [footerView setBackgroundColor:[UIColor clearColor]];
        _tableView.tableFooterView = footerView;
        [_tableView setBackgroundColor:[UIColor colorWithRed:248 / 255.0 green:248 / 255.0 blue:248 / 255.0 alpha:1]];
        _tableView.allowsMultipleSelectionDuringEditing = YES;
    }
    return _tableView;
}

- (NSMutableArray *) array{
    if (!_array){
        _array = [NSMutableArray array];
    }
    return _array;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _pageIndex = 1;
    _totalPage = 1;
    _identifier = @"YHMessage_identifier";
    
    [self setupTableView];
    
}


- (void) setupTableView{
    MJRefreshNormalHeader *header = [YHMJRefreshUtil getHeaderWithTarget:self selector:@selector(headerLoadMoreData:)];
    MJRefreshAutoFooter *footer = [YHMJRefreshUtil getFooterWithTarget:self selector:@selector(footerLoadMoreData:)];
    self.headerRefresh = header;
    self.footerRefresh = footer;
    self.tableView.mj_header = header;
    self.tableView.mj_footer = footer;
    
    [self.view addSubview:self.tableView];
    NSString *loginToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"loginToken"];
    if (loginToken){
        [YHMessageUtil getMessageWithPageIndex:1 pageContain:10 loginToken:loginToken success:^(YHBlogObjWrapper *resultSet) {
            _pageIndex = 2;
            _totalPage = resultSet.totalPage;
            [self.array removeAllObjects];
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            for(YHMessage *msg in resultSet.objArray){
                [self.array addObject:msg];
            }
            [self.tableView reloadData];
        } networkStatus:nil failure:nil];
    }
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.array.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YHMessageTableViewCell *cell = [YHMessageTableViewCell tableView:tableView identifier:_identifier];
    YHMessage *message = self.array[indexPath.row];
    cell.message = message;
    return cell;
}

- (void) headerLoadMoreData:(MJRefreshNormalHeader *)header{
    NSString *loginToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"loginToken"];
    if (loginToken){
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        [YHMessageUtil getMessageWithPageIndex:1 pageContain:10 loginToken:loginToken success:^(YHBlogObjWrapper *resultSet) {
            [header endRefreshing];
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            _pageIndex = 2;
            _totalPage = resultSet.totalPage;
            [self.array removeAllObjects];
            for(YHMessage *msg in resultSet.objArray){
                [self.array addObject:msg];
            }
            [self.tableView reloadData];
        } networkStatus:^(AFNetworkReachabilityStatus status) {
            [header endRefreshing];
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            [YHMBProgressHUDUtil showErrorMessage:@"网络连接错误" toView:self.view];
        } failure:^(NSError *error) {
            [header endRefreshing];
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            [YHMBProgressHUDUtil showErrorMessage:@"网络连接错误" toView:self.view];
        }];

    }else{
        [header endRefreshing];
        [YHMBProgressHUDUtil showErrorMessage:@"您还未登录" toView:nil];
    }
}

- (void) footerLoadMoreData:(MJRefreshAutoFooter *) footer{
    NSString *loginToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"loginToken"];
    if (loginToken){
        if (_pageIndex > _totalPage){
            [footer endRefreshing];
            return;
        }else{
            [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
            [YHMessageUtil getMessageWithPageIndex:(_pageIndex ++) pageContain:10 loginToken:loginToken success:^(YHBlogObjWrapper *resultSet) {
                _totalPage = resultSet.totalPage;
                [footer endRefreshing];
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                for (YHMessage *msg in resultSet.objArray){
                    [self.array addObject:msg];
                }
                [self.tableView reloadData];
            } networkStatus:^(AFNetworkReachabilityStatus status) {
                [footer endRefreshing];
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                [YHMBProgressHUDUtil showErrorMessage:@"网络连接错误" toView:self.view];
            } failure:^(NSError *error) {
                [footer endRefreshing];
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                [YHMBProgressHUDUtil showErrorMessage:@"网络连接错误" toView:self.view];
            }];
        }
    }else{
        [footer endRefreshing];
        [YHMBProgressHUDUtil showErrorMessage:@"您还未登录" toView:nil];
    }
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    YHMessageDetailViewController *detail = [[YHMessageDetailViewController alloc] init];
    detail.message = self.array[indexPath.row];
    detail.title = @"留言详情";
    [self.navigationController pushViewController:detail animated:YES];
}

- (BOOL) tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (UITableViewCellEditingStyle) tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    YHMessage *message = self.array[indexPath.row];
    NSString *loginToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"loginToken"];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [YHMessageUtil deleteMessage:message.message_id loginToken:loginToken success:^(YHOperationStatusInfo *resultInfo) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [self.array removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
        [YHMBProgressHUDUtil showSuccessMessage:@"删除成功" toView:self.view];
    } networkStatus:^(AFNetworkReachabilityStatus status) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [YHMBProgressHUDUtil showErrorMessage:@"删除失败" toView:self.view];
    } failure:^(NSError *error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [YHMBProgressHUDUtil showErrorMessage:@"删除失败" toView:self.view];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
