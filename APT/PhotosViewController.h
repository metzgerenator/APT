//
//  PhotosViewController.h
//  APT
//
//  Created by Michael Metzger  on 11/16/15.
//  Copyright © 2015 Mike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface PhotosViewController : UIViewController <UIImagePickerControllerDelegate,UINavigationControllerDelegate>;

@property (nonatomic, strong)NSString *keyForPfObject;

@property (nonatomic, strong) PFObject *currentPfObject;



@property (weak, nonatomic) IBOutlet UIImageView *previewImage;

- (IBAction)choosePhotoFromLibrary:(id)sender;

- (IBAction)TakePhoto:(id)sender;

- (IBAction)saveButton:(id)sender;

@end
