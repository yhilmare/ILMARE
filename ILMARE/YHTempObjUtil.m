//
//  YHTempObjUtil.m
//  ILMARE
//
//  Created by yh_swjtu on 17/7/18.
//  Copyright © 2017年 yh_swjtu. All rights reserved.
//

#import "YHTempObjUtil.h"
#import "YHEditTempObj.h"

@implementation YHTempObjUtil

+ (NSMutableArray *) tempMutableArray{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [NSString stringWithFormat:@"%@/temp.data", path];
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:filePath]){
        return nil;
    }else{
        NSMutableData *data = [NSMutableData dataWithContentsOfFile:filePath];
        NSKeyedUnarchiver *unArachiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        NSMutableArray *array = [unArachiver decodeObjectForKey:@"temp_array"];
        [unArachiver finishDecoding];
        return array;
    }
}

+ (void) writeEditObjToFile:(YHEditTempObj *) tempObj{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [NSString stringWithFormat:@"%@/temp.data", path];
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:filePath]){
        NSMutableData *data = [NSMutableData data];
        NSMutableArray *array = [NSMutableArray arrayWithObject:tempObj];
        NSKeyedArchiver *arachiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
        [arachiver encodeObject:array forKey:@"temp_array"];
        [arachiver finishEncoding];
        [data writeToFile:filePath atomically:YES];
    }else{
        NSMutableData *data = [NSMutableData dataWithContentsOfFile:filePath];
        NSKeyedUnarchiver *unArachiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        NSMutableArray *array = [unArachiver decodeObjectForKey:@"temp_array"];
        [unArachiver finishDecoding];
        [array insertObject:tempObj atIndex:0];
        data = [NSMutableData data];
        NSKeyedArchiver *arachiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
        [arachiver encodeObject:array forKey:@"temp_array"];
        [arachiver finishEncoding];
        [data writeToFile:filePath atomically:YES];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"YHSaveTempObj" object:nil];
}

+ (void) writeArrayToFile:(NSMutableArray *) array{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [NSString stringWithFormat:@"%@/temp.data", path];
    
    NSMutableData *data = [NSMutableData data];
    NSKeyedArchiver *arachiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [arachiver encodeObject:array forKey:@"temp_array"];
    [arachiver finishEncoding];
    [data writeToFile:filePath atomically:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"YHSaveTempObj" object:nil];
}


@end
