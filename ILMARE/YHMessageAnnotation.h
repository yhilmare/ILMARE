//
//  YHMessageAnnotation.h
//  ILMARE
//
//  Created by yh_swjtu on 17/7/7.
//  Copyright © 2017年 yh_swjtu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface YHMessageAnnotation : NSObject<MKAnnotation>

@property (nonatomic, readwrite) CLLocationCoordinate2D coordinate;

- (instancetype) initWithSubtitle:(NSString *)subTitle andCoordinate:(CLLocationCoordinate2D) coordinate;

@end
