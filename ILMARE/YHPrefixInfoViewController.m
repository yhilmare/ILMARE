//
//  YHPrefixInfoViewController.m
//  ILMARE
//
//  Created by yh_swjtu on 17/7/21.
//  Copyright © 2017年 yh_swjtu. All rights reserved.
//

#import "YHPrefixInfoViewController.h"
#import "YHHolderInfo.h"
#import "UIImageView+WebCache.h"
#import "YHPrefixInfoView.h"
#import "YHPrefixInfoView.h"
#import "YHPrefixInfoButton.h"
#import "YHStatusEditViewController.h"

@interface YHPrefixInfoViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) YHHolderInfo *holderInfo;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIImageView *backView;

@property (nonatomic, strong) UIImageView *iconView;

@property (nonatomic, strong) YHPrefixInfoView *infoView;

@property (nonatomic, strong) YHPrefixInfoButton *bottomButton;

@property (nonatomic, strong) UILabel *tempLabel;

@end

@implementation YHPrefixInfoViewController

- (YHPrefixInfoView *) infoView{
    if (!_infoView){
        _infoView = [[YHPrefixInfoView alloc] initWithFrame:CGRectMake(0, 181, [UIScreen mainScreen].bounds.size.width, 370)];
        [_infoView setBackgroundColor:[UIColor whiteColor]];
        _infoView.holderInfo = self.holderInfo;
    }
    return _infoView;
}

- (UIImageView *) backView{
    if (!_backView){
        _backView = [[UIImageView alloc] init];
//        [_backView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/blog/%@", YHILMAREBlogDomainName, self.holderInfo.holder_img]] placeholderImage:[UIImage imageNamed:@"IMG_5481"] options:SDWebImageRefreshCached];
        _backView.contentMode = UIViewContentModeScaleAspectFill;
        [_backView setImage:[UIImage imageNamed:@"background"]];
        _backView.frame = CGRectMake(0, -64, [UIScreen mainScreen].bounds.size.width, 245);
        _backView.layer.masksToBounds = YES;
        SDWebImageManager *manager = [SDWebImageManager sharedManager];
        [manager downloadImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/blog/%@", YHILMAREBlogDomainName, self.holderInfo.holder_img]] options:SDWebImageRefreshCached progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                CIImage *ciimg = [[CIImage alloc] initWithImage:image];
                CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
                [filter setValue:ciimg forKey:kCIInputImageKey];
                [filter setValue:@5.0f forKey:@"inputRadius"];
                ciimg = [filter valueForKey:kCIOutputImageKey];
                CIContext *context = [CIContext contextWithOptions:nil];
                CGImageRef ref = [context createCGImage:ciimg fromRect:CGRectMake(10, 0, image.size.width - 20, image.size.height - 20)];
                UIImage *temp = [UIImage imageWithCGImage:ref];
                CGImageRelease(ref);
                dispatch_async(dispatch_get_main_queue(), ^{
                    [_backView setImage:temp];
                });
            });
            
        }];
    }
    return _backView;
}

- (UIImageView *) iconView{
    if (!_iconView){
        _iconView = [[UIImageView alloc] init];
        if (self.holderInfo){
            [_iconView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/blog/%@", YHILMAREBlogDomainName, self.holderInfo.holder_img]] placeholderImage:[UIImage imageNamed:@"IMG_5481"] options:SDWebImageRefreshCached];
        }else{
            [_iconView setImage:[UIImage imageNamed:@"IMG_5481"]];
        }
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        CGFloat iconWidth = 120;
        _iconView.frame = CGRectMake((width - iconWidth) / 2.0, 100, iconWidth, iconWidth);
        _iconView.layer.borderColor = [UIColor whiteColor].CGColor;
        _iconView.layer.borderWidth = 2;
        _iconView.layer.cornerRadius = 3;
        _iconView.layer.masksToBounds = YES;
    }
    return _iconView;
}

- (UIScrollView *) scrollView{
    if (!_scrollView){
        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        [_scrollView setBackgroundColor:[UIColor colorWithRed:231 / 255.0 green:231 / 255.0 blue:231 / 255.0 alpha:1]];
        CGSize size = [UIScreen mainScreen].bounds.size;
        _scrollView.contentSize = CGSizeMake(size.width, size.height + 100);
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.delegate = self;
    }
    return _scrollView;
}

- (YHHolderInfo *) holderInfo{
    if (!_holderInfo){
        NSString *holderPath = [[NSUserDefaults standardUserDefaults] objectForKey:@"holderPath"];
        if (holderPath){
            NSData *holder = [NSData dataWithContentsOfFile:holderPath];
            NSKeyedUnarchiver *unArachiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:holder];
            _holderInfo = [unArachiver decodeObjectForKey:@"holderInfo"];
            [unArachiver finishDecoding];
        }
    }
    return _holderInfo;
}

