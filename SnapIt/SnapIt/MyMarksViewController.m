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
    LocationInfoProvider *loc;
}
@property (strong, nonatomic) IBOutlet UITableView *tableResult;

@end

@implementation MyMarksViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    loc = [[LocationInfoProvider alloc] init];
    places = [app getPlacesMarkedByUser];
    [SortingSupport sortPlacesByDistance:places byLatitude:[loc getLatitude] andLongitude:[loc getLongitude]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)sortValueChanged:(UISegmentedControl *)sender {
    if ([sender selectedSegmentIndex] == 0) {
        [SortingSupport sortPlacesByDistance:places byLatitude:[loc getLatitude] andLongitude:[loc getLongitude]];
    } else {
        [SortingSupport sortPlacesByRatingMarkedByUser:places];
    }
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
    if([place.pictures count] > 0) {
        //cell.imageView.image = [place.pictures anyObject];
    }
    return cell;
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self searchForPlaceWithName:[searchBar text]];
    
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    [self searchForPlaceWithName:[searchBar text]];
}
- (void)searchForPlaceWithName:(NSString *)name {
    if([name length] <= 0) {
        places = [app getPlacesMarkedByUser];
        [SortingSupport sortPlacesByDistance:places byLatitude:[loc getLatitude] andLongitude:[loc getLongitude]];
        [_tableResult reloadData];
        return;
    }
    places = [app getPlacesMarkedByUser];
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
