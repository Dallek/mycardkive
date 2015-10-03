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
//    NSMutableArray *array;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    array = [[NSMutableArray alloc] init];
    [array addObject:@"0.png"];
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

    UIImageView *image = (UIImageView *)[cell viewWithTag:200];
    UILabel *label = (UILabel *)[cell viewWithTag:100];
   
    //border of cell
    [cell.layer setBorderWidth:1.0f];
    [cell.layer setBorderColor:[UIColor whiteColor].CGColor];
    
    //make cell round
    //[cell.layer setCornerRadius:50.0f];
    
    if (indexPath.row >= 11) {
        //Display Images
        ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
        [library assetForURL:[array objectAtIndex:indexPath.row] resultBlock:^(ALAsset *asset) {
            image.image = [UIImage imageWithCGImage:[[asset defaultRepresentation] fullResolutionImage]];
        } failureBlock:^(NSError *error) {
            NSLog(@"error : %@", error);
        }];
        
    }else{
    
        if (indexPath.row == 0) {
            label.text = @"Add Card";
            [cell.layer setBorderWidth:0.0f];
            
        }else{
            //Update Image Names
            //label.text = [array objectAtIndex: indexPath.row];

            label.text = @"";
        }
    
        //Display Images
        image.image = [UIImage imageNamed:[array objectAtIndex:indexPath.row]];
    }
    
   
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row >= 11) {
        image = [NSString stringWithFormat:@"%ld",(long)indexPath.row]; //[[array objectAtIndex:indexPath.row] lastPathComponent];
    }else {
        image = [array objectAtIndex:indexPath.row];
    }
    
    if ([image isEqualToString:@"0.png"]) {
        
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Camera", @"Photo Library", nil];
        
        [sheet showInView:self.view.window];
        
        return;
    }
    
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"cardEditViewController"];
    [self presentViewController:vc animated:YES completion:nil];
    

    
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
            // to go directly to camera add below & remove rest in {}
            //type = UIImagePickerControllerSourceTypeCamera;
            
            NSString * storyboardName = @"Main";
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
            UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"cameraViewController"];
            [self presentViewController:vc animated:YES completion:nil];
            
            return;
        }
        
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = type;
        
        [self presentViewController:picker animated:YES completion:NULL];

 }
}

#pragma mark Open Photo Library
- (IBAction)selectPhoto:(UIButton *)sender {

/*    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
//    imagePickerController.delegate = self;
    imagePickerController.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:imagePickerController animated:YES completion:NULL];
*/
 }

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    // Dismiss the image selection, hide the picker and
    
    //show the image view with the picked image
    //UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    //UIImage *chosenImage = info[UIImagePickerControllerOriginalImage];
    //self.imageView.image = chosenImage;
    
    NSURL *imageFileURL = [info objectForKey:UIImagePickerControllerReferenceURL];
    
    // Then get the file name.
    NSString *imageName = [imageFileURL lastPathComponent];
    NSLog(@"image name is %@", imageName);
    
    
    NSLog(@"%@", info);
    NSLog(@"%@", imageFileURL);
    
    [array addObject:imageFileURL];

    [self.collectionView reloadData];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    //UIImage *newImage = image;
    
}

#pragma mark Save Image to Camera Roll
/*- (IBAction)SavePhotoOnClick:(id)sender{
    UIImageWriteToSavedPhotosAlbum(imageToBeSaved, nil, nil, nil);
}*/



@end
