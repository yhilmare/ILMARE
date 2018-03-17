//
//  YHIndexInfo.h
//  ILMARE
//
//  Created by yh_swjtu on 17/7/4.
//  Copyright © 2017年 yh_swjtu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, YHIndexInfoType) {
    YHIndexInfoTypeArticle = 1,
    YHIndexInfoTypeStatus = 2,
};

@interface YHIndexInfo : NSObject

//状态发布时间
@property (nonatomic, strong) NSDate *index_date;

//状态简介
@property (nonatomic, copy) NSString *index_glance;

//状态id值
@property (nonatomic, copy) NSString *index_id;

//状态题目（文章类状态才有这个字段否则为nil）
@property (nonatomic, copy) NSString *index_title;

//状态类型
@property (nonatomic, assign) YHIndexInfoType index_type;

- (instancetype) initWithDictionary:(NSDictionary *)dic;


@end
