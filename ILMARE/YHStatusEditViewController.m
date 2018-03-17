//
//  YHStatusEditViewController.m
//  ILMARE
//
//  Created by yh_swjtu on 17/7/15.
//  Copyright © 2017年 yh_swjtu. All rights reserved.
//

#import "YHStatusEditViewController.h"
#import "MBProgressHUD.h"
#import "YHStatusEditTextView.h"
#import "YHStatusUtil.h"
#import "YHMBProgressHUDUtil.h"
#import "YHOperationStatusInfo.h"
#import "YHEditTempObj.h"
#import "YHTempObjUtil.h"
#import <CoreLocation/CoreLocation.h>

@interface YHStatusEditViewController ()<UITextViewDelegate, CLLocationManagerDelegate>

@property (nonatomic, strong) MBProgressHUD *hud;

@property (nonatomic, strong) UINavigationBar *customBar;

@property (nonatomic, strong) UINavigationItem *customItem;

@property (nonatomic, strong) YHStatusEditTextView *textView;

@property (nonatomic, strong) UIToolbar *toolBar;

@property (nonatomic, strong) UIView *toolView;

@property (nonatomic, strong) UIButton *locationButton;

@property (nonatomic, strong) CLLocation *currentLocation;

@property (nonatomic, strong) CLLocationManager *locationManager;

@property (nonatomic, strong) UILabel *numLabel;

@property (nonatomic, assign) NSInteger flag;

@end

@implementation YHStatusEditViewController

