//
//  YHStatusViewController.m
//  ILMARE
//
//  Created by yh_swjtu on 17/7/12.
//  Copyright © 2017年 yh_swjtu. All rights reserved.
//

#import "YHStatusViewController.h"
#import "YHMJRefreshUtil.h"
#import "YHMBProgressHUDUtil.h"
#import "YHStatusUtil.h"
#import "YHBlogObjWrapper.h"
#import "YHStatusWrapper.h"
#import "YHFindStatusTableViewCell.h"
#import "YHStatus.h"
#import "MBProgressHUD.h"
#import "YHOperationStatusInfo.h"

@interface YHStatusViewController ()<UITableViewDelegate, UITableViewDataSource, YHFindStatusTableViewCellDelgate>{
    NSInteger _totalPage, _pageIndex;
    NSString *_identifer;
}

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *array;

@property (nonatomic, strong) MJRefreshNormalHeader *customerHeader;

@property (nonatomic, strong) MJRefreshAutoFooter *customerFooter;

@end

@implementation YHStatusViewController

- (NSMutableArray *) array{
    if (!_array){
        _array = [NSMutableArray array];
    }
    return _array;
}

- (UITableView *) tableView{
    if (!_tableView){
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 30 + 64 + 49, 0);
        UIView *temp = [[UIView alloc] init];
        _tableView.tableFooterView = temp;
        _tableView.separatorColor = [UIColor colorWithRed:251 / 255.0 green:251 / 255.0 blue:251 / 255.0 alpha:1];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _identifer = @"Find_status_identifer";
    _totalPage = 1;
    _pageIndex = 1;
    
    [self.view addSubview:self.tableView];
    MJRefreshNormalHeader *header = [YHMJRefreshUtil getHeaderWithTarget:self selector:@selector(headersLoadMoreData:)];
    self.customerHeader = header;
    MJRefreshAutoFooter *footer = [YHMJRefreshUtil getFooterWithTarget:self selector:@selector(footerLoadMoreData:)];
    self.customerFooter = footer;
    self.tableView.mj_header = header;
    self.tableView.mj_footer = footer;
    [header beginRefreshing];
}

- (void) viewWillDisappear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.customerHeader endRefreshing];
    [self.customerFooter endRefreshing];
}

- (void) headersLoadMoreData:(MJRefreshNormalHeader *) header{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [YHStatusUtil getStatusInfoWithPageIndex:1 success:^(YHBlogObjWrapper *resultSet) {
        [header endRefreshing];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        _pageIndex = 2;
        _totalPage = resultSet.totalPage;
        [self.array removeAllObjects];
        for (YHStatus *status in resultSet.objArray){
            YHStatusWrapper *wrapper = [[YHStatusWrapper alloc] init];
            wrapper.status = status;
            [self.array addObject:wrapper];
        }
        [self.tableView reloadData];
        
    } networkStatus:^(AFNetworkReachabilityStatus status) {
        [header endRefreshing];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [YHMBProgressHUDUtil showErrorMessage:@"网络连接错误" toView:[UIApplication sharedApplication].keyWindow];
    } failure:^(NSError *error) {
        [header endRefreshing];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [YHMBProgressHUDUtil showErrorMessage:@"网络连接错误" toView:[UIApplication sharedApplication].keyWindow];
    }];
}

- (void) footerLoadMoreData:(MJRefreshAutoFooter *) footer{
    if (_pageIndex > _totalPage){
        [footer endRefreshing];
        return;
    }else{
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        [YHStatusUtil getStatusInfoWithPageIndex:(_pageIndex ++) success:^(YHBlogObjWrapper *resultSet) {
            [footer endRefreshing];
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            _totalPage = resultSet.totalPage;
            for(YHStatus *status in resultSet.objArray){
                YHStatusWrapper *wrapper = [[YHStatusWrapper alloc] init];
                wrapper.status = status;
                [self.array addObject:wrapper];
            }
            [self.tableView reloadData];
        } networkStatus:^(AFNetworkReachabilityStatus status) {
            [footer endRefreshing];
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            [YHMBProgressHUDUtil showErrorMessage:@"网络连接错误" toView:[UIApplication sharedApplication].keyWindow];
            
        } failure:^(NSError *error) {
            [footer endRefreshing];
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            [YHMBProgressHUDUtil showErrorMessage:@"网络连接错误" toView:[UIApplication sharedApplication].keyWindow];
        }];
    }
    
}


- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return self.array.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YHFindStatusTableViewCell *cell = [YHFindStatusTableViewCell tableView:tableView identifier:_identifer];
    YHStatusWrapper *wrapper = self.array[indexPath.section];
    cell.status = wrapper.status;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delgate = self;
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    YHStatusWrapper *wrapper = self.array[indexPath.section];
    return wrapper.rowHeight;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0){
        return 10;
    }else{
        return 0.1;
    }
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (void) tableViewCell:(YHFindStatusTableViewCell *)cell willDeletailStatus:(YHStatus *)status{
    NSString *loginToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"loginToken"];
    if (!loginToken){
        [YHMBProgressHUDUtil showErrorMessage:@"您还未登录" toView:nil];
        return;
    }
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"消息提示" message:@"确定删除？" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *yesAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSIndexPath *path = [self.tableView indexPathForCell:cell];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
        hud.removeFromSuperViewOnHide = YES;
        hud.label.text = @"删除中...";
        [hud showAnimated:YES];
        [YHStatusUtil deleteStatus:status.status_id loginToken:loginToken success:^(YHOperationStatusInfo *resultInfo) {
            [hud hideAnimated:YES];
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            if (resultInfo.messageCode == 200){
                [self.array removeObjectAtIndex:path.section];
                [self.tableView reloadData];
                [YHMBProgressHUDUtil showSuccessMessage:resultInfo.messageDetail toView:nil];
            }else{
                [YHMBProgressHUDUtil showErrorMessage:resultInfo.messageDetail toView:nil];
            }
            
        } networkStatus:^(AFNetworkReachabilityStatus status) {
            [hud hideAnimated:YES];
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            [YHMBProgressHUDUtil showErrorMessage:@"网络错误" toView:nil];
        } failure:^(NSError *error) {
            [hud hideAnimated:YES];
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            [YHMBProgressHUDUtil showErrorMessage:@"网络错误" toView:nil];
        }];

    }];
    
    UIAlertAction *noAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:nil];
    [alertController addAction:yesAction];
    [alertController addAction:noAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}

@end
