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
    NSArray *pictures;
    UIImage *lastImage;
    int lastMark;
}
@property (strong, nonatomic) IBOutlet UILabel *lblRating;
@property (strong, nonatomic) IBOutlet UILabel *lblLocation;
@property (strong, nonatomic) IBOutlet UILabel *lblMark;
@property (strong, nonatomic) IBOutlet UINavigationItem *navTitle;
@property (strong, nonatomic) IBOutlet UIStepper *stepperMark;
@property (strong, nonatomic) IBOutlet UITableView *photos;

@end

@implementation PlaceCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    place = [app getCurrentPlace];
    pictures = [place.pictures allObjects];
    [_lblLocation setText:place.location];
    [_lblRating setText:[NSString stringWithFormat:@"%.1f", [place.rating doubleValue]]];
    int mark = [app getRatingByUserOfPlace:place];
    if(mark >= 0) {
        [_lblMark setText:[NSString stringWithFormat:@"%d", mark]];
        [_stepperMark setValue:(double)mark];
    }
    else {
        [_lblMark setText:@"0"];
        [_stepperMark setValue:0];
    }
    [_navTitle setTitle:place.name];
    lastImage = nil;
    lastMark = -1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)ratePlace:(id)sender {
    [app addRating:(int)[_stepperMark value] ByPlace:place];
    lastMark = (int)[_stepperMark value];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"You've rated this place successfully." preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {}];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
    [_lblRating setText:[NSString stringWithFormat:@"%.1f", [place.rating doubleValue]]];
}
- (IBAction)markValueChanged:(id)sender {
    [_lblMark setText:[NSString stringWithFormat:@"%.0f",[_stepperMark value]]];
}
- (IBAction)addPhoto:(id)sender {
    UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
    pickerController.delegate = self;
    [self presentModalViewController:pickerController animated:YES];
}
- (void) imagePickerController:(UIImagePickerController *)picker
         didFinishPickingImage:(UIImage *)image
                   editingInfo:(NSDictionary *)editingInfo
{
    lastImage = image;
    NSData *img = UIImagePNGRepresentation(image);
    [app addPhoto:img ByPlace:place];
    [self dismissModalViewControllerAnimated:YES];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"You've added your photo to this place successfully." preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {}];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
    pictures = [place.pictures allObjects];
    [_photos reloadData];
}
- (IBAction)shareFb:(id)sender {
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
    {
        SLComposeViewController *tweet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        NSString *initialString = [NSString stringWithFormat:@"Hi from %@ (%@)!", place.name, place.location];
        if(lastMark != -1)
            initialString = [NSString stringWithFormat:@"%@\nI rated this place with mark: %d", initialString, lastMark];
        if(lastImage != nil) {
            [tweet addImage:lastImage];
            initialString = [NSString stringWithFormat:@"%@\nLook at the photo I've made!", initialString];
        }
        [tweet setInitialText:initialString];
        [tweet setCompletionHandler:^(SLComposeViewControllerResult result)
         {
             if (result == SLComposeViewControllerResultCancelled)
             {
                 NSLog(@"The user cancelled.");
             }
             else if (result == SLComposeViewControllerResultDone)
             {
                 NSLog(@"The user posted to Facebook");
             }
         }];
        [self presentViewController:tweet animated:YES completion:nil];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Facebook"
                                                        message:@"Facebook integration is not available.  A Facebook account must be set up on your device."
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [pictures count];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"PhotoTableViewCell";
    PhotoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PhotoTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    cell.photoImageView.image = [UIImage imageWithData:((Picture *)pictures[indexPath.row]).image];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 320;
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
