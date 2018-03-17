//
//  YHPrefixInfoButton.m
//  ILMARE
//
//  Created by yh_swjtu on 17/7/21.
//  Copyright © 2017年 yh_swjtu. All rights reserved.
//

#import "YHPrefixInfoButton.h"
#import "YHHolderInfo.h"
#import "UIImageView+WebCache.h"

@interface YHPrefixInfoButton ()

@property (nonatomic, strong) UIImageView *iconView;

@property (nonatomic, strong) UILabel *msgLabel;

@property (nonatomic, strong) UIImageView *customerimgView;

@end

@implementation YHPrefixInfoButton

- (UIImageView *) iconView{
    if (!_iconView){
        _iconView = [[UIImageView alloc] init];
        _iconView.layer.cornerRadius = 3;
        _iconView.layer.masksToBounds = YES;
    }
    return _iconView;
}

- (UILabel *) msgLabel{
    if (!_msgLabel){
        _msgLabel = [[UILabel alloc] init];
        [_msgLabel setText:@"说说今天的心情吧"];
        [_msgLabel setTextColor:[UIColor grayColor]];
        _msgLabel.font = [UIFont fontWithName:@"STHeitiTC-Light" size:15];
    }
    return _msgLabel;
}

- (UIImageView *) customerimgView{
    if (!_customerimgView) {
        _customerimgView = [[UIImageView alloc] init];
    }
    return _customerimgView;
}

- (void) setHolderInfo:(YHHolderInfo *)holderInfo{
    _holderInfo = holderInfo;
    if (_holderInfo){
        [self.iconView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/blog/%@", YHILMAREBlogDomainName, self.holderInfo.holder_img]] placeholderImage:[UIImage imageNamed:@"IMG_5481"] options:SDWebImageRefreshCached];
    }else{
        [self.iconView setImage:[UIImage imageNamed:@"IMG_5481"]];
    }
    [self.customerimgView setImage:[UIImage imageNamed:@"tabbar_profile"]];
}

- (void) layoutSubviews{
    [super layoutSubviews];
    
    CGFloat x = YHIndexInfoMarginX;
    CGFloat iconWidth = 35;
    CGFloat y = (self.frame.size.height - iconWidth) / 2.0;
    self.iconView.frame = CGRectMake(x, y, iconWidth, iconWidth);
    
    x = CGRectGetMaxX(self.iconView.frame) + 10;
    self.msgLabel.frame = CGRectMake(x, y, 150, iconWidth);
    x = self.frame.size.width - iconWidth - 5;
    
    y = (self.frame.size.height - iconWidth + 10) / 2.0;
    self.customerimgView.frame = CGRectMake(x, y, iconWidth - 10, iconWidth - 10);
}

- (instancetype) initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        for (UIView *view in self.subviews){
            [view removeFromSuperview];
        }
        [self addSubview:self.iconView];
        [self addSubview:self.msgLabel];
        [self addSubview:self.customerimgView];
    }
    return self;
}

@end
