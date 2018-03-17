//
//  NSString+Util.m
//  ILMARE
//
//  Created by yh_swjtu on 17/7/3.
//  Copyright © 2017年 yh_swjtu. All rights reserved.
//

#import "NSString+Util.h"

@implementation NSString (Util)

- (CGSize) maxSize:(CGSize) size textFont:(UIFont *) font{
    return [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
}

- (NSString *) tokenUtil{
    const char *origin = [self UTF8String];
    Byte temp[CC_MD5_DIGEST_LENGTH];
    CC_MD5(origin, (CC_LONG)strlen(origin), temp);
    NSData *data = [[NSData alloc] initWithBytes:temp length:CC_MD5_DIGEST_LENGTH];
    return [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

@end
