//
//  YHMessageMapViewController.m
//  ILMARE
//
//  Created by yh_swjtu on 17/7/7.
//  Copyright © 2017年 yh_swjtu. All rights reserved.
//

#import "YHMessageMapViewController.h"
#import <MapKit/MapKit.h>
#import "YHMessage.h"
#import "YHMessageAnnotation.h"

@interface YHMessageMapViewController ()

@property (nonatomic, strong) MKMapView *mapView;

@end

@implementation YHMessageMapViewController

- (MKMapView *) mapView{
    if (!_mapView){
        _mapView = [[MKMapView alloc] initWithFrame:self.view.frame];
        _mapView.mapType = MKMapTypeStandard;
    }
    return _mapView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"访问位置";
    
    NSString *latitude = [NSString stringWithFormat:@"%@", self.message.message_latitude];
    NSString *longitude = [NSString stringWithFormat:@"%@", self.message.message_longitude];
    CLLocation *location = [[CLLocation alloc] initWithLatitude:[latitude floatValue] longitude:[longitude floatValue]];
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(location.coordinate, 1000, 1000);
    
    YHMessageAnnotation *annotation = [[YHMessageAnnotation alloc] initWithSubtitle:self.subTitle andCoordinate:location.coordinate];
    [self.mapView addAnnotation:annotation];
    [self.mapView setSelectedAnnotations:@[annotation]];
    [self.mapView setRegion:region animated:YES];
    [self.view addSubview:self.mapView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
