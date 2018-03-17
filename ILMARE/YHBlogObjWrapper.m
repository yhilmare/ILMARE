//
//  YHBlogObjWrapper.m
//  ILMARE
//
//  Created by yh_swjtu on 17/7/4.
//  Copyright © 2017年 yh_swjtu. All rights reserved.
//

#import "YHBlogObjWrapper.h"

@implementation YHBlogObjWrapper

- (NSMutableArray *) objArray{
    if (!_objArray){
        _objArray = [NSMutableArray array];
    }
    return _objArray;
}

- (instancetype) initWithDictionary:(NSDictionary *) dic{
    if (self = [super init]){
        self.pageContain = [dic[@"pageContain"] integerValue];
        self.pageInFrame = [dic[@"pageInFrame"] integerValue];
        self.startPage = [dic[@"startPage"] integerValue];
        self.totalPage = [dic[@"totalPage"] integerValue];
        self.totoRecord = [dic[@"totalRecord"] integerValue];
        self.currentPage = [dic[@"currentPage"] integerValue];
        self.endPage = [dic[@"endPage"] integerValue];
    }
    return self;
}

@end
