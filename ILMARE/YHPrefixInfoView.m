//
//  YHPrefixInfoView.m
//  ILMARE
//
//  Created by yh_swjtu on 17/7/21.
//  Copyright © 2017年 yh_swjtu. All rights reserved.
//

#import "YHPrefixInfoView.h"
#import "YHHolderInfo.h"
#define YHCenterNameFontBig [UIFont fontWithName:@"STHeitiTC-Light" size:20]
#define YHCenterNameFontSmall [UIFont fontWithName:@"STHeitiTC-Light" size:17]
#define YHLeftLabelFont [UIFont fontWithName:@"STHeitiTC-Light" size:17]
#define YHRightLabelFont [UIFont fontWithName:@"STHeitiTC-Light" size:17]

@interface YHPrefixInfoView ()

@property (nonatomic, strong) UILabel *nameLabel_en;

@property (nonatomic, strong) UILabel *nameLabel_ch;

@property (nonatomic, strong) UILabel *email_label;

@property (nonatomic, strong) UILabel *email;

@property (nonatomic, strong) UILabel *region_label;

@property (nonatomic, strong) UILabel *region_one;

@property (nonatomic, strong) UILabel *region_two;

@property (nonatomic, strong) UILabel *school_label;

@property (nonatomic, strong) UILabel *school_one;

@property (nonatomic, strong) UILabel *school_two;

@property (nonatomic, strong) UILabel *school_year_label;

@property (nonatomic, strong) UILabel *school_year;

@end

@implementation YHPrefixInfoView

- (UILabel *) nameLabel_en{
    if (!_nameLabel_en){
        _nameLabel_en = [[UILabel alloc] init];
        _nameLabel_en.font = YHCenterNameFontBig;
        [_nameLabel_en setTextColor:[UIColor colorWithRed:241/255.0 green:93/255.0 blue:8/255.0 alpha:1]];
    }
    return _nameLabel_en;
}

- (UILabel *) nameLabel_ch{
    if (!_nameLabel_ch){
        _nameLabel_ch = [[UILabel alloc] init];
        _nameLabel_ch.font = YHCenterNameFontSmall;
        [_nameLabel_ch setTextColor:[UIColor colorWithRed:31 / 255.0 green:144 / 255.0 blue:230 / 255.0 alpha:1]];
    }
    return _nameLabel_ch;
}

- (UILabel *) email_label{
    if (!_email_label){
        _email_label = [[UILabel alloc] init];
        [_email_label setTextColor:[UIColor grayColor]];
        _email_label.text = @"电子邮箱";
        _email_label.font = YHLeftLabelFont;
    }
    return _email_label;
}

- (UILabel *) email{
    if (!_email){
        _email = [[UILabel alloc] init];
        _email.font = YHRightLabelFont;
        _email.numberOfLines = 0;
    }
    return _email;
}

- (UILabel *) region_label{
    if (!_region_label){
        _region_label = [[UILabel alloc] init];
        _region_label.font = YHLeftLabelFont;
        _region_label.text = @"地区";
        [_region_label setTextColor:[UIColor grayColor]];
    }
    return _region_label;
}

- (UILabel *) region_one{
    if (!_region_one){
        _region_one = [[UILabel alloc] init];
        _region_one.font = YHRightLabelFont;
        _region_one.numberOfLines = 0;
    }
    return _region_one;
}

- (UILabel *) region_two{
    if (!_region_two){
        _region_two = [[UILabel alloc] init];
        _region_two.font = YHRightLabelFont;
        _region_two.numberOfLines = 0;
    }
    return _region_two;
}

- (UILabel *) school_label{
    if (!_school_label){
        _school_label = [[UILabel alloc] init];
        _school_label.font = YHLeftLabelFont;
        _school_label.text = @"学校";
        [_school_label setTextColor:[UIColor grayColor]];
    }
    return _school_label;
}

- (UILabel *) school_one{
    if (!_school_one){
        _school_one = [[UILabel alloc] init];
        _school_one.font = YHRightLabelFont;
        _school_one.numberOfLines = 0;
    }
    return _school_one;
}

- (UILabel *) school_two{
    if (!_school_two){
        _school_two = [[UILabel alloc] init];
        _school_two.font = YHRightLabelFont;
        _school_two.numberOfLines = 0;
    }
    return _school_two;
}

- (UILabel *) school_year_label{
    if (!_school_year_label){
        _school_year_label = [[UILabel alloc] init];
        _school_year_label.font = YHLeftLabelFont;
        [_school_year_label setText:@"入学年份"];
        [_school_year_label setTextColor:[UIColor grayColor]];
    }
    return _school_year_label;
}

- (UILabel *) school_year{
    if (!_school_year){
        _school_year = [[UILabel alloc] init];
        _school_year.font = YHRightLabelFont;
    }
    return _school_year;
}

- (void)drawRect:(CGRect)rect {
    
}

