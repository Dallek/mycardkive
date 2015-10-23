//
//  cardEditViewController.m
//  CardKive
//
//  Created by Owner on 9/24/15.
//  Copyright © 2015 99Ideas. All rights reserved.
//

#import "cardEditViewController.h"
#import "CLImageEditor.h"
#import "global.h"


@interface cardEditViewController ()
<CLImageEditorDelegate, CLImageEditorTransitionDelegate, CLImageEditorThemeDelegate>


@end

@implementation cardEditViewController
@synthesize _innerImageView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ((int)indexCell >= 10) {
            //Display Images
            ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
            [library assetForURL:[array objectAtIndex:(int)indexCell] resultBlock:^(ALAsset *asset) {
                _imageView.image = [UIImage imageWithCGImage:[[asset defaultRepresentation] fullResolutionImage]];
            } failureBlock:^(NSError *error) {
                NSLog(@"error : %@", error);
            }];
        
    }else{
        _imageView.image = [UIImage imageNamed:[array objectAtIndex:(int)indexCell]];
    }
    
    _imageView.hidden = NO;
    
    _innerImageView.image = [UIImage imageNamed: @"open.jpeg"];
    _innerImageView.hidden = YES;
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    
    // Setting the swipe direction.
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    
    // Adding the swipe gesture on image view
    [_imageView addGestureRecognizer:swipeLeft];
    [_innerImageView addGestureRecognizer:swipeRight];

    
    //Set a black theme rather than a white one
    /*
     [[CLImageEditorTheme theme] setBackgroundColor:[UIColor blackColor]];
     [[CLImageEditorTheme theme] setToolbarColor:[[UIColor blackColor] colorWithAlphaComponent:0.8]];
     [[CLImageEditorTheme theme] setToolbarTextColor:[UIColor whiteColor]];
     [[CLImageEditorTheme theme] setToolIconColor:@"white"];
     [[CLImageEditorTheme theme] setStatusBarStyle:UIStatusBarStyleLightContent];
     [[UINavigationBar appearance] setBarStyle:UIBarStyleBlack];
     [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
     */
    [self refreshImageView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL)shouldAutorotate
{
    return NO;
}

/*
- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}
*/

- (void)pushedNewBtn
{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Camera", @"Photo Library", nil];
    [sheet showInView:self.view.window];
    
}

- (void)pushedRemoveBtn
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Remove"
                                                    message:@"This will remove the Card from your Collection.  Do you wish to proceed?"
                                                   delegate:self
                                          cancelButtonTitle:@"NO"
                                          otherButtonTitles:@"YES", nil];
    [alert show];
}

- (void)pushedEditBtn
{
    if(_imageView.image){
        
        CLImageEditor *editor = nil;
        
        if (_imageView.hidden) {
            editor = [[CLImageEditor alloc] initWithImage:_innerImageView.image delegate:self];
        }else{
            editor = [[CLImageEditor alloc] initWithImage:_imageView.image delegate:self];
        }
        
        
        //CLImageEditor *editor = [[CLImageEditor alloc] initWithDelegate:self];
        
        /*
         NSLog(@"%@", editor.toolInfo);
         NSLog(@"%@", editor.toolInfo.toolTreeDescription);
         
         CLImageToolInfo *tool = [editor.toolInfo subToolInfoWithToolName:@"CLToneCurveTool" recursive:NO];
         tool.available = NO;
         
         tool = [editor.toolInfo subToolInfoWithToolName:@"CLRotateTool" recursive:YES];
         tool.available = NO;
         
         tool = [editor.toolInfo subToolInfoWithToolName:@"CLHueEffect" recursive:YES];
         tool.available = NO;
         */
        
        [self presentViewController:editor animated:YES completion:nil];
        //[editor showInViewController:self withImageView:_imageView];
    }
    else{
        [self pushedNewBtn];
    }
}

- (void)pushedSaveBtn
{
    if(_imageView.image){
        NSArray *excludedActivityTypes = @[UIActivityTypeAssignToContact, UIActivityTypeCopyToPasteboard, UIActivityTypeMessage];
        
        UIActivityViewController *activityView = [[UIActivityViewController alloc] initWithActivityItems:@[_imageView.image] applicationActivities:nil];
        
        activityView.excludedActivityTypes = excludedActivityTypes;
//        activityView.completionHandler = ^(NSString *activityType, BOOL completed)
        activityView.completionWithItemsHandler =
         ^(NSString *activityType, BOOL completed, NSArray *returnedItems, NSError *activityError)
        {
            if(completed && [activityType isEqualToString:UIActivityTypeSaveToCameraRoll]){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Saved successfully" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            }
        };
        
        [self presentViewController:activityView animated:YES completion:nil];
    }
    else{
        [self pushedNewBtn];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        return;
    } else {
        [array removeObjectAtIndex:(long)indexCell];
    }
    
    
}

#pragma mark- ImagePicker delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    CLImageEditor *editor = [[CLImageEditor alloc] initWithImage:image];
    editor.delegate = self;
    
    [picker pushViewController:editor animated:YES];
}

#pragma mark- CLImageEditor delegate

- (void)imageEditor:(CLImageEditor *)editor didFinishEdittingWithImage:(UIImage *)image
{
    _imageView.image = image;
    [self refreshImageView];
    
    [editor dismissViewControllerAnimated:YES completion:nil];
}

