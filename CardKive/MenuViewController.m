//
//  MenuViewController.m
//  CardKive
//
//  Created by Mini on 8/16/15.
//  Copyright (c) 2015 99Ideas. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController{
    NSMutableArray *array;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    array = [[NSMutableArray alloc] init];
    [array addObject:@"This"];
    [array addObject:@"Shit"];
    [array addObject:@"Isn't"];
    [array addObject:@"Working"];
    [array addObject:@"Yet"];
    [array addObject:@"But"];
    [array addObject:@"We're"];
    [array addObject:@"Getting"];
    [array addObject:@"Closer"];
    [array addObject:@"Bitches!!!!"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)unwindToMenuViewController:(UIStoryboardSegue *)unwindSegue
{
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Collection View Methods

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [array count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier: @"Cell" forIndexPath: indexPath];
    
    UILabel *label = (UILabel *)[cell viewWithTag:100];
    
    label.text = [array objectAtIndex: indexPath.row];
    
    //border of cell
    [cell.layer setBorderWidth:2.0f];
    [cell.layer setBorderColor:[UIColor whiteColor].CGColor];
    
    //make cell round
    [cell.layer setCornerRadius:50.0f];
    
    return cell;
}

#pragma mark Open Photo Library
- (IBAction)selectPhoto:(UIButton *)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
    
}




@end
