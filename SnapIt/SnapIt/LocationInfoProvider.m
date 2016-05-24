//
//  LocationInfoProvider.m
//  SnapIt
//
//  Created by fpmi on 24.05.16.
//  Copyright (c) 2016 Alex Zhidkov. All rights reserved.
//

#import "LocationInfoProvider.h"

@interface LocationInfoProvider()
@property (strong, nonatomic) CLLocationManager *locationManager;
@property double longitude;
@property double latitude;
@end

@implementation LocationInfoProvider
- (id)init
{
    self = [super init];
    if (self)
    {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            [self.locationManager requestWhenInUseAuthorization];
        }
    }
    return self;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = locations[[locations count] - 1];
    if (location != nil)
    {
        self.latitude = location.coordinate.latitude;
        self.longitude = location.coordinate.longitude;
        [self.locationManager stopUpdatingLocation];
    }
    
}

-(double) getLatitude
{
    [self.locationManager startUpdatingLocation];
    return [self latitude];
}

-(double) getLongitude
{
    [self.locationManager startUpdatingLocation];
    return [self longitude];
}
@end
