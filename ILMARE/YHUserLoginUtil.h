//
//  YHUserLoginUtil.h
//  ILMARE
//
//  Created by yh_swjtu on 17/7/5.
//  Copyright © 2017年 yh_swjtu. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YHOperationStatusInfo;
@interface YHUserLoginUtil : NSObject

+ (void) loginWithUsername:(NSString *) userName
                  password:(NSString *) password
                   success:(void (^) (YHOperationStatusInfo *resultInfo)) success
             networkStatus:(void (^) (AFNetworkReachabilityStatus status)) networkStatus
                   failure:(void (^) (NSError *error)) failure;

@end
