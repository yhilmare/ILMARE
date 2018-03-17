//
//  YHNoticeUtil.m
//  ILMARE
//
//  Created by yh_swjtu on 17/7/5.
//  Copyright © 2017年 yh_swjtu. All rights reserved.
//

#import "YHNoticeUtil.h"
#import "YHNotice.h"
#import "YHNetworkingUtil.h"
#import "YHOperationStatusInfo.h"

@implementation YHNoticeUtil

+ (void) getNotice:(void (^) (YHNotice *notice)) success
     networkStatus:(void (^) (AFNetworkReachabilityStatus status)) networkStatus
           failure:(void (^) (NSError *error)) failure{
    
    NSString *url = [NSString stringWithFormat:@"%@/blog/SelectNoticeController", YHILMAREBlogDomainName];
    
    [YHNetworkingUtil sendHTTPGETRequestWithURL:url parameters:nil success:^(id responseObj) {
        if (success){
            YHNotice *notice = [[YHNotice alloc] init];
            NSDictionary *dic = responseObj;
            for (NSString *key in dic.allKeys){
                if ([notice respondsToSelector:NSSelectorFromString(key)]){
                    if ([key isEqualToString:@"publish_date"]){
                        NSDateFormatter *formate = [[NSDateFormatter alloc] init];
                        [formate setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                        NSDate *time = [formate dateFromString:dic[key]];
                        [notice setValue:time forKey:key];
                        continue;
                    }
                    [notice setValue:dic[key] forKey:key];
                }
            }
            success(notice);
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

+ (void) insertNotice:(NSString *) noticeContent
           loginToken:(NSString *) loginToken
              success:(void (^) (YHOperationStatusInfo *resultInfo)) success
        networkStatus:(void (^) (AFNetworkReachabilityStatus status)) networkStatus
              failure:(void (^) (NSError *error)) failure{
    NSString *url = [NSString stringWithFormat:@"%@/blog/interfaces/InsertNotice", YHILMAREBlogDomainName];
    NSDictionary *parameters = @{@"noticeContent":noticeContent,
                                 @"loginID":loginToken};
    
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