- (YHPrefixInfoButton *) bottomButton{
    if (!_bottomButton){
        CGFloat y = CGRectGetMaxY(self.infoView.frame) + 10;
        _bottomButton = [[YHPrefixInfoButton alloc] initWithFrame:CGRectMake(0, y, [UIScreen mainScreen].bounds.size.width, 60)];
        _bottomButton.holderInfo = self.holderInfo;
        [_bottomButton setBackgroundColor:[UIColor whiteColor]];
        [_bottomButton addTarget:self action:@selector(lanuchStatus) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bottomButton;
}

- (UILabel *) tempLabel{
    if (!_tempLabel){
        _tempLabel = [[UILabel alloc] init];
        [_tempLabel setText:@"记录时光的痕迹，分享生活的感动"];
        [_tempLabel setTextColor:[UIColor grayColor]];
        _tempLabel.font = [UIFont fontWithName:@"STHeitiTC-Light" size:14];
        [_tempLabel sizeToFit];
        CGFloat x = ([UIScreen mainScreen].bounds.size.width - _tempLabel.frame.size.width) / 2.0;
        CGFloat y = CGRectGetMaxY(self.bottomButton.frame) + 30;
        _tempLabel.frame = CGRectMake(x, y, 0, 0);
        [_tempLabel sizeToFit];
        [_tempLabel setBackgroundColor:[UIColor clearColor]];
    }
    return _tempLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.backView];
    [self.scrollView addSubview:self.infoView];
    [self.scrollView addSubview:self.iconView];
    [self.scrollView addSubview:self.bottomButton];
    [self.scrollView addSubview:self.tempLabel];
}


- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    UINavigationBar *bar = self.navigationController.navigationBar;
    [bar setBackgroundImage:[self imageWithColor:[UIColor clearColor] size:CGSizeMake([UIScreen mainScreen].bounds.size.width, 64)] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [bar setShadowImage:[self imageWithColor:[UIColor clearColor] size:CGSizeMake([UIScreen mainScreen].bounds.size.width, 1)]];
}

- (void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    UINavigationBar *bar = self.navigationController.navigationBar;
    [bar setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:211 / 255.0 green:69 / 255.0 blue:75 / 255.0 alpha:1] size:CGSizeMake([UIScreen mainScreen].bounds.size.width, 64)] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [bar setShadowImage:[self imageWithColor:[UIColor colorWithRed:211 / 255.0 green:69 / 255.0 blue:75 / 255.0 alpha:1] size:CGSizeMake([UIScreen mainScreen].bounds.size.width, 1)]];
}

- (UIImage *) imageWithColor:(UIColor *) color size:(CGSize) size{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) lanuchStatus{
    YHStatusEditViewController *statusEdit = [[YHStatusEditViewController alloc] init];
    [self presentViewController:statusEdit animated:YES completion:nil];
}

- (void) scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint offset = scrollView.contentOffset;
    if (offset.y <= -64){
        UINavigationBar *bar = self.navigationController.navigationBar;
        [bar setBackgroundImage:[self imageWithColor:[UIColor clearColor] size:CGSizeMake([UIScreen mainScreen].bounds.size.width, 64)] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
        [bar setShadowImage:[self imageWithColor:[UIColor clearColor] size:CGSizeMake([UIScreen mainScreen].bounds.size.width, 1)]];
        self.backView.frame = CGRectMake(0, offset.y, [UIScreen mainScreen].bounds.size.width, 245 + (-64 - offset.y));
    }else if(offset.y >= -32){
        CGFloat rate = (32 + offset.y) / 132;
        if (rate >= 1){
            self.title = self.holderInfo.holder_name_en;
        }else{
            self.title = @"";
        }
        UINavigationBar *bar = self.navigationController.navigationBar;
        [bar setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:211 / 255.0 green:69 / 255.0 blue:75 / 255.0 alpha:rate] size:CGSizeMake([UIScreen mainScreen].bounds.size.width, 64)] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
        [bar setShadowImage:[self imageWithColor:[UIColor colorWithRed:211 / 255.0 green:69 / 255.0 blue:75 / 255.0 alpha:rate] size:CGSizeMake([UIScreen mainScreen].bounds.size.width, 1)]];
    }
}

@end
