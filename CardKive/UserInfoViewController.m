//
//  UserInfoViewController.m
//  CardKive
//
//  Created by Mini on 8/23/15.
//  Copyright (c) 2015 99Ideas. All rights reserved.
//

#import "UserInfoViewController.h"
#import "global.h"

@interface UserInfoViewController ()

@end

@implementation UserInfoViewController
@synthesize accountEmail, accountName, oldAccountPassword, updateAccountPW, updateAccountPWRetry;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    accountName.text = userName;
    accountEmail.text = eMail;
    
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

- (IBAction)saveAccountInfo:(id)sender {
   
    if (oldAccountPassword.text != password) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Password!" message:@"Your account password does not match!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        return;
    }
    
    if (updateAccountPW.text != updateAccountPWRetry.text) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"New Password!" message:@"Please enter the same password." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        return;
    }
    
    password = updateAccountPW.text;
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    [prefs setObject:password forKey:@"cardKiveUserPW"];    [prefs synchronize];
    
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success!" message:@"Your account password has been updated!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}
@end
