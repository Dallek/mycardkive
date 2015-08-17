//
//  ViewController.h
//  CardKive
//
//  Created by Mini on 8/16/15.
//  Copyright (c) 2015 99Ideas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController{
    BOOL checked;
}
//Toggle check box
- (IBAction)checkButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *checkBoxButton;

//Forgot User or Password
- (IBAction)forgotInfo:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *loginUserName;
@property (weak, nonatomic) IBOutlet UITextField *loginPassword;

//login
- (IBAction)loginButton:(id)sender;

@end

