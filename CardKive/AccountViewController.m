//
//  AccountViewController.m
//  CardKive
//
//  Created by Mini on 8/23/15.
//  Copyright (c) 2015 99Ideas. All rights reserved.
//

#import "AccountViewController.h"
#import "global.h"

#define TAG_Restore 1
#define TAG_Logout 2

@interface AccountViewController ()

@end

@implementation AccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
- (IBAction)unwindToAccountViewController:(UIStoryboardSegue *)unwindSegue
{
}

- (IBAction)editAccount:(id)sender {
    NSLog(@"userName = %@", userName);
    NSLog(@"\nemail = %@", eMail);
    NSLog(@"\npassword = %@", password);
    
}

- (IBAction)manageFilters:(id)sender {

}

- (IBAction)contactCardKive:(id)sender {
    // Email Subject
    NSString *emailTitle = @"Contact CardKive!";
    // Email Content
    NSString *messageBody = @"";
    // To address
    NSArray *toRecipents = [NSArray arrayWithObject:@"support@myCardKive.com"];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    [mc setMessageBody:messageBody isHTML:NO];
    [mc setToRecipients:toRecipents];
    
    // Present mail view controller on screen
    [self presentViewController:mc animated:YES completion:NULL];
    
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)reSync:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Restore Library" message:@"This will restore ALL images from our servers. \nYou will not lose any images UNLESS they are marked pending on your device." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles: @"Restore", nil];
    alert.tag = TAG_Restore;
    [alert show];
}

- (IBAction)logOut:(id)sender {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Log Out" message:@"Come back at any time to view your memories!  We'll keep them handy!" delegate:self cancelButtonTitle:@"Wait!" otherButtonTitles: @"Log Out", nil];
    alert.tag = TAG_Logout;
    [alert show];

}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        return;
    }
    
    if (alertView.tag == TAG_Logout) {
        
        userName = NULL;
        password = NULL;
        eMail = NULL;
        
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        
        [prefs setObject:userName forKey:@"cardKiveUser"];
        
        [prefs setObject:password forKey:@"cardKiveUserPW"];
        [prefs setObject:eMail forKey:@"cardKiveUserEMail"];
        [prefs synchronize];
        
        NSString * storyboardName = @"Main";
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
        UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        [self presentViewController:vc animated:YES completion:nil];
        
    }else if (alertView.tag == TAG_Restore)
    {
        
    }
}


- (IBAction)privacyPolicy:(id)sender {
    
    QLPreviewController *previewController=[[QLPreviewController alloc]init];
    previewController.delegate=self;
    previewController.dataSource=self;
    [self presentViewController:previewController animated:YES completion:nil];
    [previewController.navigationItem setRightBarButtonItem:nil];
    

}
#pragma mark - data source
//Data source methods
//– numberOfPreviewItemsInPreviewController:
//– previewController:previewItemAtIndex:
- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)controller
{
    return 1;
}


- (id <QLPreviewItem>)previewController:(QLPreviewController *)controller previewItemAtIndex:(NSInteger)index
{
    
    filenamesArray=[[NSArray alloc] initWithObjects:@"Policy.pdf", nil];
    
    NSString *path=[[NSBundle mainBundle] pathForResource:[filenamesArray objectAtIndex:currentPreviewIndex] ofType:nil];
    return [NSURL fileURLWithPath:path];
}

#pragma mark - delegate methods


- (BOOL)previewController:(QLPreviewController *)controller shouldOpenURL:(NSURL *)url forPreviewItem:(id <QLPreviewItem>)item
{
    return YES;
}

- (CGRect)previewController:(QLPreviewController *)controller frameForPreviewItem:(id <QLPreviewItem>)item inSourceView:(UIView **)view
{
    
    //Rectangle of the button which has been pressed by the user
    //Zoom in and out effect appears to happen from the button which is pressed.
    UIView *view1 = [self.view viewWithTag:currentPreviewIndex+1];
    return view1.frame;
}





@end
