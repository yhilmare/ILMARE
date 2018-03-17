//
//  YHFindArticleTableViewCell.h
//  ILMARE
//
//  Created by yh_swjtu on 17/7/13.
//  Copyright © 2017年 yh_swjtu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YHArticleInfo,YHFindArticleTableViewCell;

@protocol YHFindArticleTableViewCellDelgate <NSObject>

- (void) tableViewCell:(YHFindArticleTableViewCell *) tableviewCell willDeletailArticleInfo:(YHArticleInfo *) articleInfo;

@end
@interface YHFindArticleTableViewCell : UITableViewCell

@property (nonatomic, strong) YHArticleInfo *articleInfo;

+ (YHFindArticleTableViewCell *) tableview:(UITableView *) tableView identifier:(NSString *) identifier;

@property (nonatomic, weak) id<YHFindArticleTableViewCellDelgate> delgate;

@end
