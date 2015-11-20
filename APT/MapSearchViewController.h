//
//  MapSearchViewController.h
//  APT
//
//  Created by Aileen Taboy on 11/17/15.
//  Copyright © 2015 Mike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface MapSearchViewController : UIViewController <MKAnnotation,CLLocationManagerDelegate,MKMapViewDelegate>

//for defining portion to display on map
@property (nonatomic, assign) MKCoordinateRegion boundingRegion;
@property (nonatomic)CLLocationCoordinate2D coordinate;

@property (nonatomic, strong)PFObject *currentPFObject;  


@property (weak, nonatomic) IBOutlet MKMapView *mapView;

//Add search text field 
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;

- (IBAction)userLocation:(id)sender;

- (IBAction)searchButton:(id)sender;

@end
