//
//  YHIndexViewTableViewCell.h
//  ILMARE
//
//  Created by yh_swjtu on 17/7/6.
//  Copyright © 2017年 yh_swjtu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YHIndexInfo, YHHolderInfo;
@interface YHIndexViewTableViewCell : UITableViewCell

+ (YHIndexViewTableViewCell *) tableView:(UITableView *) tableview reuseableIdentifier:(NSString *) identifier;

@property (nonatomic, strong) YHIndexInfo *indexInfo;

@property (nonatomic, strong) YHHolderInfo *holderInfo;

@end
