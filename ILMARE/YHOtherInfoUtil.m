//
//  YHOtherInfoUtil.m
//  ILMARE
//
//  Created by yh_swjtu on 17/7/5.
//  Copyright © 2017年 yh_swjtu. All rights reserved.
//

#import "YHOtherInfoUtil.h"
#import "YHNetworkingUtil.h"
#import "YHOtherInfo.h"

@implementation YHOtherInfoUtil

+ (void) getOtherInfo:(void (^) (YHOtherInfo *info)) success
        networkStatus:(void (^) (AFNetworkReachabilityStatus status)) networkStatus
              failure:(void (^) (NSError *error)) failure{
    
    NSString *url = [NSString stringWithFormat:@"%@/blog/GetTotalRecordController", YHILMAREBlogDomainName];
    
    [YHNetworkingUtil sendHTTPGETRequestWithURL:url parameters:nil success:^(id responseObj) {
        if (success){
            YHOtherInfo *info = [[YHOtherInfo alloc] init];
            NSDictionary *dic = responseObj;
            info.totalStatus = [dic[@"totalStatus"] integerValue];
            info.totalArticle = [dic[@"totalArticle"] integerValue];
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
