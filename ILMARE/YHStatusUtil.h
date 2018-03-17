//
//  YHStatusUtil.h
//  ILMARE
//
//  Created by yh_swjtu on 17/7/5.
//  Copyright © 2017年 yh_swjtu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YHBlogObjWrapper, YHOperationStatusInfo;

@interface YHStatusUtil : NSObject

+ (void) getStatusInfoWithPageIndex:(NSInteger) pageIndex
                            success:(void (^) (YHBlogObjWrapper *resultSet)) success
                      networkStatus:(void (^) (AFNetworkReachabilityStatus status)) networkStatus
                            failure:(void (^) (NSError *error)) failure;

+ (void) insertStatus:(NSString *) status
           loginToken:(NSString *) loginToken
              success:(void (^) (YHOperationStatusInfo *resultInfo)) success
        networkStatus:(void (^) (AFNetworkReachabilityStatus status)) networkStatus
              failure:(void (^) (NSError *error)) failure;

+ (void) deleteStatus:(NSString *) statusID
           loginToken:(NSString *) loginToken
              success:(void (^) (YHOperationStatusInfo *resultInfo)) success
        networkStatus:(void (^) (AFNetworkReachabilityStatus status)) networkStatus
              failure:(void (^) (NSError *error)) failure;

@end
