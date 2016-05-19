//
//  User.h
//  SnapIt
//
//  Created by fpmi on 19.05.16.
//  Copyright (c) 2016 Alex Zhidkov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface User : NSManagedObject

@property (nonatomic, retain) NSString * login;
@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * fbpassword;
@property (nonatomic, retain) NSSet *ratings;
@end

@interface User (CoreDataGeneratedAccessors)

- (void)addRatingsObject:(NSManagedObject *)value;
- (void)removeRatingsObject:(NSManagedObject *)value;
- (void)addRatings:(NSSet *)values;
- (void)removeRatings:(NSSet *)values;

@end
