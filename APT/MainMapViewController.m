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
   
    
    [self.mapView removeAnnotations:self.mapView.annotations];
    
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
             
             
//                         //    //Create MK Coordinate Region
//                         MKCoordinateRegion region  = { {0.0, 0.0 }, { 0.0, 0.0 } };
//             
//                         region.center.longitude = coordinateLongitutde;
//                         region.center.latitude = coordinateLatitude;
//                         self.boundingRegion = region;
             
             
             
                         //get name from PFGeoPoint
                         NSString* name = [fromQuery objectForKey:@"location"];
             
             
                         //create annotation and set it
                         MapViewAnnotation *point = [[MapViewAnnotation alloc]init];
                         point.coordinate = pin;
                         point.title = name;
                         
                         NSLog(@"adding annotations now");
                         [self.mapView addAnnotation:point];
//                         [self.mapView setRegion:self.boundingRegion animated:NO];
                
                         
                         
                     }

         }
         
         
         
         
         
     }];
    
}

#pragma mark - create annotations
//
//-(void)annotationCreation {
//    
//    for (PFObject *fromQuery in pfObjects) {
//        
//        
//        
//        PFGeoPoint *forCoordinate = [fromQuery objectForKey:@"locationCoordinates"];
//        
//        if (forCoordinate) {
//            
//            
//            float coordinateLongitutde = forCoordinate.longitude;
//            float coordinateLatitude = forCoordinate.latitude;
//            
//            
//            //    //Create MK Coordinate Region
//            MKCoordinateRegion region  = { {0.0, 0.0 }, { 0.0, 0.0 } };
//            
//            region.center.longitude = coordinateLongitutde;
//            region.center.latitude = coordinateLatitude;
//            self.boundingRegion = region;
//            
//            
//            
//            //get name from PFGeoPoint
//            NSString* name = [fromQuery objectForKey:@"location"];
//            
//            
//            //create annotation and set it
//            MapViewAnnotation *point = [[MapViewAnnotation alloc]init];
//            point.coordinate = region.center;
//            point.title = name;
//            
//            NSLog(@"adding annotations now");
//            [self.mapView addAnnotation:point];
//            [self.mapView setRegion:self.boundingRegion animated:YES];
//            
//            
//            
//        }
//        
//    }
//    
//    
//}

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
