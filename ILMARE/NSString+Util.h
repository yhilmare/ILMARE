//
//  NSString+Util.h
//  ILMARE
//
//  Created by yh_swjtu on 17/7/3.
//  Copyright © 2017年 yh_swjtu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CommonCrypto/CommonDigest.h>

@interface NSString (Util)

- (CGSize) maxSize:(CGSize) size textFont:(UIFont *) font;

- (NSString *) tokenUtil;

@end
