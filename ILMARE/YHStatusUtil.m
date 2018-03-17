//
//  YHStatusUtil.m
//  ILMARE
//
//  Created by yh_swjtu on 17/7/5.
//  Copyright © 2017年 yh_swjtu. All rights reserved.
//

#import "YHStatusUtil.h"
#import "YHStatus.h"
#import "YHBlogObjWrapper.h"
#import "YHOperationStatusInfo.h"
#import "YHNetworkingUtil.h"

@implementation YHStatusUtil

+ (void) getStatusInfoWithPageIndex:(NSInteger) pageIndex
                             success:(void (^) (YHBlogObjWrapper *resultSet)) success
                       networkStatus:(void (^) (AFNetworkReachabilityStatus status)) networkStatus
                             failure:(void (^) (NSError *error)) failure{
    NSString *url = [NSString stringWithFormat:@"%@/blog/SelectStatusForIndexController", YHILMAREBlogDomainName];
    NSDictionary *parameter = @{@"pageIndex":[NSString stringWithFormat:@"%zd", pageIndex]};
    
    [YHNetworkingUtil sendHTTPPOSTRequestWithURL:url parameters:parameter success:^(id responseObj) {
        if (success){
            NSDictionary *dic = responseObj;
            YHBlogObjWrapper *wrapper = [[YHBlogObjWrapper alloc] initWithDictionary:dic];
            for(NSDictionary *temp in dic[@"list"]){
                YHStatus *status = [[YHStatus alloc] init];
                for (NSString *key in temp.allKeys){
                    if ([status respondsToSelector:NSSelectorFromString(key)]){
                        if ([key isEqualToString:@"publish_date"]){
                            NSDateFormatter *formate = [[NSDateFormatter alloc] init];
                            [formate setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                            NSDate *time = [formate dateFromString:temp[key]];
                            [status setValue:time forKey:key];
                            continue;
                        }
                        [status setValue:temp[key] forKey:key];
                    }
                }
                [wrapper.objArray addObject:status];
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

+ (void) insertStatus:(NSString *) status
           loginToken:(NSString *) loginToken
              success:(void (^) (YHOperationStatusInfo *resultInfo)) success
        networkStatus:(void (^) (AFNetworkReachabilityStatus status)) networkStatus
              failure:(void (^) (NSError *error)) failure{
    NSString *url = [NSString stringWithFormat:@"%@/blog/interfaces/InsertStatus", YHILMAREBlogDomainName];
    NSDictionary *parameters = @{@"statusContent":status, @"loginID":loginToken};
    
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

+ (void) deleteStatus:(NSString *) statusID
           loginToken:(NSString *) loginToken
              success:(void (^) (YHOperationStatusInfo *resultInfo)) success
        networkStatus:(void (^) (AFNetworkReachabilityStatus status)) networkStatus
              failure:(void (^) (NSError *error)) failure{
    NSString *url = [NSString stringWithFormat:@"%@/blog/interfaces/DeleteStatus", YHILMAREBlogDomainName];
    NSDictionary *parameters = @{@"statusID":statusID, @"loginID":loginToken};
    
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
