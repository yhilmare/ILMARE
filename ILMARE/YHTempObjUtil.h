//
//  YHTempObjUtil.h
//  ILMARE
//
//  Created by yh_swjtu on 17/7/18.
//  Copyright © 2017年 yh_swjtu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YHEditTempObj;
@interface YHTempObjUtil : NSObject

+ (NSMutableArray *) tempMutableArray;

+ (void) writeEditObjToFile:(YHEditTempObj *) tempObj;

+ (void) writeArrayToFile:(NSMutableArray *) array;

@end
