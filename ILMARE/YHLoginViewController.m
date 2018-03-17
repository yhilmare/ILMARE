//
//  YHLoginViewController.m
//  ILMARE
//
//  Created by yh_swjtu on 17/7/6.
//  Copyright © 2017年 yh_swjtu. All rights reserved.
//

#import "YHLoginViewController.h"
#import "YHHolderInfo.h"
#import "YHLoginTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "YHUserLoginUtil.h"
#import "YHMBProgressHUDUtil.h"
#import "YHOperationStatusInfo.h"

@interface YHLoginViewController ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>{
    NSString *_identifier;
}

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) YHHolderInfo *holderInfo;

@property (nonatomic, strong) UITextField *usernameField;

@property (nonatomic, strong) UITextField *pwdField;

@property (nonatomic, strong) UIButton *cancelButton;

@property (nonatomic, strong) UIImageView *imgView;

@property (nonatomic, strong) UIButton *loginButton;

@property (nonatomic, strong) UIActivityIndicatorView *flower;

@end

@implementation YHLoginViewController

- (UIActivityIndicatorView *) flower{
    if (!_flower){
        _flower = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    }
    return _flower;
}

- (UIButton *) loginButton{
    if (!_loginButton){
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginButton setBackgroundColor:YHNavigationBarTintColor];
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
        [_loginButton setTitleColor:[UIColor colorWithRed:240 / 255.0 green:107 / 255.0 blue:106 / 255.0 alpha:1] forState:UIControlStateDisabled];
        CGFloat width = 330;
        CGFloat height = 45;
        CGFloat x = ([UIScreen mainScreen].bounds.size.width - width) / 2.0;
        CGFloat y = CGRectGetMaxY(self.tableView.frame) + 40;
        _loginButton.frame = CGRectMake(x, y, width, height);
        _loginButton.layer.cornerRadius = 2;
        _loginButton.layer.masksToBounds = YES;
        [_loginButton.titleLabel setFont:[UIFont systemFontOfSize:17]];
        [_loginButton addTarget:self action:@selector(loginFunction) forControlEvents:UIControlEventTouchUpInside];
        if (self.usernameField.text.length == 0 || self.pwdField.text.length == 0){
            [_loginButton setEnabled:NO];
        }
    }
    return _loginButton;
}

- (UIImageView *) imgView{
    if (!_imgView){
        CGFloat widthAndHeight = 95;
        CGFloat x = ([UIScreen mainScreen].bounds.size.width - widthAndHeight) / 2.0;
        CGFloat y = 80;
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, widthAndHeight, widthAndHeight)];
        _imgView.layer.cornerRadius = widthAndHeight / 2.0;
        _imgView.layer.masksToBounds = YES;
        _imgView.layer.borderWidth = 3;
        _imgView.layer.borderColor = [[UIColor colorWithRed:241 / 255.0 green:241 / 255.0 blue:241 / 255.0 alpha:1] CGColor];
        if (self.holderInfo){
            NSString *str = [NSString stringWithFormat:@"%@/blog/%@", YHILMAREBlogDomainName, self.holderInfo.holder_img];
            [_imgView sd_setImageWithURL:[NSURL URLWithString:str]];
        }else{
            [_imgView setImage:[UIImage imageNamed:@"IMG_5481"]];
        }
    }
    return _imgView;
}

