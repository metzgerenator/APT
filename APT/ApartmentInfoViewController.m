//
//  ApartmentInfoViewController.m
//  APT
//
//  Created by Aileen Taboy on 11/14/15.
//  Copyright © 2015 Mike. All rights reserved.
//

#import "ApartmentInfoViewController.h"
#import "CreateAptViewController.h"
#import "PhotosViewController.h"
#import "PhotosCollectionViewController.h"
#import "MapSearchViewController.h"
#import "MapViewAnnotation.h"
#import "EditAmenitiesViewController.h"
#import "ShowAmenitiesViewController.h"
#import "ApartmentTableViewController.h"



@interface ApartmentInfoViewController ()

@property (nonatomic) CLLocationManager *locationManager;



@end



@implementation ApartmentInfoViewController {
    NSArray *placeMarks;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = NO;
    
    
#pragma mark - LaTiesha's Code
    
    // rounding the corners of the Amenties buttons
    
    self.viewAmenitiesButton.layer.cornerRadius = 15;
    self.viewAmenitiesButton.clipsToBounds = YES;
    
    
    self.changeAmenitiesButton.layer.cornerRadius = 15;
    self.changeAmenitiesButton.clipsToBounds = YES;
    
    NSLog(@"from segue is now %@", self.fromSegue);
    
    
    if (self.fromSegue) {
        self.proPertyName.text = [self.fromSegue objectForKey:@"ApartmentName"];
        
        //Nav Label
        self.navigationItem.title = self.proPertyName.text; 
       
        
        
        self.LeaseLength.text = [self.fromSegue objectForKey:@"leaseLength"];
        self.appointmentDateLabel.text = [self.fromSegue objectForKey:@"apointmentTime"];
        self.leasePrice.text = [NSString stringWithFormat:@"$%@",[self.fromSegue objectForKey:@"leasePrice"]];
        
  
        
        // Pin the object to local DataStorage
        
        
        [self.fromSegue pinInBackground];
        
        NSLog(@"pinning in background");

        
    }else {
        
        
        self.proPertyName.text = self.propertyString;
        self.LeaseLength.text = self.leaseString;



       

        
        
    }
    
   
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - calendar picker
// Reverse Segue from calendar picker
- (IBAction)unwindFromModalViewController:(UIStoryboardSegue *)segue{
    
    if ([segue.sourceViewController isKindOfClass:[CreateAptViewController class]]) {
        CreateAptViewController *createAptView = segue.sourceViewController;
        if (createAptView.combinedDateAndTime) {
            self.appointmentTime = createAptView.combinedDateAndTime;
            self.appointmentDateLabel.text = self.appointmentTime;
            NSLog(@"%@",self.appointmentTime);
        }else {
            self.appointmentDateLabel.text = @"click Edit";
        }
      
    
    }

}



#pragma mark - segue to other views
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    //showAmenities
    
    if ([[segue identifier]isEqualToString:@"showAmenities"]){
        ShowAmenitiesViewController *showEditAmenity = segue.destinationViewController;
        //stop user from not setting a property name
        
        if ([self.proPertyName.text length] == 0) {
            UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"Oh No!" message:@"Make sure you name your property before continuing!" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {}];
            
            [alertView addAction:defaultAction];
            [self presentViewController:alertView animated:YES completion:nil];
            
            
        }//if no pfobject and user has created name, then save and pass on
        else if ([self.proPertyName.text length] > 0 && (!self.fromSegue)) {
            
            // Call Save method
            [self saveNewObject];
            
            //Pas new Pfobject
            showEditAmenity.currentPFObject = self.fromSegue;
        } else {
            // Pass Array
            showEditAmenity.currentPFObject = self.fromSegue;
            NSArray *forSegue = [self.fromSegue objectForKey:@"amenities"];
            showEditAmenity.arrayFromSegue = forSegue;
            
            
        }
    }
    else if ([[segue identifier]isEqualToString:@"editAmenities"]){
        EditAmenitiesViewController *editAmenity = segue.destinationViewController;
        //stop user from not setting a property name
        
        if ([self.proPertyName.text length] == 0) {
            UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"Oh No!" message:@"Make sure you name your property before continuing!" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {}];
            
            [alertView addAction:defaultAction];
            [self presentViewController:alertView animated:YES completion:nil];
            
            
        }//if no pfobject and user has created name, then save and pass on
        else if ([self.proPertyName.text length] > 0 && (!self.fromSegue)) {
            
            // Call Save method
            [self saveNewObject];
            
            //Pas new Pfobject
            editAmenity.currentPFObject = self.fromSegue;
        } else {
            
            editAmenity.currentPFObject = self.fromSegue;
            NSArray *forSegue = [self.fromSegue objectForKey:@"amenities"];
            editAmenity.arrayFromSegue = forSegue;

        }
    }
  
    else if ([[segue identifier]isEqualToString:@"Map"]){
        MapSearchViewController *mapObject = segue.destinationViewController;
        //stop user from not setting a property name
        
        if ([self.proPertyName.text length] == 0) {
            UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"Oh No!" message:@"Make sure you name your property before continuing!" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {}];
            
            [alertView addAction:defaultAction];
            [self presentViewController:alertView animated:YES completion:nil];
        
        
        
        
        
    }//if no pfobject and user has created name, then save and pass on
        else if ([self.proPertyName.text length] > 0 && (!self.fromSegue)) {
            
            // Call Save method
            [self saveNewObject];
            
            //Pas new Pfobject
            mapObject.currentPFObject = self.fromSegue;
        } else {
            
            mapObject.currentPFObject = self.fromSegue;
        }
    }
    
    ///next segue to Photos
   else if ([[segue identifier]isEqualToString:@"photos"]) {
        
        PhotosViewController *apartmentObject = segue.destinationViewController;

        //stop user from not setting a property name
        if ([self.proPertyName.text length] == 0) {
            UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"Oh No!" message:@"Make sure you name your property before continuing!" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {}];
            
            [alertView addAction:defaultAction];
            [self presentViewController:alertView animated:YES completion:nil];
        }//if no pfobject and user has created name, then save and pass on
        else if ([self.proPertyName.text length] > 0 && (!self.fromSegue)) {
            
            // Call Save method
            [self saveNewObject];
            
            //Pas new Pfobject
            apartmentObject.currentPfObject = self.fromSegue;
            
            apartmentObject.keyForPfObject = self.proPertyName.text;
            
        }
        else{
        
        
        apartmentObject.currentPfObject = self.fromSegue;
        
        apartmentObject.keyForPfObject = self.proPertyName.text;
        
        }
        
       ///segue for collection View
 
    }else if ([[segue identifier]isEqualToString:@"allPhotos"]){
        
        PhotosCollectionViewController *allPhotos = segue.destinationViewController;

        
        // stop user from going to allPhoto's if PFOBject is nill
        
        if ([self.proPertyName.text length] == 0) {
            UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"Oh No!" message:@"Make sure you name your property before viewing photos!" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {}];
            
            [alertView addAction:defaultAction];
            [self presentViewController:alertView animated:YES completion:nil];
            
            
        } // if a pfobject exists then pass it on
        else if (self.fromSegue){
            
            allPhotos.pfObjectfromInfoView = self.fromSegue;
            
        }
        //if no pfobject and user has created name, then save and pass on
        else if ([self.proPertyName.text length] > 0 && (!self.fromSegue)) {
            
            // Call Save method
            [self saveNewObject];
            
            //Pas new Pfobject
            allPhotos.pfObjectfromInfoView = self.fromSegue;
       
            
        }
        
        
        
        
        
    }
    
    
    
    
}








