//
//  RegisterViewController.h
//  CardKive
//
//  Created by Mini on 8/16/15.
//  Copyright (c) 2015 99Ideas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController{
    BOOL checked;
}

//Toggle check button
- (IBAction)checkedButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *checkBoxButton;

//create account
- (IBAction)createAccount:(id)sender;

//Text Fields
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;

@end
