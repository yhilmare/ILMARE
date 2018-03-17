//
//  YHLoginTableViewCell.m
//  ILMARE
//
//  Created by yh_swjtu on 17/7/6.
//  Copyright © 2017年 yh_swjtu. All rights reserved.
//

#import "YHLoginTableViewCell.h"

@interface YHLoginTableViewCell ()


@end

@implementation YHLoginTableViewCell

- (void) layoutSubviews{
    [super layoutSubviews];
    CGFloat rowHeight = self.contentView.frame.size.height;
    CGFloat x = 30;
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    self.textField.frame = CGRectMake(x, 0, width - x - 10, rowHeight);
}

+ (YHLoginTableViewCell *) tableView:(UITableView *) tableView
                      withIdentifier:(NSString *) identifier
                           textField:(UITextField *) textField{
    YHLoginTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell){
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier textField:textField];
    }
    return cell;
}

- (instancetype) initWithStyle:(UITableViewCellStyle)style
               reuseIdentifier:(NSString *)reuseIdentifier
                     textField:(UITextField *) textField{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        for(UIView *view in self.contentView.subviews){
            [view removeFromSuperview];
        }
        self.textField = textField;
        [self.contentView addSubview:self.textField];
    }
    return self;
}

@end
