//
//  SortingSupport.h
//  SnapIt
//
//  Created by fpmi on 24.05.16.
//  Copyright (c) 2016 Alex Zhidkov. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <Foundation/Foundation.h>
#import "Place.h"
@interface SortingSupport : NSObject
+(NSArray*)sortPlacesByAveregeRating: (NSArray*) places;
+(NSArray*)sortPlacesByRatingMarkedByUser:(NSArray*) places;
+(double)getDistanceQWOfPlace:(Place* ) place byLatitude: (double)latitude andLongitude:(double) longitude;
+(NSArray*)choosePlacesByDistance:(NSArray*) places byLatitude: (double)latitude andLongitude:(double) longitude andRadius: (double) radius;
+(NSArray*)sortPlacesByDistance:(NSArray*) places byLatitude: (double)latitude andLongitude:(double) longitude;
@end
