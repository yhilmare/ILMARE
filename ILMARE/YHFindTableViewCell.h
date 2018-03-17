//
//  YHFindTableViewCell.h
//  ILMARE
//
//  Created by yh_swjtu on 17/7/13.
//  Copyright © 2017年 yh_swjtu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YHStatusViewController;
@interface YHFindTableViewCell : UITableViewCell

@property (nonatomic, strong) UIViewController *customerView;

+ (YHFindTableViewCell *) tableView:(UITableView *) tableView
                         identifier:(NSString *) reuseableIdentifier
                                tag:(NSInteger) tag;

@end
