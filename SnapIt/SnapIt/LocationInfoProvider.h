//
//  LocationInfoProvider.h
//  SnapIt
//
//  Created by fpmi on 24.05.16.
//  Copyright (c) 2016 Alex Zhidkov. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreLocation;
@interface LocationInfoProvider : NSObject<CLLocationManagerDelegate>
-(double) getLatitude;
-(double) getLongitude;
@end
