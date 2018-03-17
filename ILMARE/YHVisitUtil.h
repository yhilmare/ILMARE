//
//  YHVisitUtil.h
//  ILMARE
//
//  Created by yh_swjtu on 17/7/5.
//  Copyright © 2017年 yh_swjtu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YHBlogObjWrapper;

@interface YHVisitUtil : NSObject

+ (void) getVisitWithPageIndex:(NSInteger) pageIndex
                   pageContain:(NSInteger) pageContain
                    loginToken:(NSString *)loginToken
                       success:(void (^) (YHBlogObjWrapper *resultSet)) success
                 networkStatus:(void (^) (AFNetworkReachabilityStatus status)) networkStatus
                       failure:(void (^) (NSError *error)) failure;

@end
