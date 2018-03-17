//
//  YHMBProgressHUDUtil.h
//  ILMARE
//
//  Created by yh_swjtu on 17/7/4.
//  Copyright © 2017年 yh_swjtu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHMBProgressHUDUtil : NSObject

+ (void) showSuccessMessage:(NSString *) message toView:(UIView *) view;

+ (void) showErrorMessage:(NSString *) message toView:(UIView *) view;

@end
