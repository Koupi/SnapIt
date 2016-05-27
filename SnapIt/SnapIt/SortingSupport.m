//
//  SortingSupport.m
//  SnapIt
//
//  Created by fpmi on 24.05.16.
//  Copyright (c) 2016 Alex Zhidkov. All rights reserved.
//

#import "SortingSupport.h"

#import "SortingSupport.h"
#import "AppDelegate.h"
#import "math.h"
@implementation SortingSupport
+(NSComparisonResult)compareDoubleOne:(double) first withDoubleTwo: (double) second
{
    if (first> second)
    {
        return (NSComparisonResult)NSOrderedAscending;
    }
    if (first < second)
    {
        return (NSComparisonResult)NSOrderedDescending;
    }
    return (NSComparisonResult)NSOrderedSame;
}

+(NSArray*)sortPlacesByAveregeRating: (NSArray*) places
{
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSArray* sortedRecords = [[NSMutableArray arrayWithArray:places]  sortedArrayUsingComparator: ^(id obj1, id obj2)
                              {
                                  double mark1 = [app getAveregeRatingByPlace:obj1];
                                  double mark2 = [app getAveregeRatingByPlace:obj2];
                                  return [SortingSupport compareDoubleOne: mark1 withDoubleTwo:mark2];
                              }];
    
    return sortedRecords;
}
+(NSArray*)sortPlacesByRatingMarkedByUser:(NSArray*) places
{
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSArray* sortedRecords = [[NSMutableArray arrayWithArray:places]  sortedArrayUsingComparator: ^(id obj1, id obj2)
                              {
                                  double mark1 = [app getRatingByUserOfPlace:obj1];
                                  double mark2 = [app getRatingByUserOfPlace:obj2];
                                  return [SortingSupport compareDoubleOne: mark1 withDoubleTwo:mark2];
                              }];
    
    return sortedRecords;
}
+(double)getDistanceQWOfPlace:(Place* ) place byLatitude: (double)latitude andLongitude:(double) longitude
{

    double distance = pow(place.latitude.doubleValue-latitude,2.0)+pow(place.longitude.doubleValue-longitude, 2.0);

    return distance;
}
+(NSArray*)sortPlacesByDistance:(NSArray*) places byLatitude: (double)latitude andLongitude:(double) longitude
{
    NSArray* sortedRecords = [[NSMutableArray arrayWithArray:places]  sortedArrayUsingComparator: ^(id obj1, id obj2)
                              {
                                  double distance1 = [SortingSupport getDistanceQWOfPlace:obj1 byLatitude:latitude andLongitude:longitude];
                                  double distance2 = [SortingSupport getDistanceQWOfPlace:obj2 byLatitude:latitude andLongitude:longitude];
                                  return [SortingSupport compareDoubleOne: distance2 withDoubleTwo:distance1];
                              }];
    
    return sortedRecords;
}
+(NSArray*)choosePlacesByDistance:(NSArray*) places byLatitude: (double)latitude andLongitude:(double) longitude andRadius: (double) radius
{
    NSMutableArray* choosenResults = [NSMutableArray array];
    [places enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL*stop)
     {
        /*NSLog(@" dist %f", [SortingSupport getDistanceQWOfPlace:obj byLatitude:latitude andLongitude:longitude]);*/
         if([SortingSupport getDistanceQWOfPlace:obj byLatitude:latitude andLongitude:longitude]<radius)
         {
             [choosenResults addObject:obj];
         }
     }];
    
    return choosenResults;
}

@end