//
//  YHFindStatusTableViewCell.h
//  ILMARE
//
//  Created by yh_swjtu on 17/7/13.
//  Copyright © 2017年 yh_swjtu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YHStatus, YHFindStatusTableViewCell;

@protocol YHFindStatusTableViewCellDelgate <NSObject>

- (void) tableViewCell:(YHFindStatusTableViewCell *) tableviewCell willDeletailStatus:(YHStatus *) status;

@end

@interface YHFindStatusTableViewCell : UITableViewCell

+ (YHFindStatusTableViewCell *) tableView:(UITableView *) tableview identifier:(NSString *) reuseableIdentifier;

@property (nonatomic, strong) YHStatus *status;

@property (nonatomic, weak) id<YHFindStatusTableViewCellDelgate> delgate;

@end
