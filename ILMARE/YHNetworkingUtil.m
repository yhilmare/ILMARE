//
//  YHNetworkingUtil.m
//  ILMARE
//
//  Created by yh_swjtu on 17/7/4.
//  Copyright © 2017年 yh_swjtu. All rights reserved.
//

#import "YHNetworkingUtil.h"

@implementation YHNetworkingUtil

+ (AFNetworkReachabilityStatus) networkReachabilityStatus{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager manager];
    return manager.networkReachabilityStatus;
}

+ (void) sendHTTPPOSTRequestWithURL:(NSString *) url
                         parameters:(NSDictionary *) parameter
                            success:(void (^) (id responseObj)) success
                       networkError:(void (^) (AFNetworkReachabilityStatus status)) networkStatus
                            failure:(void (^) (NSError *error)) failure{
    AFNetworkReachabilityStatus status = [self networkReachabilityStatus];
    if (status == AFNetworkReachabilityStatusNotReachable){
        if (networkStatus){
            networkStatus(status);
        }
        return;
    }
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 10;
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", nil];
    
    [manager POST:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success){
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure){
            failure(error);
        }
    }];
}

+ (void) sendHTTPGETRequestWithURL:(NSString *)url
                        parameters:(NSDictionary *) parameter
                           success:(void (^) (id responseObj)) success
                      networkError:(void (^) (AFNetworkReachabilityStatus status)) networkStatus
                           failure:(void (^) (NSError *error)) failure{
    AFNetworkReachabilityStatus status = [self networkReachabilityStatus];
    if (status == AFNetworkReachabilityStatusNotReachable){
        if (networkStatus){
            networkStatus(status);
        }
        return;
    }
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 10;
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", nil];
    
    [manager GET:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(success){
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure){
            failure(error);
        }
    }];
}

@end
