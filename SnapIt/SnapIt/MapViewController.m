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

-(double) getDistance: (double) latA: (double) lonA: (double) latB: (double) lonB {
    double distance = sqrt((latA - latB)*(latA - latB) + (lonA - lonB)*(lonA-lonB));
    return distance;
}

- (IBAction)handleLongPressGesture:(id)sender {
    CGPoint point =[sender locationInView: self.map];
    CLLocationCoordinate2D coord = [self.map convertPoint:point toCoordinateFromView:self.map];
    CLLocation *loc = [[CLLocation alloc] initWithLatitude:coord.latitude longitude: coord.longitude];
    Place *nearest;
    CLLocationDistance minDist = 10000000;
    for(id obj in places) {
        Place *place = (Place *)obj;
        CLLocation *current = [[CLLocation alloc] initWithLatitude:[place.latitude doubleValue] longitude:[place.longitude doubleValue]];
        CLLocationDistance dist = [loc distanceFromLocation:current];
        if(dist < minDist) {
             minDist = dist;
             nearest = obj;
        }
    }
    [app setCurrentPlace:nearest];
    [self performSegueWithIdentifier:@"mapToPlaceCard" sender:self];
    
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