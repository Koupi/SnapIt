//
//  AppDelegate.h
//  SnapIt
//
//  Created by Admin on 19.05.16.
//  Copyright © 2016 Alex Zhidkov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Place.h"
#import "User.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

-(void) setCurrentPlace:(Place *)place;
-(Place *) getCurrentPlace;

-(BOOL) addUserByLogin:(NSString*) login andPassword: (NSString*) password andEmail: (NSString*) email andFbPassword:(NSString*)fbpassword;
-(BOOL)getUserByLogin:(NSString*) login andPassword: (NSString*) password;

-(void) addPlaceByLocation: (NSString*) location andLatitude: (double) latitude andLongitude:(double) longitude;
-(void) addPlaceByLocation: (NSString*) location andLatitude: (double) latitude andLongitude:(double) longitude andName:(NSString *)name;
-(void) addPhoto: (NSData*) photo ByPlace: (Place*) place;
-(void) addRating: (int) rating ByPlace: (Place*) place;
-(NSArray*)getAllPlaces;
-(NSArray*)getPlacesMarkedByUser;
-(double) getAveregeRatingByPlace: (Place* ) place;
-(int)getRatingByUserOfPlace:(Place* ) place;
-(NSArray*)getPlacesSortByAveregeRating;
-(NSArray*)getPlacesMarkedByUserSortByRating;
-(NSArray*)getPlacesSortByDistance;
-(NSArray*)getPlacesMarkedByUserSortByDistance;
-(NSArray*)getNearestPlacesByRadius: (double) radius;
-(NSArray*) getPlaceByName: (NSString*) name;
-(NSArray*) getPlaceByUserByName: (NSString*) name;
-(NSArray*)getPlacesSortByAveregeRating:(NSArray* ) places;
-(NSArray*)getPlacesMarkedByUserSortByRating:(NSArray*) places;
-(NSArray*)getPlacesSortByDistance:(NSArray*)places;
@end


