//
//  YHEditTempObj.h
//  ILMARE
//
//  Created by yh_swjtu on 17/7/18.
//  Copyright © 2017年 yh_swjtu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, YHEditTempObjType) {
    YHEditTempObjTypeStatus = 1,
    YHEditTempObjTypeNotice = 2,
};

@interface YHEditTempObj : NSObject<NSCoding>

@property (nonatomic, copy) NSString *content;

@property (nonatomic, strong) NSDate *time_stamp;

@property (nonatomic, assign) YHEditTempObjType objType;

@end
