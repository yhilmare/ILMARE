//
//  YHStatus.h
//  ILMARE
//
//  Created by yh_swjtu on 17/7/5.
//  Copyright © 2017年 yh_swjtu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHStatus : NSObject

@property (nonatomic, copy) NSString *holder_id;

@property (nonatomic, strong) NSDate *publish_date;

@property (nonatomic, copy) NSString *status_content;

@property (nonatomic, copy) NSString *status_id;

@end
