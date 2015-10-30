//
//  cameraViewController.h
//  CardKive
//
//  Created by Mini on 9/5/15.
//  Copyright (c) 2015 99Ideas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <ImageIO/CGImageProperties.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface cameraViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    IBOutlet UIView *frameForCapture;
    IBOutlet UIImageView *frontCardView;
    IBOutlet UIImageView *insideCardView;
}

- (IBAction)takeFrontPhoto:(id)sender;
- (IBAction)takeInsidePhoto:(id)sender;
- (IBAction)createCard:(id)sender;

@end
