//
//  Place+CoreDataProperties.h
//  SnapIt
//
//  Created by Admin on 21.05.16.
//  Copyright © 2016 Alex Zhidkov. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Place.h"

NS_ASSUME_NONNULL_BEGIN

@interface Place (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *latitude;
@property (nullable, nonatomic, retain) NSString *location;
@property (nullable, nonatomic, retain) NSNumber *longitude;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSNumber *rating;
@property (nullable, nonatomic, retain) NSSet<Picture *> *pictures;
@property (nullable, nonatomic, retain) NSSet<Rating *> *ratings;

@end

@interface Place (CoreDataGeneratedAccessors)

- (void)addPicturesObject:(Picture *)value;
- (void)removePicturesObject:(Picture *)value;
- (void)addPictures:(NSSet<Picture *> *)values;
- (void)removePictures:(NSSet<Picture *> *)values;

- (void)addRatingsObject:(Rating *)value;
- (void)removeRatingsObject:(Rating *)value;
- (void)addRatings:(NSSet<Rating *> *)values;
- (void)removeRatings:(NSSet<Rating *> *)values;

@end

NS_ASSUME_NONNULL_END
