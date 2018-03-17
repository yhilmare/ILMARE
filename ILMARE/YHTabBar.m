//
//  YHTabBar.m
//  ILMARE
//
//  Created by yh_swjtu on 17/7/3.
//  Copyright © 2017年 yh_swjtu. All rights reserved.
//

#import "YHTabBar.h"

@interface YHTabBar ()

//@property (nonatomic, strong) UIButton *centerButton;

@end

@implementation YHTabBar


//- (UIButton *) centerButton {
//    if (!_centerButton){
//        _centerButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_centerButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
//        [_centerButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
//        
//        [_centerButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
//        [_centerButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
//        _centerButton.frame = CGRectMake(100, 200, 64, 44);
//        [_centerButton addTarget:self action:@selector(onclick:) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _centerButton;
//}
//
//- (void) layoutSubviews{
//    [super layoutSubviews];
//    
//    NSInteger count = self.items.count;//子控制器数量
//    CGFloat width = self.frame.size.width;//tabbar的宽度
//    CGFloat itemWidth = 64;//每一个按钮的宽度
//    CGFloat offset = 10;//距离屏幕两边的宽度
//    CGFloat marginX = (width - (count + 1) * itemWidth - offset * 2) / count;//每个按钮之间的宽度
//    CGFloat x = offset;//初始的x值
//    int i = 0;
//    for (UIView *view in self.subviews){
//        if ([view isKindOfClass:NSClassFromString(@"UITabBarButton")]){
//            if ((i ++) == count / 2){
//                self.centerButton.frame = CGRectMake(x, 2.5, itemWidth, 44);
//                x = CGRectGetMaxX(self.centerButton.frame) + marginX;
//            }
//            view.frame = CGRectMake(x, 2.5, itemWidth, 44);
//            x = CGRectGetMaxX(view.frame) + marginX;
//        }
//    }
//    [self addSubview:self.centerButton];
//}
//
//
//- (void) onclick:(UIButton *) button{
//    if ([self.tabBardelgate respondsToSelector:@selector(yhTabBar:didClickButton:)]){
//        [self.tabBardelgate yhTabBar:self didClickButton:button];
//    }
//}

@end
