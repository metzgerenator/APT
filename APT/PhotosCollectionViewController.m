//
//  PhotosCollectionViewController.m
//  APT
//
//  Created by Michael Metzger  on 11/16/15.
//  Copyright © 2015 Mike. All rights reserved.
//

#import "PhotosCollectionViewController.h"

@interface PhotosCollectionViewController ()

@end

@implementation PhotosCollectionViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    NSLog(@"value of pfobject is %@", self.pfObjectfromInfoView);
    
    // Register cell classes
//    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    // Do any additional setup after loading the view.
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self queryParseMethod];
    
    //probably don't need this method.  Delete!!
    //check for null and reload
//    if (!self.pfObjectfromInfoView) {
//        
//        NSLog(@"pfobject is null !!");
//        [self popoverPresentationController];
//    }else{
//        [self queryParseMethod];
//
//    }
//    
//}
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
        }
    }];
    
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
