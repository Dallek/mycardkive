//
//  RegisterViewController.m
//  CardKive
//
//  Created by Mini on 8/16/15.
//  Copyright (c) 2015 99Ideas. All rights reserved.
//

#import "RegisterViewController.h"
#import "global.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController
@synthesize checkBoxButton, nameField, passwordField, emailField;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    checked = NO;
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"WELCOME!" message:@"\nYour memories are forever! \n CardKive helps them stay that way!" delegate:self cancelButtonTitle:@"Continue" otherButtonTitles: nil];
    
    [alert show];
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

- (IBAction)checkedButton:(id)sender {
    
    if (!checked) {
        checkBoxButton.image = [UIImage imageNamed:@"checkbox.png"];
        checked = YES;
    }else if (checked)
    {
        checkBoxButton.image = [UIImage imageNamed:@"checkbox_unchecked.png"];
        checked = NO;
    }
}

- (IBAction)createAccount:(id)sender {
    
    if ([nameField hasText] && [passwordField hasText]) {
        userName = nameField.text;
        password = passwordField.text;
    
        eMail = emailField.text;
        
        if (![emailField hasText] || [eMail rangeOfString:@"@"].location == NSNotFound) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Email" message:@"Please enter a valid email address." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:  nil];
            
            [alert show];
            
            return;
        }
        
    }else {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Registration Error" message:@"Please enter a valid Username and Password" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        
        [alert show];
        
        return;
    }
    
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Confirm Email" message:[NSString stringWithFormat:@"Email: %@", eMail] delegate:self cancelButtonTitle:@"Edit" otherButtonTitles: @"Ok", nil];
    
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        return;
    } else {
        
        NSString * storyboardName = @"Main";
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
        UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"MenuViewController"];
        [self presentViewController:vc animated:YES completion:nil];
        
    }
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    [prefs setObject:userName forKey:@"cardKiveUser"];
    
    [prefs setObject:password forKey:@"cardKiveUserPW"];
    [prefs setObject:eMail forKey:@"cardKiveUserEMail"];
    [prefs synchronize];

}

@end
