//
//  MainMapViewController.h
//  APT
//
//  Created by Michael Metzger  on 11/19/15.
//  Copyright © 2015 Mike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <MapKit/MapKit.h>

@interface MainMapViewController : UIViewController <MKAnnotation,CLLocationManagerDelegate,MKMapViewDelegate>

//for defining portion to display on map
@property (nonatomic, assign) MKCoordinateRegion boundingRegion;
@property (nonatomic)CLLocationCoordinate2D coordinate;


@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end
