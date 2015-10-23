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
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    // getting an NSString
    userName = [prefs stringForKey:@"cardKiveUser"];
    password = [prefs stringForKey:@"cardKiveUserPW"];
    eMail = [prefs stringForKey:@"cardKiveUserEMail"];
//    keepLogin = [prefs stringForKey:@"keepLoggedIn"];
  
    keepLogin = @"YES";
    
    if ([keepLogin isEqualToString:@"YES"]) {
    
        if (userName != NULL) {
            loginUserName.text = userName;
        }
    
        if (password != NULL) {
            loginPassword.text = password;
        }
        
        checkBoxButton.image = [UIImage imageNamed:@"checkbox.png"];
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
        keepLogin = @"YES";
    }else if (checked)
    {
        checkBoxButton.image = [UIImage imageNamed:@"checkbox_unchecked.png"];
        checked = NO;
        keepLogin = @"NO";
    }
}


- (IBAction)forgotInfo:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Information" message:@"\nYour password has been reset. \n Check your email for a temporary password." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    
    [alert show];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [loginPassword resignFirstResponder];
    [loginUserName resignFirstResponder];
}


- (IBAction)loginButton:(id)sender {
    if (![loginPassword hasText] || ![loginUserName hasText])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"\nEnter your User Name and Password, or Register to create a User Name and Password!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        
        [alert show];
        return;
    }
    
    
    if (userName == nil || password == nil || eMail == nil) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"\nEnter a valid User Name and Password, or Register to create a User Name and Password!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        
        [alert show];

        return;
    }
    
    userName = loginUserName.text;
    password = loginPassword.text;
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    [prefs setObject:userName forKey:@"cardKiveUser"];
    [prefs setObject:password forKey:@"cardKiveUserPW"];
    [prefs setObject:eMail forKey:@"cardKiveUserEMail"];
    [prefs setObject:keepLogin forKey:@"keepLoggedIn"];
    [prefs synchronize];
    
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"MenuViewController"];
    [self presentViewController:vc animated:YES completion:nil];
    
}

@end


