//
//  YHIndexViewController.m
//  ILMARE
//
//  Created by yh_swjtu on 17/7/3.
//  Copyright © 2017年 yh_swjtu. All rights reserved.
//

#import "YHIndexViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "YHMapViewController.h"
#import "YHMJRefreshUtil.h"
#import "YHIndexViewTableViewCell.h"
#import "YHIndexInfoUtil.h"
#import "YHBlogObjWrapper.h"
#import "YHIndexWrapper.h"
#import "YHIndexInfo.h"
#import "YHWebViewController.h"
#import "YHHolderInfoUtil.h"
#import "YHHolderInfo.h"
#import "UIImageView+WebCache.h"
#import "YHHolderInfo.h"
#import "YHPrefixInfoViewController.h"

@interface YHIndexViewController ()<CLLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource>{
    NSInteger _pageIndex, _totalPage;
    NSString *_identifier;
    NSString *_identifier1;
}

@property (nonatomic, strong) CLLocationManager *locationManager;

@property (nonatomic, strong) CLLocation *currentLocation;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *array;

@property (nonatomic, strong) MJRefreshNormalHeader *headerRefresh;

@property (nonatomic, strong) MJRefreshAutoFooter *footerRefresh;

@property (nonatomic, strong) YHHolderInfo *holderInfo;

@end

@implementation YHIndexViewController

- (YHHolderInfo *) holderInfo{
    if (!_holderInfo){
        NSString *holderPath = [[NSUserDefaults standardUserDefaults] objectForKey:@"holderPath"];
        if (holderPath){
            NSMutableData *holder = [NSMutableData dataWithContentsOfFile:holderPath];
            NSKeyedUnarchiver *unArchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:holder];
            _holderInfo = [unArchiver decodeObjectForKey:@"holderInfo"];
            [unArchiver finishDecoding];
        }
    }
    return _holderInfo;
}

- (NSMutableArray *) array{
    if (!_array){
        _array = [NSMutableArray array];
    }
    return _array;
}

- (UITableView *) tableView{
    if (!_tableView){
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        UIView *footerView = [[UIView alloc] init];
        footerView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 20);
        [footerView setBackgroundColor:[UIColor clearColor]];
        _tableView.tableFooterView = footerView;
        [_tableView setBackgroundColor:[UIColor colorWithRed:248 / 255.0 green:248 / 255.0 blue:248 / 255.0 alpha:1]];
    }
    return _tableView;
}

- (CLLocationManager *) locationManager{
    if (!_locationManager){
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        [_locationManager requestWhenInUseAuthorization];
    }
    return _locationManager;
}

- (UIStatusBarStyle) preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _pageIndex = 1;
    _totalPage = 1;
    _identifier = @"index_identifier";
    _identifier1 = @"index_identifier1";
    [self setupTableView];
    [self setBarButtonItem];
    [self registeNotification];
    
    
    [YHHolderInfoUtil getHolderInfo:^(YHHolderInfo *info) {
        NSFileManager *manager = [NSFileManager defaultManager];
        NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *filePath = [NSString stringWithFormat:@"%@/holder.data", documentPath];
        NSMutableData *holder = [NSMutableData data];
        NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:holder];
        [archiver encodeObject:info forKey:@"holderInfo"];
        [archiver finishEncoding];
        [manager createFileAtPath:filePath contents:holder attributes:nil];
        [[NSUserDefaults standardUserDefaults] setObject:filePath forKey:@"holderPath"];
    } networkStatus:nil failure:nil];
    
    [self.locationManager startUpdatingLocation];
    
}

- (void) showPrefixInfo{
    YHPrefixInfoViewController *prefixInfo = [[YHPrefixInfoViewController alloc] init];
    [prefixInfo.view setBackgroundColor:[UIColor whiteColor]];
    [self.navigationController pushViewController:prefixInfo animated:YES];
}

- (void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.locationManager stopUpdatingLocation];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.array.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YHIndexWrapper *wrapper = self.array[indexPath.row];
    YHIndexViewTableViewCell *cell;
    if (wrapper.indexInfo.index_type == YHIndexInfoTypeArticle){
         cell = [YHIndexViewTableViewCell tableView:tableView reuseableIdentifier:_identifier];
    }else{
         cell = [YHIndexViewTableViewCell tableView:tableView reuseableIdentifier:_identifier1];
    }
    cell.holderInfo = self.holderInfo;
    cell.indexInfo = wrapper.indexInfo;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YHIndexWrapper *wrapper = self.array[indexPath.row];
    YHIndexInfo *info = wrapper.indexInfo;
    if (info.index_type == YHIndexInfoTypeArticle){
        YHWebViewController *webViewController = [[YHWebViewController alloc] init];
        webViewController.article_id = info.index_id;
        webViewController.title = info.index_title;
        [self.navigationController pushViewController:webViewController animated:YES];
    }
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    YHIndexWrapper *wrapper = self.array[indexPath.row];
    return wrapper.rowHeight;
}

- (void) setupTableView{
    [self.view addSubview:self.tableView];
    
    MJRefreshNormalHeader *header = [YHMJRefreshUtil getHeaderWithTarget:self selector:@selector(headerRefresh:)];
    self.headerRefresh = header;
    MJRefreshAutoFooter *footer = [YHMJRefreshUtil getFooterWithTarget:self selector:@selector(footerRefresh:)];
    self.footerRefresh = footer;
    self.tableView.mj_header = header;
    self.tableView.mj_footer = footer;
    
    [header beginRefreshing];
}

