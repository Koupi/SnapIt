//
//  MyMarksViewController.m
//  SnapIt
//
//  Created by Admin on 20.05.16.
//  Copyright © 2016 Alex Zhidkov. All rights reserved.
//

#import "MyMarksViewController.h"

@interface MyMarksViewController () {
    NSArray *places;
    AppDelegate *app;
}
@property (strong, nonatomic) IBOutlet UITableView *tableResult;

@end

@implementation MyMarksViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    places = [app getPlacesMarkedByUserSortByRating];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)sortValueChanged:(UISegmentedControl *)sender {
    if ([sender selectedSegmentIndex] == 0) {
        [self sortResultByDistance];
    } else {
        [self sortResultByRating];
    }
}

- (void)sortResultByRating {
    places = [places sortedArrayUsingComparator:^NSComparisonResult(id ob1, id ob2) {
        double r1 = [((Place *)ob1).rating doubleValue];
        double r2 = [((Place *)ob2).rating doubleValue];
        if(r1 > r2) {
            return NSOrderedAscending;
        }
        if(r1 < r2) {
            return NSOrderedDescending;
        }
        return NSOrderedSame;
    }];
    [_tableResult reloadData];
}
- (void)sortResultByDistance {
    places = [places sortedArrayUsingComparator:^NSComparisonResult(id ob1, id ob2) {
        /*double r1 = [((Place *)ob1).rating doubleValue];
         double r2 = [((Place *)ob2).rating doubleValue];
         if(r1 > r2) {
         return NSOrderedAscending;
         }
         if(r1 < r2) {
         return NSOrderedDescending;
         }*/
        return NSOrderedAscending;
    }];
    [_tableResult reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [places count];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:CellIdentifier];
    }
    Place *place = (Place *)[places objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@, rating:%@", place.name, place.rating];
    return cell;
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self searchForPlaceWithName:[searchBar text]];
    
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    [self searchForPlaceWithName:[searchBar text]];
}
- (void)searchForPlaceWithName:(NSString *)name {
    places = [app getPlacesMarkedByUserSortByRating];
    NSMutableArray *buf = [[NSMutableArray alloc] init];
    for(id ob in places) {
        Place *place = (Place *)ob;
        if([place.name containsString:name]) {
            [buf addObject:place];
        }
    }
    places = [NSArray arrayWithArray:buf];
    [_tableResult reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath) {
        //[app setSelectedBook:booksResult[indexPath.row]];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
