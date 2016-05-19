//
//  Picture.h
//  SnapIt
//
//  Created by fpmi on 19.05.16.
//  Copyright (c) 2016 Alex Zhidkov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Place;

@interface Picture : NSManagedObject

@property (nonatomic, retain) NSData * image;
@property (nonatomic, retain) Place *place;

@end
