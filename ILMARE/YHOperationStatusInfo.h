//
//  YHOperationStatusInfo.h
//  ILMARE
//
//  Created by yh_swjtu on 17/7/5.
//  Copyright © 2017年 yh_swjtu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, YHUserOpertationStatus) {
    YHUserOpertationStatusInfoMiss = -100,
    YHUserOpertationStatusUserError = -200,
    YHUserOpertationStatusKernalError = -300,
    YHUserOpertationStatusOperateSuccess = 200,
};

@interface YHOperationStatusInfo : NSObject

@property (nonatomic, assign)YHUserOpertationStatus messageCode;

@property (nonatomic, copy) NSString *messageDetail;

@end
