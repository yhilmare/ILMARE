//
//  YHTabBarController.m
//  ILMARE
//
//  Created by yh_swjtu on 17/7/3.
//  Copyright © 2017年 yh_swjtu. All rights reserved.
//

#import "YHTabBarController.h"
#import "YHIndexViewController.h"
#import "YHPrefixViewController.h"
#import "YHMessageViewController.h"
#import "YHFindViewController.h"
#import "YHTabBar.h"
#import "YHNavigationController.h"

@interface YHTabBarController ()<YHTabBarDelgate, UITabBarDelegate>

@property (nonatomic, strong) YHTabBar *customTabBar;

@property (nonatomic, strong) YHIndexViewController *index;

@property (nonatomic, strong) YHMessageViewController *message;

@property (nonatomic, strong) YHFindViewController *find;

@property (nonatomic, strong) YHPrefixViewController *prefix;

@property (nonatomic, strong) NSMutableDictionary *dic;

@end

@implementation YHTabBarController

- (NSMutableDictionary *) dic{
    if (!_dic){
        _dic = [NSMutableDictionary dictionary];
        [_dic setValue:@"0" forKey:@"currentView"];
    }
    return _dic;
}
- (YHTabBar *) customTabBar{
    if (!_customTabBar){
        _customTabBar = [[YHTabBar alloc] init];
    }
    return _customTabBar;
}

- (YHIndexViewController *) index{
    if (!_index){
        _index = [[YHIndexViewController alloc] init];
        _index.title = @"IL MARE的博客";
    }
    return  _index;
}

- (YHMessageViewController *) message{
    if (!_message){
        _message = [[YHMessageViewController alloc] init];
        _message.title = @"消息";
    }
    return  _message;
}

- (YHFindViewController *) find{
    if (!_find){
        _find = [[YHFindViewController alloc] init];
        _find.title = @"发现";
    }
    return _find;
}

- (YHPrefixViewController *) prefix{
    if (!_prefix){
        _prefix = [[YHPrefixViewController alloc] init];
        _prefix.title = @"我的";
    }
    return _prefix;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setValue:self.customTabBar forKey:@"tabBar"];
    self.customTabBar.tabBardelgate = self;
    [self setNavigationController];
}

- (void) setNavigationController{
    //首页初始化
   YHNavigationController *indexNav = [self ViewController:self.index withSelectedImg:@"tabbar_icon_news_highlight" normalImg:@"tabbar_icon_news_normal" title:@"首页"];
    self.index.tabBarItem.tag = 0;
    
    // 消息页面初始化
    YHNavigationController *messageNav = [self ViewController:self.message withSelectedImg:@"tabbar_icon_reader_highlight" normalImg:@"tabbar_icon_reader_normal" title:@"消息"];
    self.message.tabBarItem.tag = 1;
    
    
    //发现页面初始化
    YHNavigationController *findNav = [self ViewController:self.find withSelectedImg:@"tabbar_icon_found_highlight" normalImg:@"tabbar_icon_found_normal" title:@"发现"];
    self.find.tabBarItem.tag = 2;
    
    //我界面初始化
    YHNavigationController *profixNav = [self ViewController:self.prefix withSelectedImg:@"tabbar_icon_me_highlight" normalImg:@"tabbar_icon_me_normal" title:@"我的"];
    self.prefix.tabBarItem.tag = 3;
    
    self.viewControllers = @[indexNav, messageNav, findNav, profixNav];
}

- (YHNavigationController *) ViewController:(UIViewController *)viewController
                                withSelectedImg:(NSString *) imgName
                                      normalImg:(NSString *) normal
                                          title:(NSString *) title{
    UIImage *selectedImg = [UIImage imageNamed:imgName];
    UIImage *normalImg = [UIImage imageNamed:normal];
    [viewController.tabBarItem setImage:[normalImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [viewController.tabBarItem setSelectedImage:[selectedImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [viewController.tabBarItem setTitle:title];
    [viewController.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:YHNavigationBarTintColor, NSFontAttributeName:YHTabBarTitleFont} forState:UIControlStateSelected];
    [viewController.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor], NSFontAttributeName:YHTabBarTitleFont} forState:UIControlStateNormal];
    return [[YHNavigationController alloc] initWithRootViewController:viewController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) yhTabBar:(YHTabBar *)tabBar didClickButton:(UIButton *)button{
    
}

- (void) tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    [self.dic setValue:[NSString stringWithFormat:@"%zd", item.tag] forKey:@"itemTag"];
    NSNotification *notification = [NSNotification notificationWithName:@"tabBarButtonClick" object:nil userInfo:[NSDictionary dictionaryWithDictionary:self.dic]];
    [self.dic setValue:[NSString stringWithFormat:@"%zd", item.tag] forKey:@"currentView"];
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center postNotification:notification];
}

@end
