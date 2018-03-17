//
//  YHArticleViewController.m
//  ILMARE
//
//  Created by yh_swjtu on 17/7/13.
//  Copyright © 2017年 yh_swjtu. All rights reserved.
//

#import "YHArticleViewController.h"
#import "YHArticleInfoUtil.h"
#import "YHMJRefreshUtil.h"
#import "YHFindArticleTableViewCell.h"
#import "YHBlogObjWrapper.h"
#import "YHMBProgressHUDUtil.h"
#import "YHArticleWrapper.h"
#import "YHFindArticleTableViewCell.h"
#import "YHArticleInfo.h"
#import "YHOperationStatusInfo.h"
#import "MBProgressHUD.h"

@interface YHArticleViewController ()<UITableViewDelegate, UITableViewDataSource, YHFindArticleTableViewCellDelgate>{
    NSInteger _pageIndex,_totalPage;
    NSString *_identifier;
}

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *array;

@property (nonatomic, strong) MJRefreshNormalHeader *customerHeader;

@property (nonatomic, strong) MJRefreshAutoFooter *customerFooter;

@end

@implementation YHArticleViewController

- (UITableView *) tableView{
    if (!_tableView){
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 30 + 64 + 49, 0);
        UIView *temp = [[UIView alloc] init];
        _tableView.tableFooterView = temp;
        _tableView.separatorColor = [UIColor colorWithRed:251 / 255.0 green:251 / 255.0 blue:251 / 255.0 alpha:1];
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
    _identifier = @"article_find_identifier";
    
    [self.view addSubview:self.tableView];
    
    MJRefreshNormalHeader *header = [YHMJRefreshUtil getHeaderWithTarget:self selector:@selector(headerLoadMoreData:)];
    self.customerHeader = header;
    MJRefreshAutoFooter *footer = [YHMJRefreshUtil getFooterWithTarget:self selector:@selector(footerLoadMoreData:)];
    self.customerFooter = footer;
    self.tableView.mj_header = header;
    self.tableView.mj_footer = footer;
    
    [header beginRefreshing];
}

- (void) headerLoadMoreData:(MJRefreshNormalHeader *) header{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [YHArticleInfoUtil getArticleInfoWithPageIndex:1 success:^(YHBlogObjWrapper *resultSet) {
        [header endRefreshing];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        _pageIndex = 2;
        _totalPage = resultSet.totalPage;
        [self.array removeAllObjects];
        for (YHArticleInfo *info in resultSet.objArray){
            YHArticleWrapper *wrapper = [[YHArticleWrapper alloc] init];
            wrapper.articleInfo = info;
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
        [YHArticleInfoUtil getArticleInfoWithPageIndex:(_pageIndex ++) success:^(YHBlogObjWrapper *resultSet) {
            [footer endRefreshing];
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            _totalPage = resultSet.totalPage;
            for(YHArticleInfo *info in resultSet.objArray){
                YHArticleWrapper *wrapper = [[YHArticleWrapper alloc] init];
                wrapper.articleInfo = info;
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

- (void) viewWillDisappear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.customerHeader endRefreshing];
    [self.customerFooter endRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return self.array.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YHFindArticleTableViewCell *cell = [YHFindArticleTableViewCell tableview:tableView identifier:_identifier];
    YHArticleWrapper *wrapper = self.array[indexPath.section];
    cell.articleInfo = wrapper.articleInfo;
    cell.delgate = self;
    return cell;
}
- (CGFloat ) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    YHArticleWrapper *wrapper = self.array[indexPath.section];
    return wrapper.rowHeight;
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

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    YHArticleWrapper *wrapper = self.array[indexPath.section];
    [center postNotificationName:@"YHArticleCellClicked" object:nil userInfo:@{@"article_id":wrapper.articleInfo.article_id,
                                                                               @"title":wrapper.articleInfo.article_title}];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void) tableViewCell:(YHFindArticleTableViewCell *)tableviewCell willDeletailArticleInfo:(YHArticleInfo *)articleInfo{
    
    NSString *loginToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"loginToken"];
    if (!loginToken){
        [YHMBProgressHUDUtil showErrorMessage:@"您还未登录" toView:nil];
        return;
    }
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"消息提示" message:@"确定删除？" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *yesAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSIndexPath *path = [self.tableView indexPathForCell:tableviewCell];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
        hud.removeFromSuperViewOnHide = YES;
        hud.label.text = @"删除中...";
        [hud showAnimated:YES];
        [YHArticleInfoUtil deleteArticle:articleInfo.article_id loginToken:loginToken success:^(YHOperationStatusInfo *resultInfo) {
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
