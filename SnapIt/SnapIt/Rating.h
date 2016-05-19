//
//  Rating.h
//  SnapIt
//
//  Created by fpmi on 19.05.16.
//  Copyright (c) 2016 Alex Zhidkov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Place, User;

@interface Rating : NSManagedObject

@property (nonatomic, retain) NSNumber * rating;
@property (nonatomic, retain) User *user;
@property (nonatomic, retain) Place *place;

@end
