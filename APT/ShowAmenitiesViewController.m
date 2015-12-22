//
//  ShowAmenitiesViewController.m
//  APT
//
//  Created by Michael Metzger  on 11/20/15.
//  Copyright © 2015 Mike. All rights reserved.
//

#import "ShowAmenitiesViewController.h"
#import "ShowAmenitiesTableViewCell.h"


@interface ShowAmenitiesViewController ()

@end

@implementation ShowAmenitiesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    PFQuery *query = [PFQuery queryWithClassName:@"apartments"];
    
    [query fromPin];
    
    
    
    self.currentPFObject = [query getFirstObject];
    
    // current pfobject
    
    NSString *bedRooms = [self.currentPFObject objectForKey:@"numberOfBedrooms"];
    NSString *bathRooms = [self.currentPFObject objectForKey:@"numberOfBathrooms"];
    self.arrayFromSegue = [self.currentPFObject objectForKey:@"amenities"];
    
    [self.tableView reloadData];
    
    NSLog(@"array is now %@", self.arrayFromSegue);

    self.bedroomsLabel.text = bedRooms;
    self.bathroomsLabel.text = bathRooms;  
    
}

//-(void)viewDidDisappear:(BOOL)animated {
//    [super viewDidDisappear:animated];
//    
//    [self.currentPFObject unpinInBackground];
//}



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
