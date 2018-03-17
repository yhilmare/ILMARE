//
//  YHArticleInfo.h
//  ILMARE
//
//  Created by yh_swjtu on 17/7/4.
//  Copyright © 2017年 yh_swjtu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHArticleInfo : NSObject

@property (nonatomic, copy) NSString *article_content;

@property (nonatomic, copy) NSString *article_id;

@property (nonatomic, copy) NSString *article_title;

@property (nonatomic, strong) NSDate *create_time;

@property (nonatomic, copy) NSString *holder_id;

- (instancetype) initWithDictionary:(NSDictionary *)dic;

@end
