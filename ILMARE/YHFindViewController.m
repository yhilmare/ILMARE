//
//  YHFindViewController.m
//  ILMARE
//
//  Created by yh_swjtu on 17/7/3.
//  Copyright © 2017年 yh_swjtu. All rights reserved.
//

#import "YHFindViewController.h"
#import "YHMenuBar.h"
#import "YHFindTableViewCell.h"
#import "YHStatusViewController.h"
#import "YHArticleViewController.h"
#import "YHWebViewController.h"
#import "YHStatusEditViewController.h"

#define YHMenuBarHeight 30
#define YHNumberOfTableViewCell 2

@interface YHFindViewController ()<UITableViewDelegate, UITableViewDataSource>{
    NSString *_identifier;
}

@property (nonatomic, strong) UITableView *tableview;

@property (nonatomic, strong) YHMenuBar *menuBar;

@property (nonatomic, strong) NSArray *btnArray;

@property (nonatomic, assign) NSInteger currentBtn;


@end

@implementation YHFindViewController

- (NSArray *) btnArray{
    if (!_btnArray){
        _btnArray = [NSArray arrayWithObjects:@"状态",@"博客",nil];
    }
    return _btnArray;
}

- (YHMenuBar *) menuBar{
    if (!_menuBar){
        _menuBar = [[YHMenuBar alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, YHMenuBarHeight)];
        [_menuBar setBackgroundColor:[UIColor colorWithRed:211 / 255.0 green:69 / 255.0 blue:75 / 255.0 alpha:1]];
        CGFloat offsetX = 90;
        CGFloat width = 90;
        CGFloat x = offsetX;
        _menuBar.offsetX = offsetX;
        _menuBar.btnWidth = width;
        _menuBar.numOfBtn = YHNumberOfTableViewCell;
        _menuBar.selectedBtnTag = 0;
        self.currentBtn = 0;
        for (int i = 0; i < YHNumberOfTableViewCell; i ++){
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.tag = i;
            [btn setTitle:self.btnArray[i] forState:UIControlStateNormal];
            CGFloat height = 25;
            CGFloat marginX = ([UIScreen mainScreen].bounds.size.width - 2 * offsetX - YHNumberOfTableViewCell * width) / (YHNumberOfTableViewCell - 1.0);
            btn.frame = CGRectMake(x, 0, width, height);
            x = x + marginX + width;
            [_menuBar addSubview:btn];
            btn.titleLabel.font = YHFindMenuBarFont;
            [btn.titleLabel setTextColor:[UIColor whiteColor]];
            [btn addTarget:self action:@selector(menuBarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    return _menuBar;
}

- (UITableView *) tableview{
    if (!_tableview){
        CGFloat height = [UIScreen mainScreen].bounds.size.height - 64 - 49 - YHMenuBarHeight;
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        _tableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableview.contentInset = UIEdgeInsetsMake(0, 0, -49, 0);
        _tableview.pagingEnabled = YES;
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.transform = CGAffineTransformMakeRotation(270 * M_PI / 180);
        _tableview.frame = CGRectMake(0, YHMenuBarHeight, width, height);
        _tableview.rowHeight = width;
        _tableview.showsVerticalScrollIndicator = NO;
        _tableview.showsHorizontalScrollIndicator = NO;
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableview;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    _identifier = @"find_identifer";
    
    UIBarButtonItem *additem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(editStatusClick:)];
    [additem setTintColor:[UIColor whiteColor]];
    self.navigationItem.rightBarButtonItem = additem;
    
    [self.view addSubview:self.tableview];
    [self.view addSubview:self.menuBar];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showArticle:) name:@"YHArticleCellClicked" object:nil];
}

- (void) editStatusClick:(UIBarButtonItem *) item{
    YHStatusEditViewController *statusEdit = [[YHStatusEditViewController alloc] init];
    [self presentViewController:statusEdit animated:YES completion:nil];
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.currentBtn == 1){
        CGPoint temp = self.tableview.contentOffset;
        if (temp.y != [UIScreen mainScreen].bounds.size.width){
            self.tableview.contentOffset = CGPointMake(0, temp.y + 49);
        }
    }
}

- (void) showArticle:(NSNotification *) notice{
    NSString *article_id = notice.userInfo[@"article_id"];
    YHWebViewController *webViewController = [[YHWebViewController alloc] init];
    webViewController.article_id = article_id;
    webViewController.title = notice.userInfo[@"title"];
    [self.navigationController pushViewController:webViewController animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return YHNumberOfTableViewCell;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YHFindTableViewCell *cell = [YHFindTableViewCell tableView:tableView identifier:_identifier tag:indexPath.row];
    return cell;
}

//- (void) scrollViewDidScroll:(UIScrollView *)scrollView{
//    self.tableview.contentSize = CGSizeMake(0, [UIScreen mainScreen].bounds.size.width * YHNumberOfTableViewCell - 49);
//}

- (void) menuBarButtonClick:(UIButton *)button{
    self.menuBar.selectedBtnTag = button.tag;
    [self.tableview scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:button.tag inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    self.currentBtn = button.tag;
}

- (void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSIndexPath *indexPath = [self.tableview indexPathForRowAtPoint:scrollView.contentOffset];
    self.menuBar.selectedBtnTag = indexPath.row;
    self.currentBtn = indexPath.row;
}


@end