- (void)imageEditor:(CLImageEditor *)editor willDismissWithImageView:(UIImageView *)imageView canceled:(BOOL)canceled
{
    [self refreshImageView];
}

#pragma mark- Tapbar delegate

- (void)deselectTabBarItem:(UITabBar*)tabBar
{
    tabBar.selectedItem = nil;
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    [self performSelector:@selector(deselectTabBarItem:) withObject:tabBar afterDelay:0.2];
    
    switch (item.tag) {
        case 0:
            //[self pushedNewBtn];
            [self pushedRemoveBtn];
            break;
        case 1:
            [self pushedEditBtn];
            break;
        case 2:
            [self pushedSaveBtn];
            break;
        default:
            break;
    }
}

#pragma mark- Actionsheet delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==actionSheet.cancelButtonIndex){
        return;
    }
    
    UIImagePickerControllerSourceType type = UIImagePickerControllerSourceTypePhotoLibrary;
    
    if([UIImagePickerController isSourceTypeAvailable:type]){
        if(buttonIndex==0 && [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
            type = UIImagePickerControllerSourceTypeCamera;
        }
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.allowsEditing = NO;
        picker.delegate   = self;
        picker.sourceType = type;
        
        [self presentViewController:picker animated:YES completion:nil];
    }
}

#pragma mark- ScrollView

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _imageView.superview;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    CGFloat Ws = _scrollView.frame.size.width - _scrollView.contentInset.left - _scrollView.contentInset.right;
    CGFloat Hs = _scrollView.frame.size.height - _scrollView.contentInset.top - _scrollView.contentInset.bottom;
    CGFloat W = _imageView.superview.frame.size.width;
    CGFloat H = _imageView.superview.frame.size.height;
    
    CGRect rct = _imageView.superview.frame;
    rct.origin.x = MAX((Ws-W)/2, 0);
    rct.origin.y = MAX((Hs-H)/2, 0);
    _imageView.superview.frame = rct;
}

- (void)resetImageViewFrame
{
    CGSize size = (_imageView.image) ? _imageView.image.size : _imageView.frame.size;
    CGFloat ratio = MIN(_scrollView.frame.size.width / size.width, _scrollView.frame.size.height / size.height);
    CGFloat W = ratio * size.width;
    CGFloat H = ratio * size.height;
    _imageView.frame = CGRectMake(0, 0, W, H);
    _imageView.superview.bounds = _imageView.bounds;
}

- (void)resetZoomScaleWithAnimate:(BOOL)animated
{
    CGFloat Rw = _scrollView.frame.size.width / _imageView.frame.size.width;
    CGFloat Rh = _scrollView.frame.size.height / _imageView.frame.size.height;
    
    //CGFloat scale = [[UIScreen mainScreen] scale];
    CGFloat scale = 1;
    Rw = MAX(Rw, _imageView.image.size.width / (scale * _scrollView.frame.size.width));
    Rh = MAX(Rh, _imageView.image.size.height / (scale * _scrollView.frame.size.height));
    
    _scrollView.contentSize = _imageView.frame.size;
    _scrollView.minimumZoomScale = 1;
    _scrollView.maximumZoomScale = MAX(MAX(Rw, Rh), 1);
    
    [_scrollView setZoomScale:_scrollView.minimumZoomScale animated:animated];
    [self scrollViewDidZoom:_scrollView];
}

- (void)refreshImageView
{
    [self resetImageViewFrame];
    [self resetZoomScaleWithAnimate:NO];
}


#pragma mark - Swipe Navigation

- (void)handleSwipe:(UISwipeGestureRecognizer *)swipe {
    
    if (swipe.direction == UISwipeGestureRecognizerDirectionLeft) {
        NSLog(@"Left Swipe");
        
        if (_imageView.hidden == YES) {
            return;
        }
        
        _imageView.alpha = 1.0f;
        _innerImageView.alpha = 0.0f;
        // Then fades it away after 1 second (the cross-fade animation will take 0.5s)
        [UIView animateWithDuration:0.5 delay:1.0 options:0 animations:^{
            // Animate the alpha value of your imageView from 1.0 to 0.0 here
            _imageView.alpha = 0.0f;
            _innerImageView.alpha = 1.0f;
        } completion:^(BOOL finished) {
            // Once the animation is completed and the alpha has gone to 0.0, hide the view for good
            _imageView.hidden = YES;
            _innerImageView.hidden = NO;
        }];
    }
    
    
    if (swipe.direction == UISwipeGestureRecognizerDirectionRight) {
        NSLog(@"Right Swipe");
        
        if (_imageView.hidden == NO) {
            return;
        }
        
        _imageView.alpha = 0.0f;
        _innerImageView.alpha = 1.0f;
        // Then fades it away after 1 seconds (the cross-fade animation will take 0.5s)
        [UIView animateWithDuration:0.5 delay:1.0 options:0 animations:^{
            // Animate the alpha value of your imageView from 1.0 to 0.0 here
            _imageView.alpha = 1.0f;
            _innerImageView.alpha = 0.0f;
        } completion:^(BOOL finished) {
            // Once the animation is completed and the alpha has gone to 0.0, show the view for good
            _imageView.hidden = NO;
            _innerImageView.hidden = YES;
        }];
    }
    
}

@end
