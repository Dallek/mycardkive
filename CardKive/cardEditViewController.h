//
//  cardEditViewController.h
//  CardKive
//
//  Created by Owner on 9/24/15.
//  Copyright © 2015 99Ideas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface cardEditViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITabBarDelegate, UIActionSheetDelegate, UIScrollViewDelegate>

{
    IBOutlet __weak UIScrollView *_scrollView;
    IBOutlet __weak UIImageView *_imageView;
}


@property (weak, nonatomic) IBOutlet UIImageView *_innerImageView;

@end
