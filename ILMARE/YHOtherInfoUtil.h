//
//  YHOtherInfoUtil.h
//  ILMARE
//
//  Created by yh_swjtu on 17/7/5.
//  Copyright © 2017年 yh_swjtu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YHOtherInfo;
@interface YHOtherInfoUtil : NSObject

+ (void) getOtherInfo:(void (^) (YHOtherInfo *info)) success
        networkStatus:(void (^) (AFNetworkReachabilityStatus status)) networkStatus
              failure:(void (^) (NSError *error)) failure;

@end
