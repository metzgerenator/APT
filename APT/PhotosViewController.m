//
//  PhotosViewController.m
//  APT
//
//  Created by Michael Metzger  on 11/16/15.
//  Copyright © 2015 Mike. All rights reserved.
//

#import "PhotosViewController.h"
#import <MobileCoreServices/UTCoreTypes.h>


@interface PhotosViewController ()

@end

@implementation PhotosViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma mark - take and choose photo


- (IBAction)choosePhotoFromLibrary:(id)sender {
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]==NO) {
        
        return;
    }
    
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    
    //Displays saved pictures from the Camera Roll album
    picker.mediaTypes = @[(NSString*)kUTTypeImage];
    
    //Hides the controls for moving & scaling pictures
    picker.allowsEditing = NO;
    picker.delegate = self;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

- (IBAction)TakePhoto:(id)sender {
    
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [self presentViewController:picker animated:YES completion:NULL];
        
    }
    
}



-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *originalImage = (UIImage *) [info objectForKey:UIImagePickerControllerOriginalImage];
    
    //Change to allow no picture loaded
    
    
    self.previewImage.image = originalImage;
    
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    
}

- (IBAction)saveButton:(id)sender {
//    
//    PFObject *game= [PFObject objectWithClassName:@"Game"];
//    [game setObject:[PFUser currentUser] forKey:@"createdBy"];
    
    PFObject *forPhotos = [PFObject objectWithClassName:@"photos"];
    
    
    //establish the relation with current object id
    
    PFRelation *photoRelation  = [forPhotos relationForKey:@"unitPhotos"];
    
    [photoRelation addObject:self.currentPfObject];
    
    
    
    forPhotos.ACL = [PFACL ACLWithUser:[PFUser currentUser]];
    
    
    //Pack item Image
    NSData *imageData = UIImageJPEGRepresentation(self.previewImage.image, 0.8);
    NSString *filename = [NSString stringWithFormat:@"%@.png", self.keyForPfObject];
    PFFile *imageFile = [PFFile fileWithName:filename data:imageData];
    [forPhotos setObject:imageFile forKey:@"apartmentPhotos"];
    
    
    //upload to Parse
    
    
    
    [forPhotos saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        
        if (!error) {
            // Dismiss the controller
            [self dismissViewControllerAnimated:YES completion:nil];
            
            //Notify table view to reload
            [[NSNotificationCenter defaultCenter]postNotificationName:@"refreshTable" object:self];
        }else {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Upload Failure" message:[error localizedDescription] preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okayAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
            [alertController addAction:okayAction];
            [self presentViewController:alertController animated:YES completion:nil];
            
        }
        
        
        
    }];
    
    
    
}


@end
