//
//  YHNoticeUtil.h
//  ILMARE
//
//  Created by yh_swjtu on 17/7/5.
//  Copyright © 2017年 yh_swjtu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YHNotice,YHOperationStatusInfo;
@interface YHNoticeUtil : NSObject

+ (void) getNotice:(void (^) (YHNotice *notice)) success
         networkStatus:(void (^) (AFNetworkReachabilityStatus status)) networkStatus
               failure:(void (^) (NSError *error)) failure;

+ (void) insertNotice:(NSString *) noticeContent
           loginToken:(NSString *) loginToken
              success:(void (^) (YHOperationStatusInfo *resultInfo)) success
        networkStatus:(void (^) (AFNetworkReachabilityStatus status)) networkStatus
              failure:(void (^) (NSError *error)) failure;

@end
