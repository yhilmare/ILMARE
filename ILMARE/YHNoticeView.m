//
//  YHNoticeView.m
//  ILMARE
//
//  Created by yh_swjtu on 17/7/31.
//  Copyright © 2017年 yh_swjtu. All rights reserved.
//

#import "YHNoticeView.h"
#import "YHNotice.h"
#import "YHHolderInfo.h"
#import "UIImageView+WebCache.h"

@interface YHNoticeView ()

@property (nonatomic, strong) UILabel *noticeLabel;

@end

@implementation YHNoticeView

- (UILabel *) noticeLabel{
    if (!_noticeLabel){
        _noticeLabel = [[UILabel alloc] init];
        _noticeLabel.font = [UIFont systemFontOfSize:17];
        _noticeLabel.frame = CGRectMake(0, 0, 100, 30);
        [_noticeLabel setText:@"IL MARE发布的公告"];
        [_noticeLabel sizeToFit];
        [_noticeLabel setBackgroundColor:[UIColor grayColor]];
    }
    return _noticeLabel;
}

- (void)drawRect:(CGRect)rect {
}

- (instancetype) initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        [self setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:self.noticeLabel];
    }
    return self;
}

@end
