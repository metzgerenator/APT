//
//  MainMapViewController.m
//  APT
//
//  Created by Michael Metzger  on 11/19/15.
//  Copyright © 2015 Mike. All rights reserved.
//

#import "MainMapViewController.h"
#import "MapViewAnnotation.h"

@interface MainMapViewController ()

@property (nonatomic,strong)NSMutableArray *placeMarks;


@end

@implementation MainMapViewController{
    
    //    NSArray *placeMarks;
    
    NSArray *pfObjects;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    
    //     [self.mapView setRegion:self.boundingRegion animated:YES];
    // Do any additional setup after loading the view.
}



-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    //step 1
   
    
//    [self.mapView removeAnnotations:self.mapView.annotations];
    
    PFQuery *query = [PFQuery queryWithClassName:@"apartments"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *apartmentObjects, NSError *error)
     {
        
         for (PFObject *fromQuery in apartmentObjects) {
             
            PFGeoPoint *forCoordinate = [fromQuery objectForKey:@"locationCoordinates"];
             
            if (forCoordinate) {
             
             
            float coordinateLongitutde = forCoordinate.longitude;
            float coordinateLatitude = forCoordinate.latitude;
                
            CLLocationCoordinate2D pin;
            pin.latitude = coordinateLatitude;
            pin.longitude = coordinateLongitutde;
             
             
            //get name from PFGeoPoint
            NSString* name = [fromQuery objectForKey:@"location"];
             
             
            //create annotation and set it
            MapViewAnnotation *point = [[MapViewAnnotation alloc]init];
            point.coordinate = pin;
            point.title = name;
                         
            NSLog(@"adding annotations now");
            [self.mapView addAnnotation:point];
            [self zoomToFitMapAnnotations:self.mapView];
                
               
                         
                     }
             
            
         }
         
     }];
    
 
}

-(void)zoomToFitMapAnnotations:(MKMapView*)aMapView
{
    if([aMapView.annotations count] == 0)
        return;
    
    CLLocationCoordinate2D topLeftCoord;
    topLeftCoord.latitude = -90;
    topLeftCoord.longitude = 180;
    
    CLLocationCoordinate2D bottomRightCoord;
    bottomRightCoord.latitude = 90;
    bottomRightCoord.longitude = -180;
    
    for(MapViewAnnotation *annotation in self.mapView.annotations)
    {
        topLeftCoord.longitude = fmin(topLeftCoord.longitude, annotation.coordinate.longitude);
        topLeftCoord.latitude = fmax(topLeftCoord.latitude, annotation.coordinate.latitude);
        
        bottomRightCoord.longitude = fmax(bottomRightCoord.longitude, annotation.coordinate.longitude);
        bottomRightCoord.latitude = fmin(bottomRightCoord.latitude, annotation.coordinate.latitude);
    }
    
    MKCoordinateRegion region;
    region.center.latitude = topLeftCoord.latitude - (topLeftCoord.latitude - bottomRightCoord.latitude) * 0.5;
    region.center.longitude = topLeftCoord.longitude + (bottomRightCoord.longitude - topLeftCoord.longitude) * 0.5;
    region.span.latitudeDelta = fabs(topLeftCoord.latitude - bottomRightCoord.latitude) * 1.1; // Add a little extra space on the sides
    region.span.longitudeDelta = fabs(bottomRightCoord.longitude - topLeftCoord.longitude) * 1.1; // Add a little extra space on the sides
    
    region = [aMapView regionThatFits:region];
    [self.mapView setRegion:region animated:NO];
}

#pragma mark - create annotations
-(void)annotationCreation {
    
    MKCoordinateRegion region = self.boundingRegion;


    
    MKMapPoint points[[pfObjects count]];
    
    for (int i = 0; i<pfObjects.count; i ++) {
        PFGeoPoint *forCoordinate = [pfObjects[i] objectForKey:@"locationCoordinates"];
        
        if (forCoordinate) {
            
        
        
        CLLocationCoordinate2D cordinate;
        
        cordinate.longitude = forCoordinate.longitude;
        cordinate.latitude = forCoordinate.latitude;
        
        
            points[i] = MKMapPointForCoordinate(cordinate); }
        
    }
    MKPolygon *poly = [MKPolygon polygonWithPoints:points count:[pfObjects count]];
    MKMapRect rectForMap = [poly boundingMapRect];
    
    region = MKCoordinateRegionForMapRect(rectForMap);
    self.boundingRegion = region;
    region = [self.mapView regionThatFits:region];

    [self.mapView setRegion:self.boundingRegion animated:YES];
    
   
    
    
}





//#pragma mark - query parse
//
//-(void)queryParseMethod {
//    
//    
//    PFQuery *query = [PFQuery queryWithClassName:@"apartments"];
//    
//    [query whereKeyExists:@"ApartmentName"];
//    
//    
//    
//    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
//        if (!error) {
//            
//            
//            pfObjects = [[NSArray alloc]initWithArray:objects];
//            
//            //
//            
//            
//            [self annotationCreation];
//           
//            [self viewDidDisappear:YES];
//            [self viewDidAppear:YES];
//        }
//        
//    }];
//    
//    
//    
//    
//    
//}
//

#pragma mark - set annotation zoom





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
