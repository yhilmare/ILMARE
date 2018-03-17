//
//  YHArticleInfoUtil.m
//  ILMARE
//
//  Created by yh_swjtu on 17/7/4.
//  Copyright © 2017年 yh_swjtu. All rights reserved.
//

#import "YHArticleInfoUtil.h"
#import "YHBlogObjWrapper.h"
#import "YHNetworkingUtil.h"
#import "YHArticleInfo.h"
#import "YHOperationStatusInfo.h"

@implementation YHArticleInfoUtil

+ (void) getArticleInfoWithPageIndex:(NSInteger) pageIndex
                           success:(void (^) (YHBlogObjWrapper *resultSet)) success
                     networkStatus:(void (^) (AFNetworkReachabilityStatus status)) networkStatus
                           failure:(void (^) (NSError *error)) failure{
    
    NSString *url = [NSString stringWithFormat:@"%@/blog/SelectArticleBriefInfoController", YHILMAREBlogDomainName];
    NSDictionary *parameter = @{@"pageIndex":[NSString stringWithFormat:@"%zd", pageIndex]};
    
    [YHNetworkingUtil sendHTTPPOSTRequestWithURL:url parameters:parameter success:^(id responseObj) {
        
        NSDictionary *dic = responseObj;
        YHBlogObjWrapper *wrapper = [[YHBlogObjWrapper alloc] initWithDictionary:dic];
        for (NSDictionary *temp in dic[@"list"]){
            YHArticleInfo *info = [[YHArticleInfo alloc] initWithDictionary:temp];
            [wrapper.objArray addObject:info];
        }
        if (success){
            success(wrapper);
        }
        
    } networkError:^(AFNetworkReachabilityStatus status) {
        if (networkStatus){
            networkStatus(status);
        }
    } failure:^(NSError *error) {
        if (failure){
            failure(error);
        }
    }];
}

+ (void) deleteArticle:(NSString *) articleID
            loginToken:(NSString *) loginToken
               success:(void (^) (YHOperationStatusInfo *resultInfo)) success
         networkStatus:(void (^) (AFNetworkReachabilityStatus status)) networkStatus
               failure:(void (^) (NSError *error)) failure{
    NSString *url = [NSString stringWithFormat:@"%@/blog/interfaces/DeleteArticleByID", YHILMAREBlogDomainName];
    NSDictionary *parameters = @{@"loginID":loginToken, @"articleID":articleID};
    
    [YHNetworkingUtil sendHTTPPOSTRequestWithURL:url parameters:parameters success:^(id responseObj) {
        if (success){
            YHOperationStatusInfo *info = [[YHOperationStatusInfo alloc] init];
            NSDictionary *dic = responseObj;
            info.messageCode = [dic[@"messageCode"] integerValue];
            info.messageDetail = dic[@"messageDetail"];
            success(info);
        }
        
    } networkError:^(AFNetworkReachabilityStatus status) {
        if (networkStatus){
            networkStatus(status);
        }
        
    } failure:^(NSError *error) {
        if (failure){
            failure(error);
        }
        
    }];
}


@end
