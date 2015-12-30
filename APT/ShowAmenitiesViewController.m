//
//  ShowAmenitiesViewController.m
//  APT
//
//  Created by Michael Metzger  on 11/20/15.
//  Copyright © 2015 Mike. All rights reserved.
//

#import "ShowAmenitiesViewController.h"
#import "ShowAmenitiesTableViewCell.h"
#import "ApartmentInfoViewController.h"
#import "EditAmenitiesViewController.h"


@interface ShowAmenitiesViewController ()

@end

@implementation ShowAmenitiesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(triggerAction:) name:@"test1" object:nil];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)viewDidAppear:(BOOL)animated


{
    

   [super viewDidAppear:animated];
    
    if (self.currentPFObject) {
     
    
    NSString *bedRooms = [self.currentPFObject objectForKey:@"numberOfBedrooms"];
    NSString *bathRooms = [self.currentPFObject objectForKey:@"numberOfBathrooms"];
    self.arrayFromSegue = [self.currentPFObject objectForKey:@"amenities"];
    
    [self.tableView reloadData];
    

    self.bedroomsLabel.text = bedRooms;
    self.bathroomsLabel.text = bathRooms;
    
    //set the navbar title
    self.navigationItem.title = [self.currentPFObject objectForKey:@"ApartmentName"];
    }
    else {
        [self reloadInputViews];
    }

    
    
}

-(void) viewDidDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
     [[NSNotificationCenter defaultCenter] postNotificationName:@"test1" object:self.currentPFObject];
    
}





#pragma mark - Notification
-(void)triggerAction:(NSNotification *) notification
{
    
    NSLog(@"trigger action!");

    if ([[notification name] isEqualToString:@"test1"]) {
        
        self.currentPFObject = [notification object];
        
        
        
    }
}



#pragma mark - alertView
-(void)alertView {
    
    UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"Oh No!" message:@"Make sure you name your property before continuing!" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              self.tabBarController.selectedIndex = 0;
                                                            
                                                          
                                                          }];
    
//    [alertView addAction:];
   [alertView addAction:defaultAction];
    
  
    
    [self presentViewController:alertView animated:YES completion:nil];
}



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



#pragma mark - navigation 
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"edit"]) {

        EditAmenitiesViewController *editamenitiesViewController = (EditAmenitiesViewController *)segue.destinationViewController;
        
        editamenitiesViewController.currentPFObject = self.currentPFObject;
        
    
    }
    
    
    
}



@end