#pragma mark - save and cancel

//Save method for prepareForSegue
-(void)saveNewObject {
    
    
    NSString *propertyName = self.proPertyName.text;
    
    NSString* LeaseLength = self.LeaseLength.text;
    
    NSString *appointmentTime = self.appointmentDateLabel.text;
    
    NSString *leasePrice = self.leasePrice.text;
    
    
//    [NSString stringWithFormat:@"$%@",self.leasePrice.text];
    
    
    if (self.fromSegue) {
        
        
        
        self.fromSegue.ACL = [PFACL ACLWithUser:[PFUser currentUser]];
        
        
        [self.fromSegue setObject:propertyName forKey:@"ApartmentName"];
        
        [self.fromSegue setObject:LeaseLength forKey:@"leaseLength"];
        
        [self.fromSegue setObject:appointmentTime forKey:@"apointmentTime"];
        
        [self.fromSegue setObject:leasePrice forKey:@"leasePrice"];
        
        
        [self.fromSegue saveInBackground];
        
    }else {
        
        
        
        PFObject *apartMentObject = [PFObject objectWithClassName:@"apartments"];
        
        apartMentObject.ACL = [PFACL ACLWithUser:[PFUser currentUser]];
        
        
        [apartMentObject setObject:propertyName forKey:@"ApartmentName"];
        
        [apartMentObject setObject:LeaseLength forKey:@"leaseLength"];
        
        [apartMentObject setObject:appointmentTime forKey:@"apointmentTime"];
        
        [apartMentObject setObject:leasePrice forKey:@"leasePrice"];

        
        self.fromSegue = apartMentObject;
        
        
        [apartMentObject saveInBackground];
        
    }

    
}



