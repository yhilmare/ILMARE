//
//  YHNavigationController.m
//  ILMARE
//
//  Created by yh_swjtu on 17/7/3.
//  Copyright © 2017年 yh_swjtu. All rights reserved.
//

#import "YHNavigationController.h"

@interface YHNavigationController ()<UINavigationControllerDelegate>

@property (nonatomic, weak) id<UIGestureRecognizerDelegate> popdelgate;

@end

@implementation YHNavigationController

+ (void) initialize{
    if (self == [YHNavigationController class]){
        [self setNavigationBar];
        [self setNavigationItem];
    }
}


+ (void) setNavigationItem{
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    
    NSDictionary *useDic = @{NSFontAttributeName:YHNavigationBarItemFont, NSForegroundColorAttributeName:[UIColor lightGrayColor]};
    [item setTitleTextAttributes:useDic forState:UIControlStateDisabled];
    
    NSDictionary *hightlightDic = @{NSFontAttributeName:YHNavigationBarItemFont, NSForegroundColorAttributeName:[UIColor whiteColor]};;
    [item setTitleTextAttributes:hightlightDic forState:UIControlStateNormal];
}

+ (void) setNavigationBar{
    UINavigationBar *bar = [UINavigationBar appearance];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[NSFontAttributeName] = YHNavigationBarTitleFont;
    dic[NSForegroundColorAttributeName] = [UIColor whiteColor];
    
    [bar setBarStyle:UIBarStyleBlack];
    [bar setTitleTextAttributes:dic];
    [bar setBackgroundImage:[self imageFromColor:[UIColor colorWithRed:211 / 255.0 green:69 / 255.0 blue:75 / 255.0 alpha:1] size:CGSizeMake([UIScreen mainScreen].bounds.size.width, 64)] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [bar setShadowImage:[self imageFromColor:[UIColor colorWithRed:211 / 255.0 green:69 / 255.0 blue:75 / 255.0 alpha:1] size:CGSizeMake([UIScreen mainScreen].bounds.size.width, 1)]];
}

+ (UIImage *) imageFromColor:(UIColor *) color size:(CGSize) size{
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    self.popdelgate = self.interactivePopGestureRecognizer.delegate;
}

- (void) navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (viewController == navigationController.viewControllers[0]){
        self.interactivePopGestureRecognizer.delegate = self.popdelgate;
    }else{
        self.interactivePopGestureRecognizer.delegate = nil;
    }
}

- (void) pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
//    [viewController.view setBackgroundColor:[UIColor whiteColor]];
    if (self.childViewControllers.count){
        [viewController setHidesBottomBarWhenPushed:YES];
        UIImage *img = [UIImage imageNamed:@"navigationbar_back_1"];
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:img style:UIBarButtonItemStylePlain target:self action:@selector(popToPre)];
        [viewController.navigationItem setLeftBarButtonItem:backItem];
    }
    [super pushViewController:viewController animated:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) popToPre{
    [self popViewControllerAnimated:YES];
}



@end
