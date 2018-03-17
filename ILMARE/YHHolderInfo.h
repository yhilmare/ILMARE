//
//  YHHolderInfo.h
//  ILMARE
//
//  Created by yh_swjtu on 17/7/4.
//  Copyright © 2017年 yh_swjtu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHHolderInfo : NSObject<NSCoding>

@property (nonatomic, copy) NSString *holder_city_en;

@property (nonatomic, copy) NSString *holder_city_zh;

@property (nonatomic, copy) NSString *holder_email;

@property (nonatomic, copy) NSString *holder_id;

@property (nonatomic, copy) NSString *holder_img;

@property (nonatomic, copy) NSString *holder_name_en;

@property (nonatomic, copy) NSString *holder_name_zh;

@property (nonatomic, copy) NSString *holder_province_en;

@property (nonatomic, copy) NSString *holder_province_zh;

@property (nonatomic, copy) NSString *holder_pwd;

@property (nonatomic, copy) NSString *holder_school_en;

@property (nonatomic, copy) NSString *holder_school_zh;

@property (nonatomic, copy) NSString *holder_school_year;

@end
