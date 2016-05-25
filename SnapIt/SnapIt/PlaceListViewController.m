//
//  PlaceListViewController.m
//  SnapIt
//
//  Created by Admin on 20.05.16.
//  Copyright © 2016 Alex Zhidkov. All rights reserved.
//

#import "PlaceListViewController.h"

@interface PlaceListViewController () {
    NSArray *places;
    AppDelegate *app;
}
@property (strong, nonatomic) IBOutlet UITableView *tableResult;

@end

@implementation PlaceListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    places = [app getPlacesSortByDistance];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (IBAction)sortValueChanged:(UISegmentedControl *)sender {
    if ([sender selectedSegmentIndex] == 0) {
        places = [app getPlacesSortByDistance:places];
    } else {
        places = [app getPlacesSortByAveregeRating:places];
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
    static NSString *CellIdentifier = @"PlaceTableViewCell";
    PlaceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PlaceTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    Place *place = (Place *)[places objectAtIndex:indexPath.row];

    cell.nameLabel.text = place.name;
    cell.detailLabel.text = [NSString stringWithFormat:@"Rating: %.1f", [place.rating doubleValue]];
    if([place.pictures count] > 0) {
        cell.photoImageView.image = [UIImage imageWithData:((Picture *)[place.pictures anyObject]).image];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 105;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self searchForPlaceWithName:[searchBar text]];
    
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    [self searchForPlaceWithName:[searchBar text]];
}
- (void)searchForPlaceWithName:(NSString *)name {
    if([name length] <= 0) {
        places = [app getPlacesSortByDistance];
        [_tableResult reloadData];
        return;
    }
    places = [app getPlaceByName:name];
    /*NSMutableArray *buf = [[NSMutableArray alloc] init];
    for(id ob in places) {
        Place *place = (Place *)ob;
        if([place.name containsString:name]) {
            [buf addObject:place];
        }
    }
    places = [NSArray arrayWithArray:buf];*/
    [_tableResult reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath) {
        [app setCurrentPlace:places[indexPath.row]];
        [self performSegueWithIdentifier:@"listToCard" sender:self];
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