- (UILabel *) numLabel{
    if (!_numLabel){
        _numLabel = [[UILabel alloc] init];
        _numLabel.font = [UIFont systemFontOfSize:15];
        CGSize size = [UIScreen mainScreen].bounds.size;
        CGFloat width = 40;
        CGFloat height = 25;
        [_numLabel setTextColor:[UIColor grayColor]];
        _numLabel.textAlignment = NSTextAlignmentCenter;
        _numLabel.frame = CGRectMake(size.width - width - 10, (35 - height) / 2.0, width, height);
    }
    return _numLabel;
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

- (UIButton *) locationButton{
    if (!_locationButton){
        _locationButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_locationButton setImage:[UIImage imageNamed:@"residence"] forState:UIControlStateNormal];
        NSAttributedString *str = [[NSAttributedString alloc] initWithString:@"您的哪里?" attributes:@{NSForegroundColorAttributeName:[UIColor grayColor], NSFontAttributeName:[UIFont systemFontOfSize:15]}];
        [_locationButton setAttributedTitle:str forState:UIControlStateNormal];
        [_locationButton sizeToFit];
        CGSize size = _locationButton.frame.size;
        _locationButton.frame = CGRectMake(5, (35 - size.height - 3) / 2.0, size.width + 20, size.height + 3);
        _locationButton.contentEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
        _locationButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _locationButton.layer.cornerRadius = size.height / 2.0;
        _locationButton.layer.masksToBounds = YES;
        [_locationButton setBackgroundColor:[UIColor colorWithRed:248 / 255.0 green:248 / 255.0 blue:248 / 255.0 alpha:1]];
        _locationButton.layer.borderWidth = 1;
        _locationButton.layer.borderColor = [UIColor colorWithRed:163 / 255.0 green:163 / 255.0 blue:163 / 255.0 alpha:0.1].CGColor;
        [_locationButton addTarget:self action:@selector(updateLocation:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _locationButton;
}

- (UIView *) toolView{
    if (!_toolView){
        CGSize size = [UIScreen mainScreen].bounds.size;
        _toolView = [[UIView alloc] initWithFrame:CGRectMake(0, size.height - 46 - 36, size.width, 35)];
        [_toolView setBackgroundColor:[UIColor colorWithRed:254 / 255.0 green:254 / 255.0 blue:254 / 255.0 alpha:1]];
        [_toolView addSubview:self.locationButton];
        [_toolView addSubview:self.numLabel];
    }
    return _toolView;
}

- (UIStatusBarStyle) preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (UIToolbar *) toolBar{
    if (!_toolBar){
        CGSize size = [UIScreen mainScreen].bounds.size;
        _toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, size.height - 46, size.width, 46)];
        [_toolBar setBarTintColor:[UIColor colorWithRed:246 / 255.0 green:246 / 255.0 blue:246 / 255.0 alpha:1]];
        UIButton *temp = [UIButton buttonWithType:UIButtonTypeCustom];
        [temp setImage:[[UIImage imageNamed:@"timeline_icon_more"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
        temp.frame = CGRectMake(0, 0, 20, 30);
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:temp];
        [temp addTarget:self action:@selector(resignKeyBoard) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *fixedItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"residence"] forState:UIControlStateNormal];
        NSAttributedString *title = [[NSAttributedString alloc] initWithString:@"显示定位" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
        [button setAttributedTitle:title forState:UIControlStateNormal];
        UIBarButtonItem *locationItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        button.frame = CGRectMake(0, 0, 100, 30);
        [button addTarget:self action:@selector(addLocationMsg) forControlEvents:UIControlEventTouchUpInside];
        _toolBar.items = @[leftItem, fixedItem, locationItem];
    }
    return _toolBar;
}

- (void) resignKeyBoard{
    [self.textView resignFirstResponder];
}

- (YHStatusEditTextView *) textView{
    if (!_textView){
        CGSize size = [UIScreen mainScreen].bounds.size;
        _textView = [[YHStatusEditTextView alloc] initWithFrame:CGRectMake(0, 64, size.width, size.height - 64 - 46 - 36)];
        _textView.font = YHIndexInfoFont;
        _textView.placeHolder = @"请输入您的说说内容...";
        _textView.placeholderColor = [UIColor colorWithRed:147 / 255.0 green:147 / 255.0 blue:147 / 255.0 alpha:1];
        _textView.delegate = self;
    }
    return _textView;
}

- (MBProgressHUD *) hud{
    if (!_hud){
        _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        _hud.label.text = @"发表中...";
        [_hud removeFromSuperViewOnHide];
    }
    return _hud;
}

- (UINavigationBar *) customBar{
    if (!_customBar){
        CGSize size = [UIScreen mainScreen].bounds.size;
        _customBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, size.width, 64)];
        UINavigationItem *item = [[UINavigationItem alloc] initWithTitle:@"发表说说"];
        _customBar.items = @[item];
        _customItem = item;
    }
    return _customBar;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.customBar];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(onclick)];
    self.customItem.leftBarButtonItem = leftItem;
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(sendStauts:)];
    self.customItem.rightBarButtonItem = rightItem;
    
    [self.view addSubview:self.textView];
    [self.view addSubview:self.toolBar];
    [self.view addSubview:self.toolView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardAppear:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void) keyboardAppear:(NSNotification *)notice{
    CGRect endFrame = [notice.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat animation = [notice.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    CGSize size = [UIScreen mainScreen].bounds.size;
    CGFloat height = size.height - 64 - 46 - 36 + (endFrame.origin.y - size.height);
    [UIView animateWithDuration:animation animations:^{
        self.toolBar.transform = CGAffineTransformMakeTranslation(0, endFrame.origin.y - size.height);
        self.toolView.transform = CGAffineTransformMakeTranslation(0, endFrame.origin.y - size.height);
        self.textView.frame = CGRectMake(0, 64, size.width, height);
    }];
}

- (void) sendStauts:(UIBarButtonItem *) item{
    [self.locationManager stopUpdatingLocation];
    if (self.textView.text.length > 140){
        [YHMBProgressHUDUtil showErrorMessage:@"最多只能输入140字" toView:self.view];
        return;
    }
    NSString *loginToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"loginToken"];
    if (!loginToken){
        [YHMBProgressHUDUtil showErrorMessage:@"您还未登录" toView:self.view];
        return;
    }
    if (self.textView.text.length == 0){
        [YHMBProgressHUDUtil showErrorMessage:@"说说内容不能为空" toView:self.view];
        return;
    }
    [self.hud showAnimated:YES];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [YHStatusUtil insertStatus:self.textView.text loginToken:loginToken success:^(YHOperationStatusInfo *resultInfo) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [self.hud hideAnimated:YES];
        if(resultInfo.messageCode == 200){
            [YHMBProgressHUDUtil showSuccessMessage:resultInfo.messageDetail toView:self.view];
            self.textView.text = @"";
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.textView resignFirstResponder];
                [self dismissViewControllerAnimated:YES completion:nil];
            });
        }else{
            [YHMBProgressHUDUtil showErrorMessage:resultInfo.messageDetail toView:self.view];
        }
    } networkStatus:^(AFNetworkReachabilityStatus status) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [self.hud hideAnimated:YES];
        [YHMBProgressHUDUtil showErrorMessage:@"网络连接错误" toView:self.view];
    } failure:^(NSError *error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [self.hud hideAnimated:YES];
        [YHMBProgressHUDUtil showErrorMessage:@"网络连接错误" toView:self.view];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [self.locationManager stopUpdatingLocation];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void) onclick{
    [self.locationManager stopUpdatingLocation];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [self.textView resignFirstResponder];
    if (self.textView.text.length != 0 && self.flag != 1){
        UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"消息提示" message:@"您是否要保存草稿" preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *yesAction = [UIAlertAction actionWithTitle:@"保存草稿" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            YHEditTempObj *obj = [[YHEditTempObj alloc] init];
            obj.content = self.textView.text;
            obj.time_stamp = [NSDate date];
            obj.objType = YHEditTempObjTypeStatus;
            [YHTempObjUtil writeEditObjToFile:obj];
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
        UIAlertAction *noAction = [UIAlertAction actionWithTitle:@"不保存" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
           [self dismissViewControllerAnimated:YES completion:nil];
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [controller addAction:yesAction];
        [controller addAction:noAction];
        [controller addAction:cancelAction];
        [self presentViewController:controller animated:controller completion:nil];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void) updateLocation:(UIButton *) button{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self.locationManager startUpdatingLocation];
}

- (void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [self.locationManager stopUpdatingLocation];
    self.currentLocation = [locations lastObject];
    if (self.currentLocation){
        CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
        [geoCoder reverseGeocodeLocation:self.currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            if (placemarks.count != 0){
                CLPlacemark *placeMark = [placemarks lastObject];
                NSDictionary *dic = [NSDictionary dictionaryWithDictionary:placeMark.addressDictionary];
                NSString *str = [NSString stringWithFormat:@"%@%@%@%@%@", dic[@"Country"],dic[@"State"],dic[@"City"],dic[@"SubLocality"],dic[@"Street"]];
                NSAttributedString *attributedStr = [[NSAttributedString alloc] initWithString:str attributes:@{NSForegroundColorAttributeName:[UIColor grayColor], NSFontAttributeName:[UIFont systemFontOfSize:15]}];
                [self.locationButton setAttributedTitle:attributedStr forState:UIControlStateNormal];
                [self.locationButton sizeToFit];
                CGSize size = self.locationButton.frame.size;
                if (size.width > 300){
                    self.locationButton.frame = CGRectMake(5, (35 - size.height - 3) / 2.0, 300, size.height + 3);
                }else{
                    self.locationButton.frame = CGRectMake(5, (35 - size.height - 3) / 2.0, size.width + 20, size.height + 3);
                }
                
                self.locationButton.userInteractionEnabled = NO;
            }
        }];
    }
}

- (void) locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [self.locationManager stopUpdatingLocation];
    [YHMBProgressHUDUtil showErrorMessage:@"定位失败" toView:self.view];
}

