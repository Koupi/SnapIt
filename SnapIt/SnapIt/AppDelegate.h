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

-(BOOL) addUserByLogin:(NSString*) login andPassword: (NSString*) password andEmail: (NSString*) email andFbPassword:(NSString*)fbpassword;
-(BOOL)getUserByLogin:(NSString*) login andPassword: (NSString*) password;
-(void) addPlaceByLocation: (NSString*) location andLatitude: (int) latitude andLongitude:(int) longitude;
-(void) addPhoto: (NSData*) photo ByPlace: (Place*) place;
-(void) addRating: (int) rating ByPlace: (Place*) place andUser:(User*) user;
-(NSArray*)getAllPlaces;
-(NSArray*)getPlacesMarkedByUser:(User*) user;
-(NSArray*)getPlacesMarkedByUserSortByRating;

@end

