//
//  YHTabBar.h
//  ILMARE
//
//  Created by yh_swjtu on 17/7/3.
//  Copyright © 2017年 yh_swjtu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YHTabBar;

@protocol YHTabBarDelgate <NSObject>

@required

- (void) yhTabBar:(YHTabBar *) tabBar didClickButton:(UIButton *) button;

@end

@interface YHTabBar : UITabBar

@property (nonatomic, weak) id<YHTabBarDelgate> tabBardelgate;

@end


