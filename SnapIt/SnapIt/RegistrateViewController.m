//
//  RegistrateViewController.m
//  SnapIt
//
//  Created by Admin on 20.05.16.
//  Copyright © 2016 Alex Zhidkov. All rights reserved.
//

#import "RegistrateViewController.h"

@interface RegistrateViewController () {
    AppDelegate *app;
}
@property (strong, nonatomic) IBOutlet UITextField *tfLogin;
@property (strong, nonatomic) IBOutlet UITextField *tfPassword;
@property (strong, nonatomic) IBOutlet UITextField *tfEmail;
@property (strong, nonatomic) IBOutlet UITextField *tfFbPassword;

@end

@implementation RegistrateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)createAccountButtonClicked:(id)sender {
    if([app addUserByLogin:[_tfLogin text] andPassword:[_tfPassword text] andEmail:[_tfEmail text] andFbPassword:[_tfFbPassword text]] && [app getUserByLogin:[_tfLogin text] andPassword:[_tfPassword text]])
    {
        [self performSegueWithIdentifier:@"goToMenuFromRegistrate" sender:self];
        
    }
    else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"User with this login already exists" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {}];
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
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
