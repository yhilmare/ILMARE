//
//  YHIndexInfoUtil.m
//  ILMARE
//
//  Created by yh_swjtu on 17/7/4.
//  Copyright © 2017年 yh_swjtu. All rights reserved.
//

#import "YHIndexInfoUtil.h"
#import "YHNetworkingUtil.h"
#import "YHBlogObjWrapper.h"
#import "YHIndexInfo.h"

@implementation YHIndexInfoUtil

+ (void) getIndexInfoWithPageIndex:(NSInteger) pageIndex
                           success:(void (^) (YHBlogObjWrapper *resultSet)) success
                     networkStatus:(void (^) (AFNetworkReachabilityStatus status)) networkStatus
                           failure:(void (^) (NSError *error)) failure{
    
    NSString *url = [NSString stringWithFormat:@"%@/blog/SelectIndexController", YHILMAREBlogDomainName];
    NSDictionary *parameter = @{@"pageIndex":[NSString stringWithFormat:@"%zd", pageIndex]};
    
    [YHNetworkingUtil sendHTTPPOSTRequestWithURL:url parameters:parameter success:^(id responseObj) {
        
        NSDictionary *dic = responseObj;
        YHBlogObjWrapper *wrapper = [[YHBlogObjWrapper alloc] initWithDictionary:dic];
        for (NSDictionary *temp in dic[@"list"]){
            YHIndexInfo *info = [[YHIndexInfo alloc] initWithDictionary:temp];
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

@end
