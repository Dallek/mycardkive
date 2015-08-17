//
//  ViewController.m
//  CardKive
//
//  Created by Mini on 8/16/15.
//  Copyright (c) 2015 99Ideas. All rights reserved.
//

#import "ViewController.h"
#import "global.h"

@interface ViewController ()

@end
global * myVar; // object of the global class
@implementation ViewController
@synthesize checkBoxButton, loginUserName, loginPassword;

- (void)viewDidLoad {
    [super viewDidLoad];
    checked = NO;
    
    myVar = [global sharedSingleton];//initialize
    
    if (userName != NULL) {
        loginUserName.text = userName;
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)unwindToThisViewController:(UIStoryboardSegue *)unwindSegue
{
}

//check box
- (IBAction)checkButton:(id)sender {
    if (!checked) {
        checkBoxButton.image = [UIImage imageNamed:@"checkbox.png"];
        checked = YES;
    }else if (checked)
    {
        checkBoxButton.image = [UIImage imageNamed:@"checkbox_unchecked.png"];
        checked = NO;
    }
}


- (IBAction)forgotInfo:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Information" message:@"\nYour password has been reset. \n Check your email for a temporary password." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    
    [alert show];
}
- (IBAction)loginButton:(id)sender {
    if (![loginPassword hasText] || ![loginUserName hasText])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"\nEnter your User Name and Password, or Register to create a User Name and Password!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        
        [alert show];
        
    }
}

@end


