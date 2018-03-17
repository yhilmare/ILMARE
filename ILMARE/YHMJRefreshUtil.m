//
//  YHMJRefreshUtil.m
//  ILMARE
//
//  Created by yh_swjtu on 17/7/4.
//  Copyright © 2017年 yh_swjtu. All rights reserved.
//

#import "YHMJRefreshUtil.h"

@implementation YHMJRefreshUtil

+ (MJRefreshNormalHeader *) getHeaderWithTarget:(id) target selector:(SEL) func{
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:target refreshingAction:func];
    header.lastUpdatedTimeText = ^ NSString * (NSDate *date){
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"HH:mm"];
        return [NSString stringWithFormat:@"上次刷新 %@", [format stringFromDate:date]];
    };
    [header setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    [header setTitle:@"释放刷新" forState:MJRefreshStatePulling];
    [header setTitle:@"加载中..." forState:MJRefreshStateRefreshing];
    return header;
}

+ (MJRefreshAutoFooter *) getFooterWithTarget:(id) target selector:(SEL) func{
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:target refreshingAction:func];
    [footer setTitle:@"" forState:MJRefreshStateIdle];
    [footer setTitle:@"正在刷新" forState:MJRefreshStateRefreshing];
    footer.refreshingTitleHidden = NO;
    return footer;
}

@end
