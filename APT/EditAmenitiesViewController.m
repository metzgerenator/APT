//
//  EditAmenitiesViewController.m
//  APT
//
//  Copyright © 2015 Mike. All rights reserved.
//

#import "EditAmenitiesViewController.h"
#import "EditAmenitiesTableViewCell.h"

@interface EditAmenitiesViewController (){
    NSArray *amenitiesArray;
    
    NSMutableArray *amenitiesForParse;
    
    NSString *bedrooms;
    
    NSString *bathrooms;
    
    
   
}
@property (nonatomic, strong)NSString *feature;

@end

@implementation EditAmenitiesViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    


}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    
    
    
    
    
    [self queryParseMethod];
    
    
    
    amenitiesForParse = [[NSMutableArray alloc]init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Query Parse




-(void)queryParseMethod {
    PFQuery *query = [PFQuery queryWithClassName:@"amenities"];
    
    
    [query whereKeyExists:@"unitAmenities"];
    
    
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (!error) {
            amenitiesArray = [[NSArray alloc]initWithArray:objects];
            
            
            [self.tableView reloadData];
        }
    }];
    
    
    // set the Bedrooms and Bathrooms
    
    bedrooms = [self.currentPFObject objectForKey:@"numberOfBedrooms"];
    
    bathrooms = [self.currentPFObject objectForKey:@"numberOfBathrooms"];
    
    self.numberOfBedrooms.text = bedrooms;
    
    self.numberOfBathrooms.text = bathrooms;
    
    
    


    
    
    
}





#pragma mark - Table view data source



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return amenitiesArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"Cell";
    EditAmenitiesTableViewCell *cell = (EditAmenitiesTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    
    // change the switch to off or on
    
    
    
    
    PFObject *amenityObject = [amenitiesArray objectAtIndex:indexPath.row];
    
    NSString *amenityString = [amenityObject objectForKey:@"unitAmenities"];
    cell.amenityLabel.text = amenityString;
    
    self.feature = amenityString;
    cell.amenitySwitch.tag = indexPath.row;
    
    for (NSString *d in self.arrayFromSegue) {
        
        if ([d isEqualToString:amenityString]) {
            [cell.amenitySwitch setOn:YES];
            //add to the array to equal original values
            [amenitiesForParse addObject:amenityString];
        }
        
        
    }
    
    // set the default stepper value
    
    
    self.numberOfBedrooms.text = bedrooms;
    
    self.numberOfBathrooms.text = bathrooms;
    
    
     [cell.amenitySwitch addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
    
    
    
    return cell;
}


#pragma mark - switch Action


-(IBAction)switchChanged:(UISwitch *)sender {
    

   PFObject *amenityObject = [amenitiesArray objectAtIndex:sender.tag];
    
    NSString *amenityString = [amenityObject objectForKey:@"unitAmenities"];
    
    if ([sender isOn]) {
        NSLog(@"swhitch is on %@", amenityString);
        
        [amenitiesForParse addObject:amenityString];
        
        
    } else {
        NSLog(@"switch is off");
        [amenitiesForParse removeObject:amenityString];
    }
    
    
    
    
    
}






#pragma mark - step controllers

- (IBAction)stepControllerBedrooms:(UIStepper *)sender {
   
    double value = sender.value;
    
    [self.numberOfBedrooms setText:[NSString stringWithFormat:@"%d", (int)value]];
    
}
- (IBAction)stepControllerBathrooms:(UIStepper *)sender {
    
     double value = sender.value;
    
    [self.numberOfBathrooms setText:[NSString stringWithFormat:@"%d", (int)value]];
  
    
}

#pragma mark - Save To Parse

- (IBAction)saveToParse:(id)sender {
    
    // Save to Parse
    
    NSString *bedroomNumber = self.numberOfBedrooms.text ;
    NSString *bathRoomNumber = self.numberOfBathrooms.text;
    
    
    PFObject *amenities  = self.currentPFObject;
    amenities.ACL = [PFACL ACLWithUser:[PFUser currentUser]];
    
    [amenities setObject:bedroomNumber forKey:@"numberOfBedrooms"];
    [amenities setObject:bathRoomNumber forKey:@"numberOfBathrooms"];
    
    
    // Create an array of amenities and save it to parse as an object
    
    
    
    
    
    NSArray *amenityList = [[NSArray alloc]init];
    amenityList = amenitiesForParse;
    
    [amenities setObject:amenityList forKey:@"amenities"];
    
    
    

    
    //Upload to Parse
    [amenities saveInBackground];
    
    [self.navigationController popViewControllerAnimated:YES];

    
    
}
@end
