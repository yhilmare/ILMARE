//
//  YHMBProgressHUDUtil.m
//  ILMARE
//
//  Created by yh_swjtu on 17/7/4.
//  Copyright © 2017年 yh_swjtu. All rights reserved.
//

#import "YHMBProgressHUDUtil.h"
#import "MBProgressHUD.h"

@implementation YHMBProgressHUDUtil

+ (void) showSuccessMessage:(NSString *) message toView:(UIView *) view{
    if (!view){
        view = [UIApplication sharedApplication].keyWindow;
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Checkmark"]];
    hud.mode = MBProgressHUDModeCustomView;
    hud.label.text = message;
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:1];
}

+ (void) showErrorMessage:(NSString *) message toView:(UIView *) view{
    if (!view){
        view = [UIApplication sharedApplication].keyWindow;
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navigationbar_close"]];
    hud.mode = MBProgressHUDModeCustomView;
    hud.label.text = message;
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:1];
}

@end
