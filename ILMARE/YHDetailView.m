//
//  YHDetailView.m
//  ILMARE
//
//  Created by yh_swjtu on 17/7/7.
//  Copyright © 2017年 yh_swjtu. All rights reserved.
//

#import "YHDetailView.h"
#import "YHMessage.h"
#import "YHNetworkingUtil.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "YHMessageAnnotation.h"

@interface YHDetailView ()

@property (nonatomic, strong) UIImageView *iconView;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *dateLabel;

@property (nonatomic, strong) UILabel *detailLabel;

@property (nonatomic, strong) UIButton *locationButton;

@property (nonatomic, strong) UIImageView *locationView;

@property (nonatomic, strong) CLLocation *location;

@property (nonatomic, strong) YHMessage *message;

@property (nonatomic, strong) MKMapView *mapView;

@end

@implementation YHDetailView

- (MKMapView *) mapView{
    if (!_mapView){
        _mapView = [[MKMapView alloc] init];
        _mapView.mapType = MKMapTypeStandard;
        _mapView.scrollEnabled = NO;
    }
    return _mapView;
}

- (UIImageView *) iconView{
    if (!_iconView){
        _iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"buddy_header_icon_newfriend"]];
    }
    return _iconView;
}

- (UILabel *) nameLabel{
    if (!_nameLabel){
        _nameLabel = [[UILabel alloc] init];
        [_nameLabel setFont:YHTableviewCellTitleFont];
    }
    return _nameLabel;
}

- (UILabel *) dateLabel{
    if (!_dateLabel){
        _dateLabel = [[UILabel alloc] init];
        [_dateLabel setTextColor:[UIColor colorWithRed:139 / 255.0 green:139 / 255.0 blue:139 / 255.0 alpha:1]];
        [_dateLabel setFont:YHTableviewCellDateFont];
    }
    return _dateLabel;
}

- (UILabel *) detailLabel{
    if (!_detailLabel){
        _detailLabel = [[UILabel alloc] init];
        [_detailLabel setFont:YHTableviewCellTitleFont];
        _detailLabel.numberOfLines = 0;
    }
    return _detailLabel;
}

