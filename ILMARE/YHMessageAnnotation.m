//
//  YHMessageAnnotation.m
//  ILMARE
//
//  Created by yh_swjtu on 17/7/7.
//  Copyright © 2017年 yh_swjtu. All rights reserved.
//

#import "YHMessageAnnotation.h"

@interface YHMessageAnnotation ()

@property (nonatomic, copy) NSString *subTitle;

@end

@implementation YHMessageAnnotation

- (instancetype) initWithSubtitle:(NSString *)subTitle andCoordinate:(CLLocationCoordinate2D) coordinate{
    if (self = [super init]){
        self.subTitle = subTitle;
        self.coordinate = coordinate;
    }
    return self;
}

- (NSString *) title{
    return @"访问位置";
}

- (NSString *) subtitle{
    return self.subTitle;
}

@end
