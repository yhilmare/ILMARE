//
//  YHStatusWrapper.m
//  ILMARE
//
//  Created by yh_swjtu on 17/7/13.
//  Copyright © 2017年 yh_swjtu. All rights reserved.
//

#import "YHStatusWrapper.h"
#import "YHStatus.h"

@implementation YHStatusWrapper

- (void) setStatus:(YHStatus *)status{
    _status = status;
    
    _rowHeight = 70 + 20;
    CGSize size = [_status.status_content maxSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 2 * YHIndexInfoMarginX, MAXFLOAT) textFont:YHIndexInfoFont];
    _rowHeight += size.height;
}

@end
