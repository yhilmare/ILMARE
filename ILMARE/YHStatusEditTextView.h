//
//  YHStatusEditTextView.h
//  ILMARE
//
//  Created by yh_swjtu on 17/7/16.
//  Copyright © 2017年 yh_swjtu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YHStatusEditTextView : UITextView

@property (nonatomic, copy) NSString *placeHolder;

@property (nonatomic, strong) UIColor *placeholderColor;

@property (nonatomic, strong) UILabel *placeHolderLabel;

@end
