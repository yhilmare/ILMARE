//
//  YHMessageMapViewController.h
//  ILMARE
//
//  Created by yh_swjtu on 17/7/7.
//  Copyright © 2017年 yh_swjtu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YHMessage;

@interface YHMessageMapViewController : UIViewController

@property (nonatomic, strong) YHMessage *message;

@property (nonatomic, copy) NSString *subTitle;

@end
