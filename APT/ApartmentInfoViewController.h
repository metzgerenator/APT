//
//  ApartmentInfoViewController.h
//  APT
//
//  Created by Aileen Taboy on 11/14/15.
//  Copyright © 2015 Mike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>


@interface ApartmentInfoViewController : UIViewController  <MKAnnotation,CLLocationManagerDelegate,MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *viewAmenitiesButton;

@property (weak, nonatomic) IBOutlet UIButton *changeAmenitiesButton;



- (IBAction)endEdit:(id)sender;

// for maps

@property (nonatomic, assign) MKCoordinateRegion boundingRegion;




@property (weak, nonatomic) IBOutlet UITextField *proPertyName;


@property (weak, nonatomic) IBOutlet UITextField *LeaseLength;


@property (weak, nonatomic) IBOutlet UITextField *leasePrice;


@property (weak, nonatomic) IBOutlet UILabel *appointmentDateLabel;
@property(nonatomic,strong)NSString *appointmentTime;

@property (weak, nonatomic) IBOutlet MKMapView *mapView;



@property(nonatomic,strong)PFObject *fromSegue;








#pragma mark - save and back buttons


- (IBAction)saveActionButton:(id)sender;

- (IBAction)backButton:(id)sender;

@end
