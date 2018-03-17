//
//  YHHolderInfoUtil.m
//  ILMARE
//
//  Created by yh_swjtu on 17/7/5.
//  Copyright © 2017年 yh_swjtu. All rights reserved.
//

#import "YHHolderInfoUtil.h"
#import "YHHolderInfo.h"
#import "YHNetworkingUtil.h"

@implementation YHHolderInfoUtil

+ (void) getHolderInfo:(void (^) (YHHolderInfo *info)) success
         networkStatus:(void (^) (AFNetworkReachabilityStatus status)) networkStatus
               failure:(void (^) (NSError *error)) failure{
    NSString *url = [NSString stringWithFormat:@"%@/blog/SelectHolderForIndexController",YHILMAREBlogDomainName];
    [YHNetworkingUtil sendHTTPGETRequestWithURL:url parameters:nil success:^(id responseObj) {
        if (success){
            YHHolderInfo *info = [[YHHolderInfo alloc] init];
            NSDictionary *dic = responseObj;
            for (NSString *key in dic.allKeys){
                if ([info respondsToSelector:NSSelectorFromString(key)]){
                    [info setValue:dic[key] forKey:key];
                }
            }
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
