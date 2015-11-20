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

// for maps

@property (nonatomic, assign) MKCoordinateRegion boundingRegion;




@property (weak, nonatomic) IBOutlet UITextField *proPertyName;
@property(nonatomic,strong)NSString *propertyString;


@property (weak, nonatomic) IBOutlet UITextField *LeaseLength;
@property(nonatomic,strong)NSString *leaseString;


@property (weak, nonatomic) IBOutlet UILabel *leasePriceLabel;

@property (weak, nonatomic) IBOutlet UILabel *appointmentDateLabel;
@property(nonatomic,strong)NSString *appointmentTime;

@property (weak, nonatomic) IBOutlet MKMapView *mapView;



@property(nonatomic,strong)PFObject *fromSegue;


- (IBAction)saveActionButton:(id)sender;


@end
