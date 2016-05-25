//
//  AppDelegate.m
//  SnapIt
//
//  Created by Admin on 19.05.16.
//  Copyright © 2016 Alex Zhidkov. All rights reserved.
//

#import "AppDelegate.h"
#import "User.h"
#import "Place.h"
#import "Rating.h"
#import "Picture.h"
#import "SortingSupport.h"
#import "LocationInfoProvider.h"
@interface AppDelegate () {
    User *currentUser;
    Place *currentPlace;
}

@end

@implementation AppDelegate
//+
-(void) setCurrentPlace:(Place *)place
{
    currentPlace = place;
}
-(Place *) getCurrentPlace
{
    return currentPlace;
}

//get user+
-(BOOL)getUserByLogin:(NSString*) login andPassword: (NSString*) password
{
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"(login == %@ && password == %@)", login,password]];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"User" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    NSError* error;
    NSArray *fetchedRecords = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if([fetchedRecords count] == 0)
    {
        return NO;
    }
    else
    {
        currentUser = fetchedRecords[0];
        return YES;
    }
    
}

//add user or false if noy unique+
-(BOOL) addUserByLogin:(NSString*) login andPassword: (NSString*) password andEmail: (NSString*) email andFbPassword:(NSString*)fbpassword
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"(login == %@)", login]];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"User" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    NSError* error;
    NSArray *fetchedRecords = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if([fetchedRecords count] != 0)
    {
        return false;
    }
    
    User * newUser = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:self.managedObjectContext];
    newUser.login = login;
    newUser.password = password;
    newUser.email = email;
    newUser.fbpassword = fbpassword;
    [self saveContext];
    return true;
}
//+
-(void) addPlaceByLocation: (NSString*) location andLatitude: (double) latitude andLongitude:(double) longitude andName:(NSString *)name
{
    Place * newPlace = [NSEntityDescription insertNewObjectForEntityForName:@"Place" inManagedObjectContext:self.managedObjectContext];
    newPlace.latitude = [NSNumber numberWithDouble: latitude];
    newPlace.longitude = [NSNumber numberWithDouble: longitude];
    newPlace.location = location;
    newPlace.name = name;
    [self saveContext];
    
}
//++
-(void) addPhoto: (NSData*) photo ByPlace: (Place*) place
{
    Picture * newPicture = [NSEntityDescription insertNewObjectForEntityForName:@"Picture" inManagedObjectContext:self.managedObjectContext];
    newPicture.image = photo;
    [self saveContext];
    [place addPicturesObject:newPicture];
    [self saveContext];
}
//++
-(void) addRating: (int) rating ByPlace: (Place*) place
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"(place == %@ && user == %@)", place, currentUser]];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Rating" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    NSError* error;
    NSArray *marks = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if([marks count]!=0)
    {
        NSLog(@"+");
        
        double oldAvRaring = [place rating].doubleValue;
        double count = [[place ratings] count];
        double oldRating = [marks[0] rating].doubleValue;
        double newAvRating = oldAvRaring-oldRating/count+((double)rating)/count;
        [marks[0] setValue: [NSNumber numberWithInt: rating] forKey: @"rating"];
        [place setValue:[NSNumber numberWithDouble: newAvRating] forKey:@"rating"];
        [self saveContext];
        return;
    }
    double oldAvRaring = [place rating].doubleValue;
    double oldCount = [[place ratings] count];
    double newAvRating = oldAvRaring*oldCount/(oldCount+1)+rating/(oldCount+1);
    [place setValue:[NSNumber numberWithDouble: newAvRating] forKey:@"rating"];
    Rating * newRating = [NSEntityDescription insertNewObjectForEntityForName:@"Rating" inManagedObjectContext:self.managedObjectContext];
    newRating.rating = [NSNumber numberWithInt: rating];
    [currentUser addRatingsObject:newRating];
    [place addRatingsObject:newRating];
    [newRating setValue: place forKey:@"place"];
    [newRating setValue: currentUser forKey:@"user"];
    
    [self saveContext];
}
//++
-(NSArray*)getAllPlaces
{
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Place" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    NSError* error;
    NSArray *fetchedRecords = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    return fetchedRecords;
}
-(NSArray*) getPlaceByName: (NSString*) name
{
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Place" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"(name CONTAINS[c] %@)", name]];
    [fetchRequest setEntity:entity];
    NSError* error;
    NSArray *fetchedRecords = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    return fetchedRecords;
    
}
-(NSArray*) getPlaceByUserByName: (NSString*) name
{
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Place" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"(name CONTAINS[c] %@) && (ANY ratings.user == %@)", name, currentUser]];
    [fetchRequest setEntity:entity];
    NSError* error;
    NSArray *fetchedRecords = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    return fetchedRecords;
    
}
//места оцененные пользователем для карты++
-(NSArray*)getPlacesMarkedByUser
{
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"(ANY ratings.user == %@)", currentUser]];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Place" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    NSError* error;
    NSArray *fetchedRecords = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    return fetchedRecords;
}
//средний рейтинг места по всем оценкам
-(double) getAveregeRatingByPlace: (Place* ) place
{
    return [place rating].doubleValue;
}
//рейтинг конкретного места от текущего пользователя
-(int)getRatingByUserOfPlace:(Place* ) place
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    request.entity = [NSEntityDescription entityForName:@"Rating"
                                 inManagedObjectContext:self.managedObjectContext];
    [request setPredicate:[NSPredicate predicateWithFormat:@"(place == %@ && user==%@)", place, currentUser]];
    NSError* error;
    NSArray *fetchedRecords = [self.managedObjectContext executeFetchRequest:request error:&error];
    if(fetchedRecords.count==0)
        return -1;
    else
    {
        Rating* rating =  fetchedRecords[0];
        return  rating.rating.intValue;
    }
}
//экран plase List sort by distance
-(NSArray*)getPlacesSortByAveregeRating
{
    NSArray *fetchedRecords = [self getAllPlaces];
    return [SortingSupport sortPlacesByAveregeRating:fetchedRecords];
}
-(NSArray*)getPlacesSortByAveregeRating:(NSArray* ) places
{
    return [SortingSupport sortPlacesByAveregeRating:places];
}
-(NSArray*)getPlacesMarkedByUserSortByRating
{
    NSArray *fetchedRecords = [self getPlacesMarkedByUser];
    return [SortingSupport sortPlacesByRatingMarkedByUser:fetchedRecords];
}
-(NSArray*)getPlacesMarkedByUserSortByRating:(NSArray*) places
{
    return [SortingSupport sortPlacesByRatingMarkedByUser:places];
}
-(NSArray*)getPlacesSortByDistance
{
    NSArray *fetchedRecords = [self getAllPlaces];
    LocationInfoProvider *location = [ [LocationInfoProvider alloc] init];
    double latitude = location.getLatitude;
    double longitude = location.getLongitude;
    return [SortingSupport sortPlacesByDistance:fetchedRecords byLatitude: latitude andLongitude:longitude];
}
-(NSArray*)getPlacesSortByDistance:(NSArray*)places
{
    LocationInfoProvider *location = [ [LocationInfoProvider alloc] init];
    double latitude = location.getLatitude;
    double longitude = location.getLongitude;
    return [SortingSupport sortPlacesByDistance:places byLatitude: latitude andLongitude:longitude];
}
-(NSArray*)getPlacesMarkedByUserSortByDistance
{
    NSArray *fetchedRecords = [self getPlacesMarkedByUser];
    LocationInfoProvider *location = [ [LocationInfoProvider alloc] init];
    double latitude = location.getLatitude;
    double longitude = location.getLongitude;
    return [SortingSupport sortPlacesByDistance:fetchedRecords byLatitude: latitude andLongitude:longitude];
}
-(NSArray*)getNearestPlacesByRadius: (double) radius
{
    NSArray *fetchedRecords = [self getPlacesMarkedByUser];
    LocationInfoProvider *location = [ [LocationInfoProvider alloc] init];
    double latitude = location.getLatitude;
    double longitude = location.getLongitude;
    return [SortingSupport choosePlacesByDistance:fetchedRecords byLatitude: latitude andLongitude:longitude andRadius: radius];
}

//
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"HasLaunchedOnce"])
    {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"HasLaunchedOnce"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self addUserByLogin:@"login" andPassword:@"password" andEmail:@"maria-cco@mail.ru" andFbPassword:@""];
        [self addPlaceByLocation:@"Minsk" andLatitude:53.908572 andLongitude:27.574929 andName:@"The Victory Square"];
        [self addPlaceByLocation:@"Minsk" andLatitude:53.895157 andLongitude:27.545816 andName:@"The Independence Square"];
    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "alexZhidkov.SnapIt" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"SnapIt" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"SnapIt.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end