- (IBAction)saveActionButton:(id)sender {
    
    NSString *propertyName = self.proPertyName.text;
    
    NSString* LeaseLength = self.LeaseLength.text;
    
    NSString *appointmentTime = self.appointmentDateLabel.text;

    NSString *leasePrice = self.leasePrice.text;
    
    
    

    if (self.fromSegue) {
        
        self.fromSegue.ACL = [PFACL ACLWithUser:[PFUser currentUser]];
        
        
        [self.fromSegue setObject:propertyName forKey:@"ApartmentName"];
        
        [self.fromSegue setObject:LeaseLength forKey:@"leaseLength"];
        
        [self.fromSegue setObject:appointmentTime forKey:@"apointmentTime"];
        
        [self.fromSegue setObject:leasePrice forKey:@"leasePrice"];

        
        [self.fromSegue saveInBackground];

    }else {
        

    
    PFObject *apartMentObject = [PFObject objectWithClassName:@"apartments"];
    
    apartMentObject.ACL = [PFACL ACLWithUser:[PFUser currentUser]];
    
    
    [apartMentObject setObject:propertyName forKey:@"ApartmentName"];
    
    [apartMentObject setObject:LeaseLength forKey:@"leaseLength"];
        
    [apartMentObject setObject:appointmentTime forKey:@"apointmentTime"];
    
    [apartMentObject setObject:leasePrice forKey:@"leasePrice"];
    
    [apartMentObject saveInBackground];
    
    }
    
    
//    [self.navigationController popViewControllerAnimated:YES];
    
    ApartmentTableViewController *pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MainView"];
    [self presentViewController:pageViewController animated:YES completion:nil];
}

- (IBAction)backButton:(id)sender {
    
    [self.fromSegue unpinInBackground]; 
    
    
    //instantiate view controller
    ApartmentTableViewController *pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MainView"];
    [self presentViewController:pageViewController animated:YES completion:nil];
    
    
    
}


#pragma mark - map functions
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    //Check for PfObject being nill
    
    if (self.fromSegue) {
    
    
    //retrived PFGeoPoint from segue
    
    PFGeoPoint *forCoordinate = [self.fromSegue objectForKey:@"locationCoordinates"];
    
    float coordinateLongitutde = forCoordinate.longitude;
    float coordinateLatitude = forCoordinate.latitude;
    
    
//    //Create MK Coordinate Region
    MKCoordinateRegion region  = { {0.0, 0.0 }, { 0.0, 0.0 } };
    region.center.longitude = coordinateLongitutde;
    region.center.latitude = coordinateLatitude;
    self.boundingRegion = region;


    
    //get name from PFGeoPoint
    NSString* name = [self.fromSegue objectForKey:@"location"];
    

    //create annotation and set it
    MapViewAnnotation *point = [[MapViewAnnotation alloc]init];
    point.coordinate = region.center;
    point.title = name;
    
   
    
    [self.mapView addAnnotation:point];
        
    
    [self.mapView setRegion:self.boundingRegion animated:YES];

    } else {
        

        
        
        
        // show user location
        
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        self.locationManager.distanceFilter = kCLDistanceFilterNone; //whenever we move
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        
        [self.locationManager startUpdatingLocation];
        [self.locationManager requestWhenInUseAuthorization]; // Add This Line
        
        
        //update coordinate region
        
        
        self.mapView.showsUserLocation = YES;

        self.mapView.zoomEnabled = YES;
        
        
        
    }

    
}




//
//-(void)zoomLocation {
//    
//    
//    MKCoordinateRegion region;
//    region.center = self.mapView.userLocation.coordinate;
//    //Adjust span as you like
//    MKCoordinateSpan span;
//    span.latitudeDelta  = 1;
//    span.longitudeDelta = 1;
//    region.span = span;
//    
//    
//    
//}









- (IBAction)endEdit:(id)sender {
    
    [self.view endEditing:YES];  
    
    
}
@end