- (void) textViewDidChange:(UITextView *)textView{
    if (textView.text.length > 120 && textView.text.length < 140){
        [self.numLabel setTextColor:[UIColor redColor]];
        [self.numLabel setText:[NSString stringWithFormat:@"%zd", 140 - self.textView.text.length]];
    }else if(textView.text.length >= 140){
        [self.numLabel setTextColor:[UIColor redColor]];
        [self.numLabel setText:[NSString stringWithFormat:@"%zd", 140 - self.textView.text.length]];
    }else{
        [self.numLabel setTextColor:[UIColor grayColor]];
        [self.numLabel setText:[NSString stringWithFormat:@"%zd", self.textView.text.length]];
    }
}

- (void) addLocationMsg{
    if ([self.locationButton.titleLabel.text isEqualToString:@"您在哪里？"] || !self.currentLocation){
        [YHMBProgressHUDUtil showErrorMessage:@"定位信息未获取" toView:self.view];
        return;
    }
    self.textView.text = [NSString stringWithFormat:@"%@\n--%@", self.textView.text, self.locationButton.titleLabel.text];
}

- (instancetype) initWithDraft:(NSString *)draft flag:(NSInteger)flag{
    if (self = [super init]){
        self.flag = flag;
        self.textView.text = draft;
        self.textView.placeHolderLabel.hidden = YES;
    }
    return self;
}

@end
