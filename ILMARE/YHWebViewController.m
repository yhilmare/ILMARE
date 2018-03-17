//
//  YHWebViewController.m
//  ILMARE
//
//  Created by yh_swjtu on 17/7/6.
//  Copyright © 2017年 yh_swjtu. All rights reserved.
//

#import "YHWebViewController.h"
#import <WebKit/WebKit.h>

@interface YHWebViewController ()<WKNavigationDelegate>

@property (nonatomic, strong) WKWebView *webView;

@end

@implementation YHWebViewController

- (WKWebView *) webView{
    if (!_webView){
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        CGFloat height = [UIScreen mainScreen].bounds.size.height - 64;
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        _webView.navigationDelegate = self;
    }
    return _webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.webView];
    
    NSString *str = [NSString stringWithFormat:@"http://www.ilmareblog.com/blog/GenArticleController?article_id=%@&visitor_id=notlogin", self.article_id];
    
    NSURL *url = [NSURL URLWithString:str];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
}

- (void) webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"网页信息" message:@"网页加载错误" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *yesAction = [UIAlertAction actionWithTitle:@"重新加载" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [webView stopLoading];
        [webView reload];
    }];
    
    UIAlertAction *noAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [webView stopLoading];
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [alertController addAction:yesAction];
    [alertController addAction:noAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
