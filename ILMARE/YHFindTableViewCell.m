//
//  YHFindTableViewCell.m
//  ILMARE
//
//  Created by yh_swjtu on 17/7/13.
//  Copyright © 2017年 yh_swjtu. All rights reserved.
//

#import "YHFindTableViewCell.h"
#import "YHStatusViewController.h"
#import "YHArticleViewController.h"

@implementation YHFindTableViewCell

- (void) setCustomerView:(UIViewController *)customerView{
    [customerView.view removeFromSuperview];
    _customerView = customerView;
    [self.contentView addSubview:_customerView.view];
    _customerView.view.transform = CGAffineTransformMakeRotation(M_PI_2);
}

- (void) layoutSubviews{
    [super layoutSubviews];
    CGFloat width = self.contentView.frame.size.width;
    CGFloat height = self.contentView.frame.size.height;
    self.customerView.view.frame = CGRectMake(0, 0, width, height);
}


+ (YHFindTableViewCell *) tableView:(UITableView *) tableView
                         identifier:(NSString *) reuseableIdentifier
                                tag:(NSInteger) tag{
    YHFindTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseableIdentifier];
    if (!cell){
        if(tag == 0){
            YHStatusViewController *statusViewController = [[YHStatusViewController alloc] init];
            cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseableIdentifier statuscontroller:statusViewController];
        }else{
            YHArticleViewController *articleViewcontroller = [[YHArticleViewController alloc] init];
            cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseableIdentifier statuscontroller:articleViewcontroller];
        }
        
    }
    return cell;
}

- (instancetype) initWithStyle:(UITableViewCellStyle)style
               reuseIdentifier:(NSString *)reuseIdentifier
              statuscontroller:(UIViewController *) controller{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        for(UIView *view in self.contentView.subviews){
            [view removeFromSuperview];
        }
        self.customerView = controller;
    }
    return self;
}



@end
