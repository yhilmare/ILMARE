//
//  YHIndexWrapper.m
//  ILMARE
//
//  Created by yh_swjtu on 17/7/6.
//  Copyright © 2017年 yh_swjtu. All rights reserved.
//

#import "YHIndexWrapper.h"
#import "YHIndexInfo.h"

@implementation YHIndexWrapper

- (void) setIndexInfo:(YHIndexInfo *)indexInfo{
    _indexInfo = indexInfo;
    
    _rowHeight = 70;
    if (_indexInfo.index_type == YHIndexInfoTypeArticle){
        
        CGSize size = [_indexInfo.index_title maxSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 2 * YHIndexInfoMarginX, MAXFLOAT) textFont:YHIndexTitleFont];
        _rowHeight += size.height;
        _rowHeight += 10;
        size = [_indexInfo.index_glance maxSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 2 * YHIndexInfoMarginX, MAXFLOAT) textFont:YHIndexInfoFont];
        _rowHeight += size.height;
    }else{
        CGSize size = [_indexInfo.index_glance maxSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 2 * YHIndexInfoMarginX, MAXFLOAT) textFont:YHIndexInfoFont];
        _rowHeight += size.height;
    }
    _rowHeight += 15;
}

@end
