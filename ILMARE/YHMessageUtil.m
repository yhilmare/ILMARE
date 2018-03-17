//
//  YHMessageUtil.m
//  ILMARE
//
//  Created by yh_swjtu on 17/7/5.
//  Copyright © 2017年 yh_swjtu. All rights reserved.
//

#import "YHMessageUtil.h"
#import "YHBlogObjWrapper.h"
#import "YHNetworkingUtil.h"
#import "YHMessage.h"
#import "YHOperationStatusInfo.h"

@implementation YHMessageUtil

+ (void) getMessageWithPageIndex:(NSInteger) pageIndex
                     pageContain:(NSInteger) pageContain
                      loginToken:(NSString *)loginToken
                         success:(void (^) (YHBlogObjWrapper *resultSet)) success
                   networkStatus:(void (^) (AFNetworkReachabilityStatus status)) networkStatus
                         failure:(void (^) (NSError *error)) failure{
    
    NSString *url = [NSString stringWithFormat:@"%@/blog/interfaces/SelectMessage", YHILMAREBlogDomainName];
    NSDictionary *parameter = @{@"pageIndex":[NSString stringWithFormat:@"%zd", pageIndex],
                                @"pageContain":[NSString stringWithFormat:@"%zd", pageContain],
                                @"loginID":loginToken};
    
    [YHNetworkingUtil sendHTTPPOSTRequestWithURL:url parameters:parameter success:^(id responseObj) {
        if (success){
            NSDictionary *dic = responseObj;
            YHBlogObjWrapper *wrapper = [[YHBlogObjWrapper alloc] initWithDictionary:dic];
            for(NSDictionary *temp in dic[@"list"]){
                YHMessage *message = [[YHMessage alloc] init];
                for (NSString *key in temp.allKeys){
                    if ([message respondsToSelector:NSSelectorFromString(key)]){
                        if ([key isEqualToString:@"message_date"]){
                            NSDateFormatter *formate = [[NSDateFormatter alloc] init];
                            [formate setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                            NSDate *time = [formate dateFromString:temp[key]];
                            [message setValue:time forKey:key];
                            continue;
                        }
                        [message setValue:temp[key] forKey:key];
                    }
                }
                [wrapper.objArray addObject:message];
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

+ (void) deleteMessage:(NSString *) messageID
            loginToken:(NSString *) loginToken
               success:(void (^) (YHOperationStatusInfo *resultInfo)) success
         networkStatus:(void (^) (AFNetworkReachabilityStatus status)) networkStatus
               failure:(void (^) (NSError *error)) failure{
    NSString *url = [NSString stringWithFormat:@"%@/blog/interfaces/DeleteMessage", YHILMAREBlogDomainName];
    NSDictionary *parameters = @{@"messageID":messageID, @"loginID":loginToken};
    
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
