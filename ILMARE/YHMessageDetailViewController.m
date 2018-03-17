//
//  YHMessageDetailViewController.m
//  ILMARE
//
//  Created by yh_swjtu on 17/7/7.
//  Copyright © 2017年 yh_swjtu. All rights reserved.
//

#import "YHMessageDetailViewController.h"
#import "YHDetailView.h"
#import "YHMessage.h"
#import "YHMessageMapViewController.h"

@interface YHMessageDetailViewController ()<YHDetailViewDelgate>

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation YHMessageDetailViewController

- (UIScrollView *) scrollView{
    if (!_scrollView){
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        CGFloat height = [UIScreen mainScreen].bounds.size.height;
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        [_scrollView setBackgroundColor:[UIColor colorWithRed:236 / 255.0 green:236 / 255.0 blue:236 / 255.0 alpha:1]];
        _scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height + 1);
    }
    return _scrollView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.scrollView];
    [self.view setBackgroundColor:[UIColor grayColor]];
    YHDetailView *detailView = [[YHDetailView alloc] initWithMessage:self.message];
    
    CGFloat rowHeight = 150 + 140;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}$"];
    if (![predicate evaluateWithObject:self.message.visitor_id]){
        rowHeight = 150;
    }
    CGFloat maxWidth = [UIScreen mainScreen].bounds.size.width - 2 * YHMessageDetailMarginX;
    CGSize size = [self.message.message_content maxSize:CGSizeMake(maxWidth, MAXFLOAT) textFont:YHTableviewCellTitleFont];
    rowHeight += size.height;
    detailView.frame = CGRectMake(0, 10, [UIScreen mainScreen].bounds.size.width, rowHeight);
    [detailView setBackgroundColor:[UIColor whiteColor]];
    detailView.delgate = self;
    [self.scrollView addSubview:detailView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) YHDetailView:(YHDetailView *)detailView didClickButton:(UIButton *)button{
    NSString *latitude = [NSString stringWithFormat:@"%@", self.message.message_latitude];
    if (![latitude isEqualToString:@"0"]){
        YHMessageMapViewController *map = [[YHMessageMapViewController alloc] init];
        map.message = self.message;
        map.subTitle = button.titleLabel.text;
        [self.navigationController pushViewController:map animated:YES];
    }
}

@end
