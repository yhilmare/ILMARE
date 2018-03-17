//
//  NSDate+Util.m
//  ILMARE
//
//  Created by yh_swjtu on 17/7/13.
//  Copyright © 2017年 yh_swjtu. All rights reserved.
//

#import "NSDate+Util.h"

@implementation NSDate (Util)

- (NSString *) dateString{
    NSDate *today = [NSDate date];
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSDateComponents *destCom = [calender components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:self];
    NSDateComponents *curCom = [calender components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:today];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    if (destCom.year < curCom.year){
        [format setDateFormat:@"yy-MM-dd HH:mm"];
    }else if (destCom.month < curCom.month){
        [format setDateFormat:@"MM-dd HH:mm"];
    }else{
        [format setDateFormat:@"HH:mm"];
        if(destCom.day < curCom.day){
            if (curCom.day - destCom.day == 1){
                return [NSString stringWithFormat:@"昨天 %@", [format stringFromDate:self]];
            }else{
                [format setDateFormat:@"MM-dd HH:mm"];
            }
        }else{
            return [NSString stringWithFormat:@"今天 %@", [format stringFromDate:self]];
        }
    }
    return [format stringFromDate:self];
}


@end
