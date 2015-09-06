//
//  cameraViewController.h
//  CardKive
//
//  Created by Mini on 9/5/15.
//  Copyright (c) 2015 99Ideas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface cameraViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    IBOutlet UIView *frameForCapture;
    IBOutlet UIImageView *imageView;
}

- (IBAction)takePhoto:(id)sender;

@end
