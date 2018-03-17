//
//  YHLoginTableViewCell.h
//  ILMARE
//
//  Created by yh_swjtu on 17/7/6.
//  Copyright © 2017年 yh_swjtu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YHLoginTableViewCell : UITableViewCell

@property (nonatomic, strong) UITextField *textField;

+ (YHLoginTableViewCell *) tableView:(UITableView *) tableView
                      withIdentifier:(NSString *) identifier
                           textField:(UITextField *) textField;

@end
