//
//  YHArticleWrapper.h
//  ILMARE
//
//  Created by yh_swjtu on 17/7/13.
//  Copyright © 2017年 yh_swjtu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YHArticleInfo;

@interface YHArticleWrapper : NSObject

@property (nonatomic, strong) YHArticleInfo *articleInfo;

@property (nonatomic, assign) CGFloat rowHeight;

@end
