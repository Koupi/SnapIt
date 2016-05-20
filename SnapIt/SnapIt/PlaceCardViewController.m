//
//  PlaceCardViewController.m
//  SnapIt
//
//  Created by Admin on 20.05.16.
//  Copyright © 2016 Alex Zhidkov. All rights reserved.
//

#import "PlaceCardViewController.h"

@interface PlaceCardViewController () {
    AppDelegate *app;
    Place *place;
}
@property (strong, nonatomic) IBOutlet UILabel *lblName;
@property (strong, nonatomic) IBOutlet UILabel *lblCoords;
@property (strong, nonatomic) IBOutlet UILabel *lblRating;
@property (strong, nonatomic) IBOutlet UILabel *lblLocation;

@end

@implementation PlaceCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    place = [app getCurrentPlace];
    [_lblName setText:place.name];
    [_lblLocation setText:place.location];
    [_lblRating setText:[NSString stringWithFormat:@"%@", place.rating]];
    [_lblCoords setText:[NSString stringWithFormat:@"%@; %@", place.latitude, place.longitude]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
