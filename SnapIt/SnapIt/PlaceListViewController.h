//
//  PlaceListViewController.h
//  SnapIt
//
//  Created by Admin on 20.05.16.
//  Copyright © 2016 Alex Zhidkov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Place.h"
#import "SortingSupport.h"
#import "LocationInfoProvider.h"

@interface PlaceListViewController : UIViewController <UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate>

@end
