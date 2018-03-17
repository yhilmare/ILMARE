//
//  YHHolderInfoUtil.h
//  ILMARE
//
//  Created by yh_swjtu on 17/7/5.
//  Copyright © 2017年 yh_swjtu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YHHolderInfo;
@interface YHHolderInfoUtil : NSObject

+ (void) getHolderInfo:(void (^) (YHHolderInfo *info)) success
         networkStatus:(void (^) (AFNetworkReachabilityStatus status)) networkStatus
               failure:(void (^) (NSError *error)) failure;

@end
