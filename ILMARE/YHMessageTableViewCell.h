//
//  YHMessageTableViewCell.h
//  ILMARE
//
//  Created by yh_swjtu on 17/7/6.
//  Copyright © 2017年 yh_swjtu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YHMessage;

@interface YHMessageTableViewCell : UITableViewCell

@property (nonatomic, strong) YHMessage *message;

+ (YHMessageTableViewCell *) tableView:(UITableView *) tableView identifier:(NSString *) identifier;

@end
