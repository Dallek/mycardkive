//
//  displayCardViewController.h
//  CardKive
//
//  Created by Owner on 9/10/15.
//  Copyright (c) 2015 99Ideas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface displayCardViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *cardImage;
@property (weak, nonatomic) IBOutlet UIImageView *innerCardImage;

- (IBAction)editImage:(id)sender;

@end
