//
//  YHMJRefreshUtil.h
//  ILMARE
//
//  Created by yh_swjtu on 17/7/4.
//  Copyright © 2017年 yh_swjtu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJRefresh.h"

@interface YHMJRefreshUtil : NSObject

+ (MJRefreshNormalHeader *) getHeaderWithTarget:(id) target selector:(SEL) func;

+ (MJRefreshAutoFooter *) getFooterWithTarget:(id) target selector:(SEL) func;

@end
