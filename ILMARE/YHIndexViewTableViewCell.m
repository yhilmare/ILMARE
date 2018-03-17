//
//  YHIndexViewTableViewCell.m
//  ILMARE
//
//  Created by yh_swjtu on 17/7/6.
//  Copyright © 2017年 yh_swjtu. All rights reserved.
//

#import "YHIndexViewTableViewCell.h"
#import "YHIndexInfo.h"
#import "UIImageView+WebCache.h"
#import "YHHolderInfo.h"

@interface YHIndexViewTableViewCell ()

@property (nonatomic, strong) UIImageView *iconView;//头像

@property (nonatomic, strong) UILabel *index_name;//名字

@property (nonatomic, strong) UILabel *index_date;//日期

@property (nonatomic, strong) UILabel *index_title;//文章名称

@property (nonatomic, strong) UILabel *index_glance;//梗概


@end

@implementation YHIndexViewTableViewCell

- (UIImageView *) iconView{
    if (!_iconView){
        _iconView = [[UIImageView alloc] init];
    }
    return _iconView;
}

- (UILabel *) index_name{
    if (!_index_name){
        _index_name = [[UILabel alloc] init];
        _index_name.font = [UIFont systemFontOfSize:19];
        _index_name.textColor = [UIColor colorWithRed:241/255.0 green:93/255.0 blue:8/255.0 alpha:1];
    }
    return _index_name;
}

- (UILabel *) index_date{
    if (!_index_date){
        _index_date = [[UILabel alloc] init];
        _index_date.font = [UIFont systemFontOfSize:12];
        _index_date.textColor = [UIColor grayColor];
    }
    return _index_date;
}

- (UILabel *) index_title{
    if (!_index_title){
        _index_title = [[UILabel alloc] init];
        _index_title.font = YHIndexTitleFont;
        _index_title.textColor = [UIColor colorWithRed:52/255.0 green:115/255.0 blue:168/255.0 alpha:1];
        _index_title.numberOfLines = 0;
    }
    return _index_title;
}

- (UILabel *) index_glance{
    if (!_index_glance){
        _index_glance = [[UILabel alloc] init];
        _index_glance.font = YHIndexInfoFont;
        _index_glance.numberOfLines = 0;
    }
    return _index_glance;
}

- (void) setIndexInfo:(YHIndexInfo *)indexInfo{
    
    _indexInfo = indexInfo;
    
    CGFloat width = 50;
    CGFloat height = 50;
    self.iconView.frame = CGRectMake(YHIndexInfoMarginX, 10, width, height);
    self.iconView.layer.cornerRadius = width / 2.0;
    self.iconView.layer.masksToBounds = YES;
    
    if (self.holderInfo){
        [self.iconView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/blog/%@", YHILMAREBlogDomainName, self.holderInfo.holder_img]]];
        [self.index_name setText:self.holderInfo.holder_name_zh];
    }else{
        [self.iconView setImage:[UIImage imageNamed:@"IMG_5481"]];
        [self.index_name setText:@"IL MARE"];
    }
    
    CGFloat x = CGRectGetMaxX(self.iconView.frame) + 10;
    CGFloat y = self.iconView.frame.origin.y + 5;
    
    self.index_name.frame = CGRectMake(x, y, 100, 20);
    
    y = CGRectGetMaxY(self.index_name.frame) + 5;
    [self.index_date setText:[self dateUtil:_indexInfo.index_date]];
    self.index_date.frame = CGRectMake(x, y, 100, 20);
    
    CGSize size;
    x = YHIndexInfoMarginX;
    if (_indexInfo.index_type == YHIndexInfoTypeArticle){
        y = CGRectGetMaxY(self.iconView.frame) + 10;
        [self.index_title setText:_indexInfo.index_title];
        CGSize size = [_indexInfo.index_title maxSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 2 * YHIndexInfoMarginX, MAXFLOAT) textFont:YHIndexTitleFont];
        self.index_title.frame = CGRectMake(x, y, size.width, size.height);
        y = CGRectGetMaxY(self.index_title.frame) + 10;
    }else{
        y = CGRectGetMaxY(self.iconView.frame) + 10;
    }
    
    size = [_indexInfo.index_glance maxSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 2 * YHIndexInfoMarginX, MAXFLOAT) textFont:YHIndexInfoFont];
    [self.index_glance setText:_indexInfo.index_glance];
    self.index_glance.frame = CGRectMake(x, y, size.width, size.height);
}

- (void) layoutSubviews{
    [super layoutSubviews];
}

+ (YHIndexViewTableViewCell *) tableView:(UITableView *) tableview reuseableIdentifier:(NSString *) identifier{
    YHIndexViewTableViewCell *cell = [tableview dequeueReusableCellWithIdentifier:identifier];
    if (!cell){
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        for (UIView *view in self.contentView.subviews){
            [view removeFromSuperview];
        }
        [self.contentView addSubview:self.index_name];
        [self.contentView addSubview:self.index_glance];
        [self.contentView addSubview:self.index_date];
        [self.contentView addSubview:self.index_title];
        [self.contentView addSubview:self.iconView];
    }
    return self;
}

- (NSString *) dateUtil:(NSDate *) date{
    NSDate *today = [NSDate date];
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSDateComponents *destCom = [calender components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];
    NSDateComponents *curCom = [calender components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:today];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    if (destCom.year < curCom.year){
        [format setDateFormat:@"yy-MM-dd HH:mm"];
    }else if (destCom.month < curCom.month){
        [format setDateFormat:@"MM-dd HH:mm"];
    }else{
        [format setDateFormat:@"HH:mm"];
        if(destCom.day < curCom.day){
            if (curCom.day - destCom.day == 1){
                return [NSString stringWithFormat:@"昨天 %@", [format stringFromDate:date]];
            }else{
                [format setDateFormat:@"MM-dd HH:mm"];
            }
        }else{
            return [NSString stringWithFormat:@"今天 %@", [format stringFromDate:date]];
        }
    }
    return [format stringFromDate:date];
}

@end
