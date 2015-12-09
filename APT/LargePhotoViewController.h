//
//  LargePhotoViewController.h
//  APT
//
//  Created by Michael Metzger  on 12/9/15.
//  Copyright © 2015 Mike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <ParseUI/PFQueryCollectionViewController.h>
#import <ParseUI/PFImageView.h>

@interface LargePhotoViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *largePhoto;

@property (weak, nonatomic)PFFile *fileFromSegue;


@end
