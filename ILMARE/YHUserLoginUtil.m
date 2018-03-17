//
//  YHUserLoginUtil.m
//  ILMARE
//
//  Created by yh_swjtu on 17/7/5.
//  Copyright © 2017年 yh_swjtu. All rights reserved.
//

#import "YHUserLoginUtil.h"
#import "YHOperationStatusInfo.h"
#import "YHNetworkingUtil.h"

@implementation YHUserLoginUtil

+ (void) loginWithUsername:(NSString *) userName
                  password:(NSString *) password
                   success:(void (^) (YHOperationStatusInfo *resultInfo)) success
             networkStatus:(void (^) (AFNetworkReachabilityStatus status)) networkStatus
                   failure:(void (^) (NSError *error)) failure{
    NSString *url = [NSString stringWithFormat:@"%@/blog/UserLogin", YHILMAREBlogDomainName];
    NSDictionary *parameters = @{@"username":userName, @"password":[password tokenUtil]};
    
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
