//
//  PhotosCollectionViewController.m
//  APT
//
//  Created by Michael Metzger  on 11/16/15.
//  Copyright © 2015 Mike. All rights reserved.
//

#import "PhotosCollectionViewController.h"
#import "LargePhotoViewController.h"

@interface PhotosCollectionViewController ()

@end

@implementation PhotosCollectionViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(triggerAction:) name:@"test1" object:nil];

    
 
}



#pragma mark - Notification
-(void)triggerAction:(NSNotification *) notification
{
    
    if ([[notification name] isEqualToString:@"test1"]) {
        
        self.pfObjectfromInfoView = [notification object];
        
        
        
    }
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

    
    if (self.pfObjectfromInfoView) {
        [self queryParseMethod];
    }
    
    
    
    //label nav bar
    
    self.navigationItem.title = [self.pfObjectfromInfoView objectForKey:@"ApartmentName"];
 
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - query parse

-(void)queryParseMethod {
    PFQuery *query = [PFQuery queryWithClassName:@"photos"];
    
    
    [query whereKey:@"unitPhotos" equalTo:[self.pfObjectfromInfoView  objectId]];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (!error) {
            imageFilesArray = [[NSArray alloc]initWithArray:objects];
            
            
            [self.collectionView reloadData];
            
            // send user to add photos if nothing is found
            if (objects.count == 0) {
                
                [self performSegueWithIdentifier:@"newPhoto" sender:self];
                
            }
            
            
        }
    }];
    
   
}




#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return imageFilesArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * const reuseIdentifier = @"imageCell";

    PhotosCollectionViewCell *cell = (PhotosCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    
    PFObject *imageObject = [imageFilesArray objectAtIndex:indexPath.row];
    //only pull PFobjects matching current object ID
    
    PFFile *imageFile = [imageObject objectForKey:@"apartmentPhotos"];

 
    
    [imageFile getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
        if (!error) {
            
            cell.parseImage.image = [UIImage imageWithData:data];

        }
        
        
          }];
    
    
    return cell;
}

#pragma mark  - navigation




-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"photo"]) {
    NSArray *indexPaths = [self.collectionView indexPathsForSelectedItems];
    LargePhotoViewController *destViewController = (LargePhotoViewController *)segue.destinationViewController;
    [destViewController.childViewControllers firstObject];
    NSIndexPath *indexPath = [indexPaths objectAtIndex:0];
    destViewController.largePhoto.image = [imageFilesArray objectAtIndex:indexPath.row];
        
        PFObject *imageObject = [imageFilesArray objectAtIndex:indexPath.row];
        //only pull PFobjects matching current object ID
        
        PFFile *imageFile = [imageObject objectForKey:@"apartmentPhotos"];
        destViewController.fileFromSegue  = imageFile;
        
    
        }
        }






                                           



@end