- (UIButton *) locationButton{
    if (!_locationButton){
        _locationButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _locationButton.titleLabel.font = YHLocationMsgFont;
        [_locationButton setTitleColor:[UIColor colorWithRed:94 / 255.0 green:155 / 255.0 blue:235 / 255.0 alpha:1] forState:UIControlStateNormal];
        [_locationButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        [_locationButton addTarget:self action:@selector(onclick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _locationButton;
}
- (UIImageView *) locationView{
    if (!_locationView){
        _locationView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"residence"]];
    }
    return _locationView;
}

- (void) setMessage:(YHMessage *)message{
    _message = message;
    [self.nameLabel setText:_message.visitor_id];
    [self.dateLabel setText:[self dateUtil:_message.message_date]];
    [self.detailLabel setText:_message.message_content];
    
}

- (void) layoutSubviews{
    [super layoutSubviews];
    
    CGFloat width = 50;
    CGFloat height = width;
    CGFloat x = YHMessageDetailMarginX;
    CGFloat y = 10;
    
    self.iconView.frame = CGRectMake(x, y, width, height);
    
    x = CGRectGetMaxX(self.iconView.frame) + 10;
    CGSize size = [self.nameLabel.text maxSize:CGSizeMake(MAXFLOAT, 20) textFont:YHTableviewCellTitleFont];
    self.nameLabel.frame = CGRectMake(x, y, size.width, size.height);
    
    y = CGRectGetMaxY(self.nameLabel.frame) + 5;
    size = [self.dateLabel.text maxSize:CGSizeMake(MAXFLOAT, 20) textFont:YHTableviewCellDateFont];
    self.dateLabel.frame = CGRectMake(x, y, size.width, size.height);
    
    x = self.iconView.frame.origin.x;
    y = CGRectGetMaxY(self.iconView.frame) + 10;
    CGFloat maxWidth = [UIScreen mainScreen].bounds.size.width - 2 * YHMessageDetailMarginX;
    size = [self.detailLabel.text maxSize:CGSizeMake(maxWidth, MAXFLOAT) textFont:YHTableviewCellTitleFont];
    self.detailLabel.frame = CGRectMake(x, y, size.width, size.height);
    
    y = CGRectGetMaxY(self.detailLabel.frame) + 30;
    self.locationView.frame = CGRectMake(x, y, 20, 20);
    
    x = CGRectGetMaxX(self.locationView.frame) + 5;
    
    NSString *latitude = [NSString stringWithFormat:@"%@", self.message.message_latitude];
    NSString *longitude = [NSString stringWithFormat:@"%@", self.message.message_longitude];
    if (![latitude isEqualToString:@"0"] && ![longitude isEqualToString:@"0"]){
        CLLocation *loc = [[CLLocation alloc] initWithLatitude:[latitude floatValue] longitude:[longitude floatValue]];
        self.location = loc;
        CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
        [geoCoder reverseGeocodeLocation:self.location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            if (placemarks.count != 0){
                CLPlacemark *placeMark = [placemarks lastObject];
                NSDictionary *dic = [NSDictionary dictionaryWithDictionary:placeMark.addressDictionary];
                NSString *str = [NSString stringWithFormat:@"%@%@%@%@%@", dic[@"Country"],dic[@"State"],dic[@"City"],dic[@"SubLocality"],dic[@"Street"]];
                [self.locationButton setTitle:str forState:UIControlStateNormal];
                CGSize size = [str maxSize:CGSizeMake(200, MAXFLOAT) textFont:YHLocationMsgFont];
                CGFloat temp = (20 - size.height) / 2.0;
                self.locationButton.frame = CGRectMake(x, y + temp, size.width, size.height);
                
                //======================================mapView===================================================
                CGFloat x1 = YHMessageDetailMarginX;
                CGFloat y1 = CGRectGetMaxY(self.locationButton.frame) + 10;
                CGFloat width1 = [UIScreen mainScreen].bounds.size.width - 2 * x1;
                CGFloat height1 = 130;
                self.mapView.frame = CGRectMake(x1, y1, width1, height1);
                CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(self.location.coordinate.latitude + 0.01, self.location.coordinate.longitude);
                MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, 3000, 3000);
                [self.mapView setRegion:region];
                YHMessageAnnotation *annotation = [[YHMessageAnnotation alloc] initWithSubtitle:str andCoordinate:self.location.coordinate];
                [self.mapView addAnnotation:annotation];
                self.mapView.selectedAnnotations = @[annotation];
                
                //======================================mapView===================================================
            }
        }];
    }else{
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}$"];
        if ([predicate evaluateWithObject:self.message.visitor_id]){
            [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
            [YHNetworkingUtil sendHTTPGETRequestWithURL:[NSString stringWithFormat:@"%@%@", @"http://freegeoip.net/json/", self.message.visitor_id] parameters:nil success:^(id responseObj) {
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                NSString *str = [NSString stringWithFormat:@"%@ %@ %@",responseObj[@"city"], responseObj[@"region_name"],responseObj[@"country_name"]];
                [self.locationButton setTitle:str forState:UIControlStateNormal];
                CGSize size = [self.locationButton.titleLabel.text maxSize:CGSizeMake(200, MAXFLOAT) textFont:YHLocationMsgFont];
                CGFloat temp = (20 - size.height) / 2.0;
                self.locationButton.frame = CGRectMake(x, y + temp, size.width, size.height);
                
                //======================================mapView===================================================
                CGFloat x1 = YHMessageDetailMarginX;
                CGFloat y1 = CGRectGetMaxY(self.locationButton.frame) + 10;
                CGFloat width1 = [UIScreen mainScreen].bounds.size.width - 2 * x1;
                CGFloat height1 = 130;
                self.mapView.frame = CGRectMake(x1, y1, width1, height1);
                NSString *latitude = responseObj[@"latitude"];
                NSString *longitude = responseObj[@"longitude"];
                CLLocationCoordinate2D coordinate1 = CLLocationCoordinate2DMake([latitude floatValue] + 0.01, [longitude floatValue]);
                CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake([latitude floatValue], [longitude floatValue]);
                MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate1, 3000, 3000);
                [self.mapView setRegion:region];
                YHMessageAnnotation *annotation = [[YHMessageAnnotation alloc] initWithSubtitle:str andCoordinate:coordinate];
                [self.mapView addAnnotation:annotation];
                self.mapView.selectedAnnotations = @[annotation];
                //======================================mapView===================================================
                
            } networkError:^ void (AFNetworkReachabilityStatus status){
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            }failure:^ void (NSError *error){
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            }];
        }else{
            [self.locationButton setTitle:@"未知地域" forState:UIControlStateNormal];
            size = [self.locationButton.titleLabel.text maxSize:CGSizeMake(200, MAXFLOAT) textFont:YHLocationMsgFont];
            CGFloat temp = (20 - size.height) / 2.0;
            self.locationButton.frame = CGRectMake(x, y + temp, size.width, size.height);
        }
    }
}

- (instancetype) initWithMessage:(YHMessage *)message{
    if (self = [super init]){
        self.message = message;
        [self addSubview:self.iconView];
        [self addSubview:self.nameLabel];
        [self addSubview: self.dateLabel];
        [self addSubview:self.detailLabel];
        [self addSubview:self.locationButton];
        [self addSubview: self.locationView];
        [self addSubview:self.mapView];
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    
    CGFloat y = CGRectGetMaxY(self.detailLabel.frame) + 20;
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGFloat x = 15;
    CGContextMoveToPoint(context, x, y);
    CGContextAddLineToPoint(context, [UIScreen mainScreen].bounds.size.width - x, y);
    
    [[UIColor colorWithRed:236 / 255.0 green:236 / 255.0 blue:236 / 255.0 alpha:1] setStroke];
    CGContextSetLineWidth(context, 1);
    CGContextStrokePath(context);
    
    
}

- (NSString *) dateUtil:(NSDate *) date{
    NSDate *today = [NSDate date];
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSDateComponents *destCom = [calender components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];
    NSDateComponents *curCom = [calender components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:today];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    if (destCom.year < curCom.year){
        [format setDateFormat:@"yyyy年MM月dd日 HH:mm:ss"];
    }else if (destCom.month < curCom.month){
        [format setDateFormat:@"MM月dd日 HH:mm"];
    }else{
        [format setDateFormat:@"HH:mm"];
        if(destCom.day < curCom.day){
            if (curCom.day - destCom.day == 1){
                return [NSString stringWithFormat:@"昨天 %@", [format stringFromDate:date]];
            }else{
                [format setDateFormat:@"MM月dd日 HH:mm"];
            }
        }else{
            return [NSString stringWithFormat:@"今天 %@", [format stringFromDate:date]];
        }
    }
    return [format stringFromDate:date];
}

- (void) onclick:(UIButton *) button{
    if ([self.delgate respondsToSelector:@selector(YHDetailView:didClickButton:)]){
        [self.delgate YHDetailView:self didClickButton:button];
    }
}


@end
