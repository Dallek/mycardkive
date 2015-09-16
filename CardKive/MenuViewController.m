//
//  MenuViewController.m
//  CardKive
//
//  Created by Mini on 8/16/15.
//  Copyright (c) 2015 99Ideas. All rights reserved.
//

#import "MenuViewController.h"
#import "global.h"

@interface MenuViewController ()

@end

@implementation MenuViewController{
    NSMutableArray *array;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    array = [[NSMutableArray alloc] init];
    [array addObject:@"1.jpg"];
    [array addObject:@"2.jpg"];
    [array addObject:@"3.jpg"];
    [array addObject:@"4.jpg"];
    [array addObject:@"5.jpg"];
    [array addObject:@"6.jpg"];
    [array addObject:@"7.jpg"];
    [array addObject:@"8.jpg"];
    [array addObject:@"9.jpg"];
    [array addObject:@"10.jpg"];
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

    //Update Image Names
    UILabel *label = (UILabel *)[cell viewWithTag:100];
    label.text = [array objectAtIndex: indexPath.row];
    
    //Display Images
    UIImageView *image = (UIImageView *)[cell viewWithTag:200];
    image.image = [UIImage imageNamed:[array objectAtIndex:indexPath.row]];
    
    //border of cell
    [cell.layer setBorderWidth:1.0f];
    [cell.layer setBorderColor:[UIColor whiteColor].CGColor];
    
    //make cell round
    //[cell.layer setCornerRadius:50.0f];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    image = [array objectAtIndex:indexPath.row];
    
    
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"displayCardViewController"];
    [self presentViewController:vc animated:YES completion:nil];
    

    
}

#pragma mark Open Photo Library
- (IBAction)selectPhoto:(UIButton *)sender {
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
//    imagePickerController.delegate = self;
    imagePickerController.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:imagePickerController animated:YES completion:NULL];
}

- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingImage:(UIImage *)image
editingInfo:(NSDictionary *)editingInfo
{
    
    // Dismiss the image selection, hide the picker and
    
    //show the image view with the picked image
    
//    [picker dismissModalViewControllerAnimated:YES];
    [picker dismissViewControllerAnimated:YES completion:nil];
    //UIImage *newImage = image;
    
    
}



@end
