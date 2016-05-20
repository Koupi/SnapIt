//
//  ViewController.m
//  SnapIt
//
//  Created by Admin on 19.05.16.
//  Copyright © 2016 Alex Zhidkov. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController () {
    AppDelegate *app;
}
@property (strong, nonatomic) IBOutlet UITextField *tfLogin;
@property (strong, nonatomic) IBOutlet UITextField *tfPassword;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)loginButtonClicked:(id)sender {
    if([app getUserByLogin:[_tfLogin text] andPassword:[_tfPassword text]])
    {
        [self performSegueWithIdentifier:@"goMenuViewController" sender:self];
        
    }
    else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Wrong login or password" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {}];
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

@end