- (void) headerRefresh:(MJRefreshNormalHeader *)header{//下拉刷新回调函数
    [YHIndexInfoUtil getIndexInfoWithPageIndex:1 success:^(YHBlogObjWrapper *resultSet) {
        [header endRefreshing];
        _totalPage = resultSet.totalPage;
        _pageIndex = 2;
        [self.array removeAllObjects];
        for(YHIndexInfo *info in resultSet.objArray){
            YHIndexWrapper *wrapper = [[YHIndexWrapper alloc] init];
            wrapper.indexInfo = info;
            [self.array addObject:wrapper];
        }
        
        [self.tableView reloadData];
    } networkStatus:^(AFNetworkReachabilityStatus status) {
        [self.headerRefresh endRefreshing];
        [self.footerRefresh endRefreshing];
        [YHMBProgressHUDUtil showErrorMessage:@"网络错误" toView:self.view];
    } failure:^(NSError *error) {
        [self.headerRefresh endRefreshing];
        [self.footerRefresh endRefreshing];
        [YHMBProgressHUDUtil showErrorMessage:@"网络未连接" toView:self.view];
    }];
}

- (void) footerRefresh:(MJRefreshAutoFooter *)footer{//上拉回调函数
    if (_pageIndex > _totalPage){
        [footer endRefreshing];
        return;
    }else{
        [YHIndexInfoUtil getIndexInfoWithPageIndex:_pageIndex success:^(YHBlogObjWrapper *resultSet) {
            _totalPage = resultSet.totalPage;
            _pageIndex ++;
            for(YHIndexInfo *info in resultSet.objArray){
                YHIndexWrapper *wrapper = [[YHIndexWrapper alloc] init];
                wrapper.indexInfo = info;
                [self.array addObject:wrapper];
            }
            [footer endRefreshing];
            [self.tableView reloadData];
        } networkStatus:^(AFNetworkReachabilityStatus status) {
            [self.headerRefresh endRefreshing];
            [self.footerRefresh endRefreshing];
            [YHMBProgressHUDUtil showErrorMessage:@"网络错误" toView:self.view];
        } failure:^(NSError *error) {
            [self.headerRefresh endRefreshing];
            [self.footerRefresh endRefreshing];
            [YHMBProgressHUDUtil showErrorMessage:@"网络未连接" toView:self.view];
        }];
    }

}

//定位成功
- (void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    CLLocation *location = [locations lastObject];
    self.currentLocation = location;
    
    if (location){
        CLGeocoder *geocoder = [[CLGeocoder alloc] init];
        [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            if (error){
                [YHMBProgressHUDUtil showErrorMessage:@"定位解析失败" toView:self.view];
            }else{
                if (placemarks.count > 0){
                    CLPlacemark *placemark = [placemarks lastObject];
                    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:placemark.addressDictionary[@"City"] style:UIBarButtonItemStylePlain target:self action:@selector(locationButton)];
                    [leftItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"STHeitiTC-Light" size:14], NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
                    self.navigationItem.leftBarButtonItem = leftItem;
                }
            }
        }];
    }
    [self.locationManager stopUpdatingLocation];
}

//定位失败
- (void) locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    [YHMBProgressHUDUtil showErrorMessage:@"定位失败" toView:self.view];
    [self.locationManager stopUpdatingLocation];
}

- (void) setBarButtonItem{
    UIImage *img = [[UIImage imageNamed:@"weather_location"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *locationItem = [[UIBarButtonItem alloc] initWithImage:img style:UIBarButtonItemStylePlain target:self action:@selector(locationButton)];
    self.navigationItem.leftBarButtonItem = locationItem;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 35, 35);
    button.layer.cornerRadius = 17.5;
    button.layer.masksToBounds = YES;
    button.layer.borderColor = [UIColor whiteColor].CGColor;
    button.layer.borderWidth = 1;
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = rightItem;
    if (self.holderInfo){
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/blog/%@", YHILMAREBlogDomainName, self.holderInfo.holder_img]];
        SDWebImageManager *manager = [SDWebImageManager sharedManager];
        [manager downloadImageWithURL:url options:SDWebImageRefreshCached progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            [button setImage:image forState:UIControlStateNormal];
        }];
    }else{
        [button setImage:[UIImage imageNamed:@"IMG_5481"] forState:UIControlStateNormal];
    }
    [button addTarget:self action:@selector(showPrefixInfo) forControlEvents:UIControlEventTouchUpInside];
}

- (void) registeNotification{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(onclick:) name:@"tabBarButtonClick" object:nil];
}

//点击tabbar上的按钮时接收通知函数
- (void) onclick:(NSNotification *)notification{
    if ([notification.userInfo[@"itemTag"] isEqualToString:@"0"] && [notification.userInfo[@"currentView"] isEqualToString:@"0"]){
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.27 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.headerRefresh endRefreshing];
            [self.footerRefresh endRefreshing];
            [self.headerRefresh beginRefreshing];
        });
    }
}

//定位按钮按动时调用函数
- (void) locationButton{
    if (self.currentLocation){//定位成功时
        YHMapViewController *mapView = [[YHMapViewController alloc] init];
        mapView.title = @"我的定位";
        [self.navigationController pushViewController:mapView animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [self.locationManager stopUpdatingLocation];
    // Dispose of any resources that can be recreated.
}

@end
