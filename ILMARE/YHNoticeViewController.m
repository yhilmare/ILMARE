//
//  YHNoticeViewController.m
//  ILMARE
//
//  Created by yh_swjtu on 17/7/31.
//  Copyright © 2017年 yh_swjtu. All rights reserved.
//

#import "YHNoticeViewController.h"
#import "MBProgressHUD.h"
#import "YHHolderInfo.h"
#import "YHNoticeView.h"

@interface YHNoticeViewController ()

@property (nonatomic, strong) MBProgressHUD *hud;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) YHHolderInfo *holderInfo;

@property (nonatomic, strong) YHNoticeView *noticeView;

@end

@implementation YHNoticeViewController

- (YHNoticeView *) noticeView{
    if (!_noticeView){
        CGSize size = [UIScreen mainScreen].bounds.size;
        _noticeView = [[YHNoticeView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height - 64)];
    }
    return _noticeView;
}

- (YHHolderInfo *) holderInfo{
    if (!_holderInfo){
        NSString *holderPath = [[NSUserDefaults standardUserDefaults] objectForKey:@"holderPath"];
        if (holderPath){
            NSData *holderData = [NSData dataWithContentsOfFile:holderPath];
            NSKeyedUnarchiver *unArachiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:holderData];
            _holderInfo = [unArachiver decodeObjectForKey:@"holderInfo"];
            [unArachiver finishDecoding];
        }
    }
    return _holderInfo;
}

- (UIScrollView *) scrollView{
    if (!_scrollView){
        CGSize size = [UIScreen mainScreen].bounds.size;
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height - 64)];
        [_scrollView setBackgroundColor:[UIColor lightGrayColor]];
        _scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 63);
    }
    return _scrollView;
}

- (MBProgressHUD *) hud{
    if (!_hud){
        _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        _hud.removeFromSuperViewOnHide = YES;
        _hud.label.text = @"加载中...";
    }
    return _hud;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self.view addSubview:self.scrollView];
    
    [self.scrollView addSubview:self.noticeView];
}

@end
