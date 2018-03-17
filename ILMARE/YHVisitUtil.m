//
//  YHVisitUtil.m
//  ILMARE
//
//  Created by yh_swjtu on 17/7/5.
//  Copyright © 2017年 yh_swjtu. All rights reserved.
//

#import "YHVisitUtil.h"
#import "YHBlogObjWrapper.h"
#import "YHVisit.h"
#import "YHNetworkingUtil.h"

@implementation YHVisitUtil

+ (void) getVisitWithPageIndex:(NSInteger) pageIndex
                   pageContain:(NSInteger) pageContain
                    loginToken:(NSString *)loginToken
                       success:(void (^) (YHBlogObjWrapper *resultSet)) success
                 networkStatus:(void (^) (AFNetworkReachabilityStatus status)) networkStatus
                       failure:(void (^) (NSError *error)) failure{
    
    NSString *url = [NSString stringWithFormat:@"%@/blog/interfaces/SelectVisit", YHILMAREBlogDomainName];
    NSDictionary *parameter = @{@"pageIndex":[NSString stringWithFormat:@"%zd", pageIndex],
                                @"pageContain":[NSString stringWithFormat:@"%zd", pageContain],
                                @"loginID":loginToken};
    
    [YHNetworkingUtil sendHTTPPOSTRequestWithURL:url parameters:parameter success:^(id responseObj) {
        if (success){
            NSDictionary *dic = responseObj;
            YHBlogObjWrapper *wrapper = [[YHBlogObjWrapper alloc] initWithDictionary:dic];
            for(NSDictionary *temp in dic[@"list"]){
                YHVisit *visit = [[YHVisit alloc] init];
                for (NSString *key in temp.allKeys){
                    if ([visit respondsToSelector:NSSelectorFromString(key)]){
                        if ([key isEqualToString:@"visit_date"]){
                            NSDateFormatter *formate = [[NSDateFormatter alloc] init];
                            [formate setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                            NSDate *time = [formate dateFromString:temp[key]];
                            [visit setValue:time forKey:key];
                            continue;
                        }
                        [visit setValue:temp[key] forKey:key];
                    }
                }
                [wrapper.objArray addObject:visit];
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

@end
