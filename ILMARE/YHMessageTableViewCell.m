//
//  YHMessageTableViewCell.m
//  ILMARE
//
//  Created by yh_swjtu on 17/7/6.
//  Copyright © 2017年 yh_swjtu. All rights reserved.
//

#import "YHMessageTableViewCell.h"
#import "YHMessage.h"

@interface YHMessageTableViewCell ()

@property (nonatomic, strong) UIImageView *iconView;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *detailLabel;

@property (nonatomic, strong) UILabel *dateLabel;

@property (nonatomic, strong) UIImageView *locationView;

@end

@implementation YHMessageTableViewCell

- (UIImageView *) locationView{
    if (!_locationView){
        _locationView = [[UIImageView alloc] init];
    }
    return _locationView;
}

- (UIImageView *) iconView{
    if (!_iconView){
        _iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"buddy_header_icon_newfriend"]];
    }
    return _iconView;
}

- (UILabel *) nameLabel{
    if (!_nameLabel){
        _nameLabel = [[UILabel alloc] init];
        [_nameLabel setFont:YHTableviewCellTitleFont];
    }
    return _nameLabel;
}

- (UILabel *) detailLabel{
    if (!_detailLabel){
        _detailLabel = [[UILabel alloc] init];
        [_detailLabel setFont:YHTableviewCellDetailFont];
        [_detailLabel setTextColor:[UIColor grayColor]];
//        [_detailLabel setTextColor:[UIColor colorWithRed:139 / 255.0 green:139 / 255.0 blue:139 / 255.0 alpha:1]];
    }
    return _detailLabel;
}

- (UILabel *) dateLabel{
    if (!_dateLabel){
        _dateLabel = [[UILabel alloc] init];
        [_dateLabel setFont:YHTableviewCellDateFont];
        [_dateLabel setTextColor:[UIColor grayColor]];
//        [_dateLabel setTextColor:[UIColor colorWithRed:139 / 255.0 green:139 / 255.0 blue:139 / 255.0 alpha:1]];
    }
    return _dateLabel;
}

- (void) setMessage:(YHMessage *)message{
    _message = message;
    
    [self.nameLabel setText:_message.visitor_id];
    [self.detailLabel setText:_message.message_content];
    [self.dateLabel setText:[self dateUtil:_message.message_date]];
}

- (void) layoutSubviews{
    [super layoutSubviews];
    
    CGFloat width = 50;
    CGFloat height = width;
    CGFloat x = 10;
    CGFloat y = (self.contentView.frame.size.height - height) / 2.0;
    CGFloat marginx = 5;
    
    self.iconView.frame = CGRectMake(x, y, width, height);
    self.iconView.layer.cornerRadius = width / 2.0;
    self.iconView.layer.masksToBounds = YES;
    
    x = CGRectGetMaxX(self.iconView.frame) + marginx;
    CGSize size = [self.nameLabel.text maxSize:CGSizeMake(MAXFLOAT, 30) textFont:YHTableviewCellTitleFont];
    self.nameLabel.frame = CGRectMake(x, y, size.width, size.height);
    
    width = [UIScreen mainScreen].bounds.size.width - x - marginx - 25;
    height = 20;
    y = self.contentView.frame.size.height - y - height - 5;
    self.detailLabel.frame = CGRectMake(x, y, width, height);
    
    y = self.iconView.frame.origin.y;
    size = [self.dateLabel.text maxSize:CGSizeMake(MAXFLOAT, 20) textFont:YHTableviewCellDateFont];
    x = [UIScreen mainScreen].bounds.size.width - marginx - size.width - 10;
    self.dateLabel.frame = CGRectMake(x, y, size.width, size.height);
    
    width = 20;
    x = CGRectGetMaxX(self.dateLabel.frame) - width + 5;
    y = self.detailLabel.frame.origin.y;
    self.locationView.frame = CGRectMake(x, y, width, width);
    NSString *temp = [NSString stringWithFormat:@"%@", self.message.message_latitude];
    if (![temp isEqualToString:@"0"]){
        [self.locationView setImage:[UIImage imageNamed:@"residence"]];
    }else{
        [self.locationView setImage:nil];
    }
}

+ (YHMessageTableViewCell *) tableView:(UITableView *) tableView identifier:(NSString *) identifier{
    YHMessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
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
        [self.contentView addSubview:self.iconView];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.detailLabel];
        [self.contentView addSubview:self.dateLabel];
        [self.contentView addSubview:self.locationView];
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
