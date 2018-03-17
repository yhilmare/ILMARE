//
//  YHArticleVisitUtil.m
//  ILMARE
//
//  Created by yh_swjtu on 17/7/5.
//  Copyright © 2017年 yh_swjtu. All rights reserved.
//

#import "YHArticleVisitUtil.h"
#import "YHBlogObjWrapper.h"
#import "YHArticleVisitInfo.h"
#import "YHNetworkingUtil.h"
#import "YHOperationStatusInfo.h"

@implementation YHArticleVisitUtil

+ (void) getArticleVisitWithPageIndex:(NSInteger) pageIndex
                          pageContain:(NSInteger) pageContain
                           loginToken:(NSString *)loginToken
                              success:(void (^) (YHBlogObjWrapper *resultSet)) success
                        networkStatus:(void (^) (AFNetworkReachabilityStatus status)) networkStatus
                              failure:(void (^) (NSError *error)) failure{
    
    NSString *url = [NSString stringWithFormat:@"%@/blog/interfaces/SelectArticleVisit", YHILMAREBlogDomainName];
    NSDictionary *parameter = @{@"pageIndex":[NSString stringWithFormat:@"%zd", pageIndex],
                                @"pageContain":[NSString stringWithFormat:@"%zd", pageContain],
                                @"loginID":loginToken};
    
    [YHNetworkingUtil sendHTTPPOSTRequestWithURL:url parameters:parameter success:^(id responseObj) {
        if (success){
            NSDictionary *dic = responseObj;
            YHBlogObjWrapper *wrapper = [[YHBlogObjWrapper alloc] initWithDictionary:dic];
            for(NSDictionary *temp in dic[@"list"]){
                YHArticleVisitInfo *info = [[YHArticleVisitInfo alloc] init];
                for (NSString *key in temp.allKeys){
                    if ([info respondsToSelector:NSSelectorFromString(key)]){
                        if ([key isEqualToString:@"visit_date"]){
                            NSDateFormatter *formate = [[NSDateFormatter alloc] init];
                            [formate setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                            NSDate *time = [formate dateFromString:temp[key]];
                            [info setValue:time forKey:key];
                            continue;
                        }
                        [info setValue:temp[key] forKey:key];
                    }
                }
                [wrapper.objArray addObject:info];
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

+ (void) deleteArticleVisit:(NSString *) visitID
                 loginToken:(NSString *) loginToken
                    success:(void (^) (YHOperationStatusInfo *resultInfo)) success
              networkStatus:(void (^) (AFNetworkReachabilityStatus status)) networkStatus
                    failure:(void (^) (NSError *error)) failure{
    NSString *url = [NSString stringWithFormat:@"%@/blog/interfaces/DeleteArticleVisit", YHILMAREBlogDomainName];
    NSDictionary *parameters = @{@"loginID":loginToken, @"visitID":visitID};
    
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
