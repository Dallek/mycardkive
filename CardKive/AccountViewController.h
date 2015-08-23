//
//  AccountViewController.h
//  CardKive
//
//  Created by Mini on 8/23/15.
//  Copyright (c) 2015 99Ideas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <QuickLook/QuickLook.h>

@interface AccountViewController : UIViewController <MFMailComposeViewControllerDelegate, QLPreviewControllerDataSource, QLPreviewControllerDelegate>
{
    NSArray *filenamesArray;
    int currentPreviewIndex;
    
}

- (IBAction)editAccount:(id)sender;
- (IBAction)manageFilters:(id)sender;
- (IBAction)contactCardKive:(id)sender;
- (IBAction)reSync:(id)sender;
- (IBAction)logOut:(id)sender;
- (IBAction)privacyPolicy:(id)sender;

@end
