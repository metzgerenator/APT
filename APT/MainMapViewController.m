//
//  MainMapViewController.m
//  APT
//
//  Created by Michael Metzger  on 11/19/15.
//  Copyright © 2015 Mike. All rights reserved.
//

#import "MainMapViewController.h"
#import "MapViewAnnotation.h"
#import "ApartmentInfoViewController.h"
#import "PageViewController.h"

@interface MainMapViewController ()

//@property (nonatomic,strong)NSMutableArray *placeMarks;


@end

@implementation MainMapViewController{
    
    //    NSArray *placeMarks;
    
    NSArray *pfObjects;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//    
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    BOOL hasViedWalkthrough = [defaults boolForKey:@"hasViewedWalkthrough"];
//    
//    
//    if (!hasViedWalkthrough) {
//        
//        PageViewController *pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
//        [self presentViewController:pageViewController animated:YES completion:nil];
//        
//    }
//    
//    
//    
//    //Check for logged in user
//    PFUser *currentUser = [PFUser currentUser];
//    
//    if (currentUser) {
//        
//        NSLog(@"The Current User is %@",currentUser.username);
//        
//    }else {
//        
//        [self performSegueWithIdentifier:@"showLogin" sender:self];
//    }
//    
//    [self viewWillAppear:YES];
    


    
}
-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.mapView removeAnnotations:self.mapView.annotations];
    
}


#pragma mark - query parse and create annotation

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
  
    
    PFQuery *query = [PFQuery queryWithClassName:@"apartments"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *apartmentObjects, NSError *error)
     {
         pfObjects = [[NSArray alloc]initWithArray:apartmentObjects];
         
        
         for (PFObject *fromQuery in apartmentObjects) {
             
            PFGeoPoint *forCoordinate = [fromQuery objectForKey:@"locationCoordinates"];
            
             
            if (forCoordinate) {
             
             
            float coordinateLongitutde = forCoordinate.longitude;
            float coordinateLatitude = forCoordinate.latitude;
                
            CLLocationCoordinate2D pin;
            pin.latitude = coordinateLatitude;
            pin.longitude = coordinateLongitutde;
             
             
            //get name from PFGeoPoint
            NSString* name = [fromQuery objectForKey:@"ApartmentName"];
             
             
            //create annotation and set it
            MapViewAnnotation *point = [[MapViewAnnotation alloc]init];
            point.coordinate = pin;
            point.title = name;
                         
            [self.mapView addAnnotation:point];
            [self zoomToFitMapAnnotations:self.mapView];
                
               
                         
                     }
             
            
         }
         
     }];
    
 
}

#pragma mark - set zoom on map

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

#pragma mark - customize annotations


-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    // reuse pin annotation
    static NSString *viewId = @"MKPinAnnotationView";
    MKPinAnnotationView *annotationView = (MKPinAnnotationView*)
    [self.mapView dequeueReusableAnnotationViewWithIdentifier:viewId];
    if (annotationView == nil) {
        annotationView = [[MKPinAnnotationView alloc]
                          initWithAnnotation:annotation reuseIdentifier:viewId];
    }
    
    
    // create a button for callout
    UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    
    
    [saveButton setTitle:@"Details" forState:UIControlStateNormal];
    saveButton.bounds = CGRectMake(0, 0, 100, 44);
    
    
    
    //changes to standard annotation
    annotationView.rightCalloutAccessoryView = saveButton;
    annotationView.animatesDrop = YES;
    annotationView.canShowCallout = YES;
    
    
    return annotationView;
    
    
    
}


#pragma mark - button tapped


-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{
    
   
    
    // use the annotation view as the sender
    
    [self performSegueWithIdentifier:@"map" sender:view];

    
    
}

#pragma mark - prepare for segue 

//-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(MKAnnotationView *)sender {
//    
//    
//    if ([segue.identifier isEqualToString:@"map"]) {
//        
//    
//    
//    ApartmentInfoViewController *apartmentInfo = segue.destinationViewController;
//    // string for comparision
//        NSString *mapString = sender.annotation.title;
//  
//    for (PFObject *storedPfObject in pfObjects) {
//        
//        // does string match annotation
//        NSString *toCompare = [storedPfObject objectForKey:@"ApartmentName"];
//        if ([toCompare isEqualToString:mapString]) {
//            apartmentInfo.fromSegue = storedPfObject;
//        }
//      
//        
//    }
//    
//    
//    }
//    
//    
//}



-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(MKAnnotationView *)sender {
    
    
    if ([segue.identifier isEqualToString:@"map"]) {
        
        UITabBarController *tabar = segue.destinationViewController;
        UINavigationController *navBar = [[tabar viewControllers]objectAtIndex:0];
        
        ApartmentInfoViewController *apartmentInfo = [[navBar viewControllers]objectAtIndex:0];
        // string for comparision
        NSString *mapString = sender.annotation.title;
        
        for (PFObject *storedPfObject in pfObjects) {
            
            // does string match annotation
            NSString *toCompare = [storedPfObject objectForKey:@"ApartmentName"];
            if ([toCompare isEqualToString:mapString]) {
                apartmentInfo.fromSegue = storedPfObject;
            }
            
            
        }
        
        
    }
    
    
}






#pragma mark - set annotation zoom





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark - logout function

- (IBAction)logoutButton:(id)sender {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:false forKey:@"hasViewedWalkthrough"];
    
    
    [PFUser logOutInBackground];
   
    
    
    [NSUserDefaults resetStandardUserDefaults];
    
    
     [self performSegueWithIdentifier:@"showLogin" sender:self];
    
}
@end
