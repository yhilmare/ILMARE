//
//  YHArticleInfoUtil.h
//  ILMARE
//
//  Created by yh_swjtu on 17/7/4.
//  Copyright © 2017年 yh_swjtu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YHBlogObjWrapper,YHOperationStatusInfo;

@interface YHArticleInfoUtil : NSObject

+ (void) getArticleInfoWithPageIndex:(NSInteger) pageIndex
                             success:(void (^) (YHBlogObjWrapper *resultSet)) success
                       networkStatus:(void (^) (AFNetworkReachabilityStatus status)) networkStatus
                             failure:(void (^) (NSError *error)) failure;

+ (void) deleteArticle:(NSString *) articleID
            loginToken:(NSString *) loginToken
               success:(void (^) (YHOperationStatusInfo *resultInfo)) success
         networkStatus:(void (^) (AFNetworkReachabilityStatus status)) networkStatus
               failure:(void (^) (NSError *error)) failure;

@end
