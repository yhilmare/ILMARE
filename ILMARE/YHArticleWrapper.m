//
//  YHArticleWrapper.m
//  ILMARE
//
//  Created by yh_swjtu on 17/7/13.
//  Copyright © 2017年 yh_swjtu. All rights reserved.
//

#import "YHArticleWrapper.h"
#import "YHArticleInfo.h"

@implementation YHArticleWrapper

- (void) setArticleInfo:(YHArticleInfo *)articleInfo{
    _articleInfo = articleInfo;
    
    _rowHeight = 70 + 20;
    CGSize size = [_articleInfo.article_title maxSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 2 * YHIndexInfoMarginX, MAXFLOAT) textFont:YHIndexTitleFont];
    _rowHeight += size.height;
}

@end
