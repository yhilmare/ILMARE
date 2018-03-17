//
//  YHIndexWrapper.h
//  ILMARE
//
//  Created by yh_swjtu on 17/7/6.
//  Copyright © 2017年 yh_swjtu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class YHIndexInfo;

@interface YHIndexWrapper : NSObject

@property (nonatomic, strong) YHIndexInfo *indexInfo;

@property (nonatomic, assign) CGFloat rowHeight;

@end
