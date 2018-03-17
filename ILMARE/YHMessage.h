//
//  YHMessage.h
//  ILMARE
//
//  Created by yh_swjtu on 17/7/5.
//  Copyright © 2017年 yh_swjtu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHMessage : NSObject

@property (nonatomic, copy) NSString *message_content;

@property (nonatomic, strong) NSDate *message_date;

@property (nonatomic, copy) NSString *message_id;

@property (nonatomic, copy) NSString *message_latitude;

@property (nonatomic, copy) NSString *message_longitude;

@property (nonatomic, copy) NSString *visitor_id;

@end
