//
//  YHNoticeView.h
//  ILMARE
//
//  Created by yh_swjtu on 17/7/31.
//  Copyright © 2017年 yh_swjtu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YHNotice, YHHolderInfo;

@interface YHNoticeView : UIView

@property (nonatomic, strong) YHNotice *notice;

@property (nonatomic, strong) YHHolderInfo *holderInfo;

@end
