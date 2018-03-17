//
//  YHPrefixHeaderView.m
//  ILMARE
//
//  Created by yh_swjtu on 17/7/19.
//  Copyright © 2017年 yh_swjtu. All rights reserved.
//

#import "YHPrefixHeaderView.h"
#import "YHHolderInfo.h"
#import "UIImageView+WebCache.h"
#import "YHOtherInfo.h"
#import "YHOtherInfoUtil.h"

@interface YHPrefixHeaderView ()

@property (nonatomic, strong) UIImageView *iconView;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *emailLabel;

@property (nonatomic, strong) YHHolderInfo *holderInfo;

@property (nonatomic, strong) UILabel *tempLabel;

@end

@implementation YHPrefixHeaderView

- (YHHolderInfo *) holderInfo{
    if (!_holderInfo){
        NSString *holderPath = [[NSUserDefaults standardUserDefaults] objectForKey:@"holderPath"];
        if (holderPath){
            NSData *temp = [NSData dataWithContentsOfFile:holderPath];
            NSKeyedUnarchiver *unArachiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:temp];
            _holderInfo = [unArachiver decodeObjectForKey:@"holderInfo"];
            [unArachiver finishDecoding];
        }
    }
    return _holderInfo;
}

- (UIImageView *) iconView{
    if (!_iconView){
        _iconView = [[UIImageView alloc] init];
        if (self.holderInfo){
            [_iconView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/blog/%@", YHILMAREBlogDomainName, self.holderInfo.holder_img]] placeholderImage:[UIImage imageNamed:@"IMG_5481"] options:SDWebImageRefreshCached];
        }else{
            [_iconView setImage:[UIImage imageNamed:@"IMG_5481"]];
        }
    }
    return _iconView;
}

- (UILabel *) nameLabel{
    if (!_nameLabel){
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont systemFontOfSize:20];
        [_nameLabel setTextColor:[UIColor whiteColor]];
        if (self.holderInfo){
            [_nameLabel setText:self.holderInfo.holder_name_zh];
        }else{
            [_nameLabel setText:@"IL MARE"];
        }
    }
    return _nameLabel;
}

- (UILabel *) emailLabel{
    if (!_emailLabel){
        _emailLabel = [[UILabel alloc] init];
        _emailLabel.font = [UIFont systemFontOfSize:18];
        [_emailLabel setTextColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.5]];
        if (self.holderInfo){
            [_emailLabel setText:self.holderInfo.holder_email];
        }else{
            [_emailLabel setText:@"***"];
        }
    }
    return _emailLabel;
}

- (UILabel *) tempLabel{
    if (!_tempLabel){
        _tempLabel = [[UILabel alloc] init];
        _tempLabel.font = [UIFont systemFontOfSize:15];
        [_tempLabel setTextColor:[UIColor whiteColor]];
        [_tempLabel setText:@"状态 -- | 文章 --   "];
        [YHOtherInfoUtil getOtherInfo:^(YHOtherInfo *info) {
            [_tempLabel setText:[NSString stringWithFormat:@"状态 %zd | 文章 %zd", info.totalStatus, info.totalArticle]];
        } networkStatus:nil failure:nil];
    }
    return _tempLabel;
}

- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGFloat height = self.frame.size.height;
    CGFloat width = self.frame.size.width;
    CGFloat lineHeight = 13;
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, width - 20, height / 2.0);
    CGContextAddLineToPoint(context, width - 28, height / 2.0 - lineHeight / 2.0);
    CGContextAddLineToPoint(context, width - 28, height / 2.0 + lineHeight / 2.0);
    CGContextClosePath(context);
    
    [[UIColor whiteColor] setFill];
    CGContextFillPath(context);
}

- (instancetype) initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        [self addSubview:self.iconView];
        [self addSubview:self.nameLabel];
        [self addSubview:self.emailLabel];
        [self addSubview:self.tempLabel];
    }
    return self;
}

- (void) layoutSubviews{
    [super layoutSubviews];
    
    CGFloat height = self.frame.size.height;
    CGFloat icWidthAndHeight = 70;
    CGFloat x = 20;
    CGFloat y = (height - icWidthAndHeight) / 2.0;
    self.iconView.frame = CGRectMake(x, y, icWidthAndHeight, icWidthAndHeight);
    self.iconView.layer.cornerRadius = 5;
    self.iconView.layer.masksToBounds = YES;
    self.iconView.layer.borderWidth = 2;
    self.iconView.layer.borderColor = [[UIColor colorWithRed:241 / 255.0 green:241 / 255.0 blue:241 / 255.0 alpha:0.9] CGColor];
    
    
    CGSize size = [self.nameLabel.text maxSize:CGSizeMake(200, 20) textFont:[UIFont systemFontOfSize:20]];
    x = CGRectGetMaxX(self.iconView.frame) + 15;
    self.nameLabel.frame = CGRectMake(x, y + 10, size.width, size.height);
    
    size = [self.emailLabel.text maxSize:CGSizeMake(200, 20) textFont:[UIFont systemFontOfSize:18]];
    y = CGRectGetMaxY(self.nameLabel.frame) + 5;
    self.emailLabel.frame = CGRectMake(x, y, size.width, size.height);
    
    x = CGRectGetMaxX(self.nameLabel.frame) + 10;
    y = self.nameLabel.frame.origin.y;
    size = [self.tempLabel.text maxSize:CGSizeMake(200, 20) textFont:[UIFont systemFontOfSize:15]];
    self.tempLabel.frame = CGRectMake(x, y, size.width, size.height);
    
}

@end
