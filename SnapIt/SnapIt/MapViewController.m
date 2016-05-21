//
//  MapViewController.m
//  SnapIt
//
//  Created by Admin on 21.05.16.
//  Copyright © 2016 Alex Zhidkov. All rights reserved.
//

#import "MapViewController.h"
#define MakeLocation(lat,lon) [[CLLocation alloc]initWithLatitude: lat longitude: lon]

@interface MapViewController () {
    AppDelegate *app;
}
@property (weak, nonatomic) IBOutlet MKMapView *map;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSArray *places = [app getAllPlaces];
     
     NSMutableArray* locations = [NSMutableArray array];
     
     [places enumerateObjectsUsingBlock:^(Place *obj, NSUInteger idx, BOOL*stop)
     {
     [locations addObject:MakeLocation([obj.latitude doubleValue], [obj.longitude doubleValue])];
     }];
     
     for (int i=0; i<[locations count]; i++) {
     MKPointAnnotation* annotation= [MKPointAnnotation new];
     annotation.coordinate= [locations[i] coordinate];
     [_map addAnnotation: annotation];
     }
/*
    
    NSArray* locations = [[NSArray alloc] initWithObjects: MakeLocation(53.908572, 27.574929), MakeLocation(53.895157, 27.545816), nil];
    
    for (int i=0; i<[locations count]; i++) {
        MKPointAnnotation* annotation= [MKPointAnnotation new];
        annotation.coordinate= [locations[i] coordinate];
        [_map addAnnotation: annotation];
    }*/
}

@end