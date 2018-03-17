//
//  YHBlogObjWrapper.h
//  ILMARE
//
//  Created by yh_swjtu on 17/7/4.
//  Copyright © 2017年 yh_swjtu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHBlogObjWrapper : NSObject

//当前页码
@property (nonatomic, assign) NSInteger currentPage;

//结束页码

@property (nonatomic, assign) NSInteger endPage;

//每一页包含的信息数目

@property (nonatomic, assign) NSInteger pageContain;

//每一页包含的页码数，对app来说无意义

@property (nonatomic, assign) NSInteger pageInFrame;

//某一页开始的页码，对于app无意义

@property (nonatomic, assign) NSInteger startPage;

//总的页数

@property (nonatomic, assign) NSInteger totalPage;

//总的记录数目

@property (nonatomic, assign) NSInteger totoRecord;

//记录了全部的具体信息
@property (nonatomic, strong) NSMutableArray *objArray;

- (instancetype) initWithDictionary:(NSDictionary *) dic;

@end
