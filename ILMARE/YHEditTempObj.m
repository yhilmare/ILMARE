//
//  YHEditTempObj.m
//  ILMARE
//
//  Created by yh_swjtu on 17/7/18.
//  Copyright © 2017年 yh_swjtu. All rights reserved.
//

#import "YHEditTempObj.h"

@implementation YHEditTempObj

- (void) encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.content forKey:@"content"];
    [aCoder encodeObject:self.time_stamp forKey:@"time_stamp"];
    [aCoder encodeInteger:self.objType forKey:@"objType"];
}

- (instancetype) initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]){
        self.content = [aDecoder decodeObjectForKey:@"content"];
        self.time_stamp = [aDecoder decodeObjectForKey:@"time_stamp"];
        self.objType = [aDecoder decodeIntegerForKey:@"objType"];
    }
    return self;
}

@end
