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
NSArray *places;
NSMutableArray* locations;

- (void)viewDidLoad {
    [super viewDidLoad];
     app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
     places = [app getAllPlaces];
     [self showPlaces:places];
    }

- (void) showPlaces: (NSArray *) places {
    [_map removeAnnotations:[_map annotations]];
    locations = [NSMutableArray array];
    [places enumerateObjectsUsingBlock:^(Place *obj, NSUInteger idx, BOOL*stop) {
        [locations addObject:MakeLocation([obj.latitude doubleValue], [obj.longitude doubleValue])];
    }];
    for (int i=0; i<[locations count]; i++) {
        MKPointAnnotation* annotation= [MKPointAnnotation new];
        annotation.coordinate= [locations[i] coordinate];
        [_map addAnnotation: annotation];
    }
}

- (IBAction)sortValueChanged:(id)sender {
    if([sender selectedSegmentIndex] == 0) {
        places = [app getAllPlaces];
        [self showPlaces:places];
    } else if ([sender selectedSegmentIndex] == 1) {
        places = [app getPlacesMarkedByUser];
        [self showPlaces:places];
    } else {
        places = [app getNearestPlacesByRadius:10000];
        [self showPlaces:places];
    }
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    places = [app getPlaceByName:[searchBar text]];
    [self showPlaces:places];
}
@end