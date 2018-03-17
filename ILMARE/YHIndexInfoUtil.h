//
//  YHIndexInfoUtil.h
//  ILMARE
//
//  Created by yh_swjtu on 17/7/4.
//  Copyright © 2017年 yh_swjtu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YHBlogObjWrapper;

@interface YHIndexInfoUtil : NSObject

+ (void) getIndexInfoWithPageIndex:(NSInteger) pageIndex
                           success:(void (^) (YHBlogObjWrapper *resultSet)) success
                     networkStatus:(void (^) (AFNetworkReachabilityStatus status)) networkStatus
                           failure:(void (^) (NSError *error)) failure;

@end
