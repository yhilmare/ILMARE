//
//  YHIndexInfo.m
//  ILMARE
//
//  Created by yh_swjtu on 17/7/4.
//  Copyright © 2017年 yh_swjtu. All rights reserved.
//

#import "YHIndexInfo.h"

@implementation YHIndexInfo

- (instancetype) initWithDictionary:(NSDictionary *)dic{
    if (self = [super init]){
        NSDateFormatter *formate = [[NSDateFormatter alloc] init];
        [formate setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        self.index_date = [formate dateFromString:dic[@"index_date"]];
        self.index_glance = dic[@"index_glance"];
        self.index_id = dic[@"index_id"];
        if ([dic[@"index_type"] isEqualToString:@"1"]){
            self.index_type = YHIndexInfoTypeArticle;
            self.index_title = dic[@"index_title"];
        }else{
            self.index_type = YHIndexInfoTypeStatus;
            self.index_title = nil;
        }
    }
    return self;
}

@end
