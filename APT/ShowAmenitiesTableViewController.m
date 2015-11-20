//
//  ShowAmenitiesTableViewController.m
//  APT
//
//  Created by Aileen Taboy on 11/18/15.
//  Copyright © 2015 Mike. All rights reserved.
//

#import "ShowAmenitiesTableViewController.h"
#import "ShowAmenitiesTableViewCell.h"

@interface ShowAmenitiesTableViewController ()

@end

@implementation ShowAmenitiesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//        PFObject *objectFromParse = self.currentPFObject;
//    
//        NSArray *forTable  = [objectFromParse objectForKey:@"amenities"];
//    
//    
//    
//        showAmenitiesArray = forTable;
//    
//    
//    //queryparsemethod
//    
////    [self queryParseMethod];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayFromSegue.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 
    
    static NSString *cellIdentifier = @"Cell";
    ShowAmenitiesTableViewCell *cell = (ShowAmenitiesTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    NSString *amenityString = [self.arrayFromSegue objectAtIndex:indexPath.row];
    
    
    
    cell.showAmenitiyLabel.text = amenityString;  
    
    
    return cell;
}




@end
