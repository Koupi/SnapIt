//
//  Place.h
//  SnapIt
//
//  Created by fpmi on 19.05.16.
//  Copyright (c) 2016 Alex Zhidkov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Place : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * location;
@property (nonatomic, retain) NSNumber * rating;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSSet *pictures;
@property (nonatomic, retain) NSSet *ratings;
@end

@interface Place (CoreDataGeneratedAccessors)

- (void)addPicturesObject:(NSManagedObject *)value;
- (void)removePicturesObject:(NSManagedObject *)value;
- (void)addPictures:(NSSet *)values;
- (void)removePictures:(NSSet *)values;

- (void)addRatingsObject:(NSManagedObject *)value;
- (void)removeRatingsObject:(NSManagedObject *)value;
- (void)addRatings:(NSSet *)values;
- (void)removeRatings:(NSSet *)values;

@end
