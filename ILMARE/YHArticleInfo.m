//
//  YHArticleInfo.m
//  ILMARE
//
//  Created by yh_swjtu on 17/7/4.
//  Copyright © 2017年 yh_swjtu. All rights reserved.
//

#import "YHArticleInfo.h"

@implementation YHArticleInfo

- (instancetype) initWithDictionary:(NSDictionary *)dic{
    if (self = [super init]){
        self.article_id = dic[@"article_id"];
        self.article_title = dic[@"article_title"];
        self.article_content = dic[@"article_content"];
        self.holder_id = dic[@"holder_id"];
        NSDateFormatter *formate = [[NSDateFormatter alloc] init];
        [formate setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        self.create_time = [formate dateFromString:dic[@"create_time"]];
    }
    return self;
}

@end
