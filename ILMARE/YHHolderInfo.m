//
//  YHHolderInfo.m
//  ILMARE
//
//  Created by yh_swjtu on 17/7/4.
//  Copyright © 2017年 yh_swjtu. All rights reserved.
//

#import "YHHolderInfo.h"

@implementation YHHolderInfo

- (void) encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.holder_img forKey:@"holder_img"];
    [aCoder encodeObject:self.holder_id forKey:@"holder_id"];
    [aCoder encodeObject:self.holder_pwd forKey:@"holder_pwd"];
    [aCoder encodeObject:self.holder_email forKey:@"holder_email"];
    [aCoder encodeObject:self.holder_city_en forKey:@"holder_city_en"];
    [aCoder encodeObject:self.holder_city_zh forKey:@"holder_city_zh"];
    [aCoder encodeObject:self.holder_name_en forKey:@"holder_name_en"];
    [aCoder encodeObject:self.holder_name_zh forKey:@"holder_name_zh"];
    [aCoder encodeObject:self.holder_province_en forKey:@"holder_province_en"];
    [aCoder encodeObject:self.holder_province_zh forKey:@"holder_province_zh"];
    [aCoder encodeObject:self.holder_school_en forKey:@"holder_school_en"];
    [aCoder encodeObject:self.holder_school_zh forKey:@"holder_school_zh"];
    [aCoder encodeObject:self.holder_school_year forKey:@"holder_school_year"];
}

- (id) initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]){
        self.holder_school_year = [aDecoder decodeObjectForKey:@"holder_school_year"];
        self.holder_school_zh = [aDecoder decodeObjectForKey:@"holder_school_zh"];
        self.holder_school_en = [aDecoder decodeObjectForKey:@"holder_school_en"];
        self.holder_province_en = [aDecoder decodeObjectForKey:@"holder_province_en"];
        self.holder_province_zh = [aDecoder decodeObjectForKey:@"holder_province_zh"];
        self.holder_name_zh = [aDecoder decodeObjectForKey:@"holder_name_zh"];
        self.holder_name_en = [aDecoder decodeObjectForKey:@"holder_name_en"];
        self.holder_city_zh = [aDecoder decodeObjectForKey:@"holder_city_zh"];
        self.holder_city_en = [aDecoder decodeObjectForKey:@"holder_city_en"];
        self.holder_id = [aDecoder decodeObjectForKey:@"holder_id"];
        self.holder_img = [aDecoder decodeObjectForKey:@"holder_img"];
        self.holder_email = [aDecoder decodeObjectForKey:@"holder_email"];
        self.holder_pwd = [aDecoder decodeObjectForKey:@"holder_pwd"];
    }
    return self;
}


@end
