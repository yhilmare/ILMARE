//
//  YHStatusWrapper.h
//  ILMARE
//
//  Created by yh_swjtu on 17/7/13.
//  Copyright © 2017年 yh_swjtu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YHStatus;

@interface YHStatusWrapper : NSObject

@property (nonatomic, strong) YHStatus *status;

@property (nonatomic, assign) CGFloat rowHeight;

@end
