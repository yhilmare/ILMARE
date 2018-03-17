//
//  YHNetworkingUtil.h
//  ILMARE
//
//  Created by yh_swjtu on 17/7/4.
//  Copyright © 2017年 yh_swjtu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface YHNetworkingUtil : NSObject

+ (void) sendHTTPPOSTRequestWithURL:(NSString *) url
                         parameters:(NSDictionary *) parameter
                            success:(void (^) (id responseObj)) success
                       networkError:(void (^) (AFNetworkReachabilityStatus status)) networkStatus
                            failure:(void (^) (NSError *error)) failure;


+ (void) sendHTTPGETRequestWithURL:(NSString *)url
                        parameters:(NSDictionary *) parameter
                           success:(void (^) (id responseObj)) success
                      networkError:(void (^) (AFNetworkReachabilityStatus status)) networkStatus
                           failure:(void (^) (NSError *error)) failure;

@end
