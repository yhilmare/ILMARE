//
//  YHArticleVisitUtil.h
//  ILMARE
//
//  Created by yh_swjtu on 17/7/5.
//  Copyright © 2017年 yh_swjtu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YHBlogObjWrapper,YHOperationStatusInfo;

@interface YHArticleVisitUtil : NSObject

+ (void) getArticleVisitWithPageIndex:(NSInteger) pageIndex
                          pageContain:(NSInteger) pageContain
                           loginToken:(NSString *)loginToken
                              success:(void (^) (YHBlogObjWrapper *resultSet)) success
                        networkStatus:(void (^) (AFNetworkReachabilityStatus status)) networkStatus
                              failure:(void (^) (NSError *error)) failure;

+ (void) deleteArticleVisit:(NSString *) visitID
                 loginToken:(NSString *) loginToken
                    success:(void (^) (YHOperationStatusInfo *resultInfo)) success
              networkStatus:(void (^) (AFNetworkReachabilityStatus status)) networkStatus
                    failure:(void (^) (NSError *error)) failure;

@end
