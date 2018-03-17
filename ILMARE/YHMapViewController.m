//
//  YHMapViewController.m
//  ILMARE
//
//  Created by yh_swjtu on 17/7/4.
//  Copyright © 2017年 yh_swjtu. All rights reserved.
//

#import "YHMapViewController.h"
#import <MapKit/MapKit.h>

@interface YHMapViewController ()<MKMapViewDelegate>

@property (nonatomic, strong) MKMapView *mapView;

@end

@implementation YHMapViewController

- (MKMapView *) mapView{
    if (!_mapView){
        _mapView = [[MKMapView alloc] init];
        _mapView.mapType = MKMapTypeStandard;
        _mapView.delegate = self;
        _mapView.frame = self.view.frame;
    }
    return _mapView;
}

- (void) mapViewDidFinishLoadingMap:(MKMapView *)mapView{
    
    [mapView setUserTrackingMode:MKUserTrackingModeFollow];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.mapView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
