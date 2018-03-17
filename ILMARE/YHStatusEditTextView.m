//
//  YHStatusEditTextView.m
//  ILMARE
//
//  Created by yh_swjtu on 17/7/16.
//  Copyright © 2017年 yh_swjtu. All rights reserved.
//

#import "YHStatusEditTextView.h"

#define YHStatusEditTextViewMarginX 10
#define YHStatusEditTextViewMarginY 10

@implementation YHStatusEditTextView

- (UILabel *) placeHolderLabel{
    if (!_placeHolderLabel){
        _placeHolderLabel = [[UILabel alloc] init];
        _placeHolderLabel.font = YHIndexInfoFont;
        _placeHolderLabel.numberOfLines = 0;
    }
    return _placeHolderLabel;
}

- (void) setPlaceHolder:(NSString *)placeHolder{
    _placeHolder = placeHolder;
    
    [self.placeHolderLabel setText:_placeHolder];
}

- (void) setPlaceholderColor:(UIColor *)placeholderColor{
    _placeholderColor = placeholderColor;
    
    [self.placeHolderLabel setTextColor:_placeholderColor];
}

- (instancetype) initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        self.textContainerInset = UIEdgeInsetsMake(YHStatusEditTextViewMarginY, YHStatusEditTextViewMarginX, 0, YHStatusEditTextViewMarginX);
        [self addSubview:self.placeHolderLabel];
        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
        [center addObserver:self selector:@selector(textContentDidChange) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}


- (void) textContentDidChange{
    self.placeHolderLabel.hidden = self.hasText;
}

- (void) layoutSubviews{
    [super layoutSubviews];
    
    CGSize size = [self.placeHolder maxSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 2 * YHStatusEditTextViewMarginX, MAXFLOAT) textFont:YHIndexInfoFont];
    self.placeHolderLabel.frame = CGRectMake(YHStatusEditTextViewMarginX + 5, YHStatusEditTextViewMarginY, size.width, size.height);
}


@end
