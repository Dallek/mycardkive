//
//  displayCardViewController.m
//  CardKive
//
//  Created by Owner on 9/10/15.
//  Copyright (c) 2015 99Ideas. All rights reserved.
//

#import "displayCardViewController.h"
#import "global.h"

@interface displayCardViewController ()

@end

@implementation displayCardViewController
@synthesize cardImage, innerCardImage;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    cardImage.image =[UIImage imageNamed: image];
    cardImage.hidden = NO;
    
    innerCardImage.image = [UIImage imageNamed: @"open.jpeg"];
    innerCardImage.hidden = NO;
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    
    // Setting the swipe direction.
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    
    // Adding the swipe gesture on image view
    [cardImage addGestureRecognizer:swipeLeft];
    [innerCardImage addGestureRecognizer:swipeRight];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)handleSwipe:(UISwipeGestureRecognizer *)swipe {
    
    if (swipe.direction == UISwipeGestureRecognizerDirectionLeft) {
        NSLog(@"Left Swipe");
        
        if (cardImage.hidden == YES) {
            return;
        }
        
        cardImage.alpha = 1.0f;
        innerCardImage.alpha = 0.0f;
        // Then fades it away after 1 second (the cross-fade animation will take 0.5s)
        [UIView animateWithDuration:0.5 delay:1.0 options:0 animations:^{
            // Animate the alpha value of your imageView from 1.0 to 0.0 here
            cardImage.alpha = 0.0f;
            innerCardImage.alpha = 1.0f;
        } completion:^(BOOL finished) {
            // Once the animation is completed and the alpha has gone to 0.0, hide the view for good
            cardImage.hidden = YES;
            innerCardImage.hidden = NO;
        }];
    }
    
    
    if (swipe.direction == UISwipeGestureRecognizerDirectionRight) {
        NSLog(@"Right Swipe");
        
        if (cardImage.hidden == NO) {
            return;
        }
        
        cardImage.alpha = 0.0f;
        innerCardImage.alpha = 1.0f;
        // Then fades it away after 1 seconds (the cross-fade animation will take 0.5s)
        [UIView animateWithDuration:0.5 delay:1.0 options:0 animations:^{
            // Animate the alpha value of your imageView from 1.0 to 0.0 here
            cardImage.alpha = 1.0f;
            innerCardImage.alpha = 0.0f;
        } completion:^(BOOL finished) {
            // Once the animation is completed and the alpha has gone to 0.0, show the view for good
            cardImage.hidden = NO;
            innerCardImage.hidden = YES;
        }];
    }
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)editImage:(id)sender {
}
@end
