//
//  YHMenuBar.m
//  ILMARE
//
//  Created by yh_swjtu on 17/7/10.
//  Copyright © 2017年 yh_swjtu. All rights reserved.
//

#import "YHMenuBar.h"

@implementation YHMenuBar

- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    CGContextMoveToPoint(context, 0, height);
    CGContextAddLineToPoint(context, width, height);
    
    CGContextSetLineWidth(context, 1);
    [[UIColor lightGrayColor] setStroke];
    
    CGContextStrokePath(context);
    NSString *str = @"测试";
    CGSize size = [str maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT) textFont:YHFindMenuBarFont];
    CGFloat marginX = (width - 2 * self.offsetX - self.numOfBtn * self.btnWidth) / (self.numOfBtn - 1.0);
    CGFloat x = self.offsetX + self.selectedBtnTag * self.btnWidth + self.selectedBtnTag * marginX + (self.btnWidth - size.width) / 2.0;
    CGContextMoveToPoint(context, x, height - 2);
    CGContextAddLineToPoint(context, x + size.width, height - 2);
    [[UIColor whiteColor] setStroke];
    CGContextSetLineWidth(context, 3);
    CGContextStrokePath(context);
}

- (void) setSelectedBtnTag:(NSInteger)selectedBtnTag{
    _selectedBtnTag = selectedBtnTag;
    [self setNeedsDisplay];
}

@end