- (UIButton *) cancelButton{
    if (!_cancelButton){
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelButton setImage:[UIImage imageNamed:@"navigationbar_close"] forState:UIControlStateNormal];
        _cancelButton.frame = CGRectMake(5, 25, 50, 50);
        [_cancelButton addTarget:self action:@selector(onclick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}

- (UITextField *) usernameField{
    if (!_usernameField){
        _usernameField = [[UITextField alloc] init];
        _usernameField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _usernameField.placeholder = @"用户名或邮箱";
        _usernameField.delegate = self;
        _usernameField.tag = 0;
        if (self.holderInfo){
            _usernameField.text = self.holderInfo.holder_name_zh;
        }
    }
    return _usernameField;
}

- (UITextField *) pwdField{
    if (!_pwdField){
        _pwdField = [[UITextField alloc] init];
        _pwdField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _pwdField.secureTextEntry = YES;
        _pwdField.placeholder = @"密码";
        _pwdField.delegate = self;
        _pwdField.tag = 1;
    }
    return _pwdField;
}

- (YHHolderInfo *)holderInfo{
    if (!_holderInfo){
        NSString *filePath = [[NSUserDefaults standardUserDefaults] objectForKey:@"holderPath"];
        if (filePath){
            NSMutableData *data = [NSMutableData dataWithContentsOfFile:filePath];
            NSKeyedUnarchiver *unArchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
            _holderInfo = [unArchiver decodeObjectForKey:@"holderInfo"];
            [unArchiver finishDecoding];
        }
    }
    return _holderInfo;
}

- (UITableView *) tableView{
    if (!_tableView){
        CGFloat height = 90;
        CGFloat y = 180;
        CGRect frame = CGRectMake(0, y, [UIScreen mainScreen].bounds.size.width, height);
        _tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 45;
        _tableView.scrollEnabled = NO;
        [_tableView setAllowsSelection:NO];
        _tableView.separatorInset = UIEdgeInsetsMake(0, 25, 0, 0);
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _identifier = @"YHLogin_identifier";
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.tableView];

    [self.view addSubview:self.cancelButton];
    [self.view addSubview:self.imgView];
    [self.view addSubview:self.loginButton];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YHLoginTableViewCell *cell;
    if (indexPath.row == 0){
        cell = [YHLoginTableViewCell tableView:tableView withIdentifier:_identifier textField:self.usernameField];
    }else{
        cell = [YHLoginTableViewCell tableView:tableView withIdentifier:_identifier textField:self.pwdField];
    }
    return cell;
}

- (void) onclick{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) textFieldDidBeginEditing:(UITextField *)textField{
    if (self.usernameField.text.length != 0 && self.pwdField.text.length != 0){
        [_loginButton setEnabled:YES];
    }else{
        [_loginButton setEnabled:NO];
    }
}

- (void) textFieldDidEndEditing:(UITextField *)textField{
    if (self.usernameField.text.length != 0 && self.pwdField.text.length != 0){
        [_loginButton setEnabled:YES];
    }else{
        [_loginButton setEnabled:NO];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.usernameField resignFirstResponder];
    [self.pwdField resignFirstResponder];
}

- (void) loginFunction{
    if (self.usernameField.text.length != 0 && self.pwdField.text.length != 0){
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        [self.loginButton addSubview:self.flower];
        self.flower.center = CGPointMake(110, 19);
        [self.loginButton setTitle:@"登录中..." forState:UIControlStateNormal];
        [self.flower startAnimating];
        [YHUserLoginUtil loginWithUsername:self.usernameField.text password:self.pwdField.text success:^(YHOperationStatusInfo *resultInfo) {
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            [self.flower stopAnimating];
            [self.flower removeFromSuperview];
            [self.loginButton setTitle:@"登录" forState:UIControlStateNormal];
            if (resultInfo.messageCode == YHUserOpertationStatusOperateSuccess){
                [YHMBProgressHUDUtil showSuccessMessage:@"登录成功" toView:self.view];
                [[NSUserDefaults standardUserDefaults] setValue:resultInfo.messageDetail forKey:@"loginToken"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self dismissViewControllerAnimated:YES completion:nil];
                });
            }else{
                [YHMBProgressHUDUtil showErrorMessage:resultInfo.messageDetail toView:self.view];
            }
        } networkStatus:^(AFNetworkReachabilityStatus status) {
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            [self.flower stopAnimating];
            [self.flower removeFromSuperview];
            [self.loginButton setTitle:@"登录" forState:UIControlStateNormal];
            [YHMBProgressHUDUtil showErrorMessage:@"网络连接错误" toView:self.view];
        } failure:^(NSError *error) {
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            [self.flower stopAnimating];
            [self.flower removeFromSuperview];
            [self.loginButton setTitle:@"登录" forState:UIControlStateNormal];
            [YHMBProgressHUDUtil showErrorMessage:@"网络连接错误" toView:self.view];
        }];
    }
}

@end
