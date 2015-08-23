//
//  UserInfoViewController.h
//  CardKive
//
//  Created by Mini on 8/23/15.
//  Copyright (c) 2015 99Ideas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserInfoViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *accountName;
@property (weak, nonatomic) IBOutlet UILabel *accountEmail;
@property (weak, nonatomic) IBOutlet UITextField *oldAccountPassword;
@property (weak, nonatomic) IBOutlet UITextField *updateAccountPW;
@property (weak, nonatomic) IBOutlet UITextField *updateAccountPWRetry;

- (IBAction)saveAccountInfo:(id)sender;

@end
