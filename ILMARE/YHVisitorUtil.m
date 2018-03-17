//
//  YHVisitorUtil.m
//  ILMARE
//
//  Created by yh_swjtu on 17/7/5.
//  Copyright © 2017年 yh_swjtu. All rights reserved.
//

#import "YHVisitorUtil.h"
#import "YHBlogObjWrapper.h"
#import "YHOperationStatusInfo.h"
#import "YHNetworkingUtil.h"
#import "YHVisitor.h"


@implementation YHVisitorUtil

+ (void) getVisitorListWithPageIndex:(NSInteger) pageIndex
                          loginToken:(NSString *)loginToken
                         pageContain:(NSInteger)pageContain
                             success:(void (^) (YHBlogObjWrapper *resultSet)) success
                       networkStatus:(void (^) (AFNetworkReachabilityStatus status)) networkStatus
                             failure:(void (^) (NSError *error)) failure{
    NSString *url = [NSString stringWithFormat:@"%@/blog/interfaces/SelectVisitor", YHILMAREBlogDomainName];
    NSDictionary *parameter = @{@"pageIndex":[NSString stringWithFormat:@"%zd", pageIndex],
                                @"loginID":loginToken,
                                @"pageContain":[NSString stringWithFormat:@"%zd",pageContain]};
    
    [YHNetworkingUtil sendHTTPPOSTRequestWithURL:url parameters:parameter success:^(id responseObj) {
        if (success){
            NSDictionary *dic = responseObj;
            YHBlogObjWrapper *wrapper = [[YHBlogObjWrapper alloc] initWithDictionary:dic];
            for(NSDictionary *temp in dic[@"list"]){
                YHVisitor *visitor = [[YHVisitor alloc] init];
                for(NSString *key in temp){
                    if ([visitor respondsToSelector:NSSelectorFromString(key)]){
                        [visitor setValue:temp[key] forKey:key];
                    }
                }
                [wrapper.objArray addObject:visitor];
            }
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

+ (void) deleteVisitor:(NSString *) visitorID
            loginToken:(NSString *) loginToken
               success:(void (^) (YHOperationStatusInfo *resultInfo)) success
         networkStatus:(void (^) (AFNetworkReachabilityStatus status)) networkStatus
               failure:(void (^) (NSError *error)) failure{
    NSString *url = [NSString stringWithFormat:@"%@/blog/interfaces/DeleteVisitor", YHILMAREBlogDomainName];
    NSDictionary *parameters = @{@"visitorID":visitorID, @"loginID":loginToken};
    
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