- (void) layoutSubviews{
    [super layoutSubviews];
    CGSize size = [self.nameLabel_en.text maxSize:CGSizeMake(MAXFLOAT, 50) textFont:YHCenterNameFontBig];
    CGFloat x = ([UIScreen mainScreen].bounds.size.width - size.width) / 2.0;
    CGFloat y = 47;
    self.nameLabel_en.frame = CGRectMake(x, y, size.width, size.height);
    
    size = [self.nameLabel_ch.text maxSize:CGSizeMake(MAXFLOAT, 50) textFont:YHCenterNameFontSmall];
    x = ([UIScreen mainScreen].bounds.size.width - size.width) / 2.0;
    y = CGRectGetMaxY(self.nameLabel_en.frame) + 7;
    self.nameLabel_ch.frame = CGRectMake(x, y, size.width, size.height);
    
    CGFloat centerX = 128;
    CGFloat maxWidth = [UIScreen mainScreen].bounds.size.width - YHIndexInfoMarginX - centerX;
    x = YHIndexInfoMarginX;
    y = CGRectGetMaxY(self.nameLabel_ch.frame) + 10;
    self.email_label.frame = CGRectMake(x, y, 0, 0);
    [self.email_label sizeToFit];
    
    size = [self.email.text maxSize:CGSizeMake(maxWidth, MAXFLOAT) textFont:YHRightLabelFont];
    self.email.frame = CGRectMake(centerX, y, size.width, size.height);
    
    x = YHIndexInfoMarginX;
    y = CGRectGetMaxY(self.email.frame) + 10;
    self.region_label.frame = CGRectMake(x, y, 0, 0);
    [self.region_label sizeToFit];
    
    size = [self.region_one.text maxSize:CGSizeMake(maxWidth, MAXFLOAT) textFont:YHRightLabelFont];
    self.region_one.frame = CGRectMake(centerX, y, size.width, size.height);
    y = CGRectGetMaxY(self.region_one.frame) + 5;
    size = [self.region_two.text maxSize:CGSizeMake(maxWidth, MAXFLOAT) textFont:YHRightLabelFont];
    self.region_two.frame = CGRectMake(centerX, y, size.width, size.height);
    
    y = CGRectGetMaxY(self.region_two.frame) + 10;
    self.school_label.frame = CGRectMake(x, y, 0, 0);
    [self.school_label sizeToFit];
    
    size = [self.school_one.text maxSize:CGSizeMake(maxWidth, MAXFLOAT) textFont:YHRightLabelFont];
    self.school_one.frame = CGRectMake(centerX, y, size.width, size.height);
    y = CGRectGetMaxY(self.school_one.frame) + 5;
    size = [self.school_two.text maxSize:CGSizeMake(maxWidth, MAXFLOAT) textFont:YHRightLabelFont];
    self.school_two.frame = CGRectMake(centerX, y, size.width, size.height);
    
    x = YHIndexInfoMarginX;
    y = CGRectGetMaxY(self.school_two.frame) + 10;
    self.school_year_label.frame = CGRectMake(x, y, 0, 0);
    [self.school_year_label sizeToFit];
    
    size = [self.school_year.text maxSize:CGSizeMake(maxWidth, MAXFLOAT) textFont:YHRightLabelFont];
    self.school_year.frame = CGRectMake(centerX, y, size.width, size.height);
    
}

- (void) setHolderInfo:(YHHolderInfo *)holderInfo{
    _holderInfo = holderInfo;
    
    [self.nameLabel_en setText:[NSString stringWithFormat:@"%@", _holderInfo.holder_name_en]];
    [self.nameLabel_ch setText:[NSString stringWithFormat:@"%@", _holderInfo.holder_name_zh]];
    [self.email setText:[NSString stringWithFormat:@"%@", _holderInfo.holder_email]];
    [self.region_one setText:[NSString stringWithFormat:@"%@ %@", _holderInfo.holder_province_zh, _holderInfo.holder_city_zh]];
    [self.region_two setText:[NSString stringWithFormat:@"%@ %@", _holderInfo.holder_city_en, _holderInfo.holder_province_en]];
    
    [self.school_one setText:[NSString stringWithFormat:@"%@",_holderInfo.holder_school_zh]];
    [self.school_two setText:[NSString stringWithFormat:@"%@",_holderInfo.holder_school_en]];

    [self.school_year setText:[NSString stringWithFormat:@"%@年",_holderInfo.holder_school_year]];
}

- (instancetype) initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        [self addSubview:self.nameLabel_ch];
        [self addSubview:self.nameLabel_en];
        [self addSubview:self.email];
        [self addSubview:self.email_label];
        [self addSubview:self.region_label];
        [self addSubview:self.region_one];
        [self addSubview:self.region_two];
        [self addSubview:self.school_label];
        [self addSubview:self.school_one];
        [self addSubview:self.school_two];
        [self addSubview:self.school_year_label];
        [self addSubview:self.school_year];
    }
    return self;
}



@end
