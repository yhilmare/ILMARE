//
//  YHFindArticleTableViewCell.m
//  ILMARE
//
//  Created by yh_swjtu on 17/7/13.
//  Copyright © 2017年 yh_swjtu. All rights reserved.
//

#import "YHFindArticleTableViewCell.h"
#import "YHHolderInfo.h"
#import "UIImageView+WebCache.h"
#import "YHArticleInfo.h"

@interface YHFindArticleTableViewCell ()

@property (nonatomic, strong) UIImageView *iconView;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *dateLabel;

@property (nonatomic, strong) UILabel *articleTitleLabel;

@property (nonatomic, strong) YHHolderInfo *holderInfo;

@property (nonatomic, strong) UIButton *deleteButton;

@end

@implementation YHFindArticleTableViewCell

- (UIButton *) deleteButton{
    if (!_deleteButton){
        _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteButton setImage:[UIImage imageNamed:@"navigationbar_close"] forState:UIControlStateNormal];
        [_deleteButton addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteButton;
}

- (YHHolderInfo *) holderInfo{
    if (!_holderInfo){
        NSString *holderPath = [[NSUserDefaults standardUserDefaults] objectForKey:@"holderPath"];
        if (holderPath){
            NSData *temp = [NSData dataWithContentsOfFile:holderPath];
            NSKeyedUnarchiver *unArchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:temp];
            _holderInfo = [unArchiver decodeObjectForKey:@"holderInfo"];
            [unArchiver finishDecoding];
        }
    }
    return _holderInfo;
}

- (UIImageView *) iconView{
    if (!_iconView){
        _iconView = [[UIImageView alloc] init];
    }
    return _iconView;
}

- (UILabel *) nameLabel{
    if (!_nameLabel){
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont systemFontOfSize:19];
        _nameLabel.textColor = [UIColor colorWithRed:241/255.0 green:93/255.0 blue:8/255.0 alpha:1];
    }
    return _nameLabel;
}

- (UILabel *) dateLabel{
    if (!_dateLabel){
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.font = [UIFont systemFontOfSize:12];
        _dateLabel.textColor = [UIColor grayColor];
    }
    return _dateLabel;
}

- (UILabel *) articleTitleLabel{
    if (!_articleTitleLabel){
        _articleTitleLabel = [[UILabel alloc] init];
        _articleTitleLabel.font = YHIndexTitleFont;
        _articleTitleLabel.textColor = [UIColor colorWithRed:52/255.0 green:115/255.0 blue:168/255.0 alpha:1];
        _articleTitleLabel.numberOfLines = 0;
    }
    return _articleTitleLabel;
}

- (void) setArticleInfo:(YHArticleInfo *)articleInfo{
    _articleInfo = articleInfo;
    
    if (self.holderInfo){
        [self.iconView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/blog/%@", YHILMAREBlogDomainName, self.holderInfo.holder_img]] placeholderImage:[UIImage imageNamed:@"IMG_5481"] options:SDWebImageRefreshCached];
        [self.nameLabel setText:self.holderInfo.holder_name_zh];
    }else{
        [self.iconView setImage:[UIImage imageNamed:@"IMG_5481"]];
        [self.nameLabel setText:@"IL MARE"];
    }
    [self.dateLabel setText:[_articleInfo.create_time dateString]];
    
    [self.articleTitleLabel setText:_articleInfo.article_title];
}

- (void) layoutSubviews{
    [super layoutSubviews];
    
    CGFloat x = YHIndexInfoMarginX;
    CGFloat y = 10;
    CGFloat width = 50;
    CGFloat height = width;
    
    self.iconView.frame = CGRectMake(x, y, width, height);
    self.iconView.layer.cornerRadius = width / 2.0;
    self.iconView.layer.masksToBounds = YES;
    
    x = CGRectGetMaxX(self.iconView.frame) + 10;
    CGSize size = [self.nameLabel.text maxSize:CGSizeMake(MAXFLOAT, 20) textFont:[UIFont systemFontOfSize:19]];
    self.nameLabel.frame = CGRectMake(x, y, size.width, size.height);
    
    y = CGRectGetMaxY(self.nameLabel.frame) + 5;
    size = [self.dateLabel.text maxSize:CGSizeMake(MAXFLOAT, 20) textFont:[UIFont systemFontOfSize:12]];
    self.dateLabel.frame = CGRectMake(x, y, size.width, size.height);
    
    x = YHIndexInfoMarginX;
    y = CGRectGetMaxY(self.iconView.frame) + 10;
    size = [self.articleTitleLabel.text maxSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 2 * YHIndexInfoMarginX, MAXFLOAT) textFont:YHIndexTitleFont];
    self.articleTitleLabel.frame = CGRectMake(x, y, size.width, size.height);
    
    width = 20;
    x = [UIScreen mainScreen].bounds.size.width - YHIndexInfoMarginX - width;
    y = self.iconView.frame.origin.y;
    self.deleteButton.frame = CGRectMake(x, y, width, width);
}

+ (YHFindArticleTableViewCell *) tableview:(UITableView *) tableView identifier:(NSString *) identifier{
    YHFindArticleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
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
        [self.contentView addSubview:self.dateLabel];
        [self.contentView addSubview:self.articleTitleLabel];
        [self.contentView addSubview:self.deleteButton];
    }
    return self;
}
- (void) click{
    if ([self.delgate respondsToSelector:@selector(tableViewCell:willDeletailArticleInfo:)]){
        [self.delgate tableViewCell:self willDeletailArticleInfo:self.articleInfo];
    }
}

@end
