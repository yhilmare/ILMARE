//
//  YHDetailView.h
//  ILMARE
//
//  Created by yh_swjtu on 17/7/7.
//  Copyright © 2017年 yh_swjtu. All rights reserved.
//

#import <UIKit/UIKit.h>


@class YHDetailView;
@protocol YHDetailViewDelgate <NSObject>

@required

- (void) YHDetailView:(YHDetailView *) detailView didClickButton:(UIButton *)button;

@end

@class YHMessage;

@interface YHDetailView : UIView

- (instancetype) initWithMessage:(YHMessage *)message;

@property (nonatomic, weak) id<YHDetailViewDelgate> delgate;

@end
