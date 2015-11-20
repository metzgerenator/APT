//
//  EditAmenitiesViewController.h
//  APT
//
//  Copyright © 2015 Mike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ParseUI/PFQueryTableViewController.h>
#import <Parse/Parse.h>


@interface EditAmenitiesViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>
// Bedrooms

- (IBAction)stepControllerBedrooms:(UIStepper *)sender;

@property (weak, nonatomic) IBOutlet UILabel *numberOfBedrooms;

@property (nonatomic,strong)NSString *bedroomsString;



//Bathrooms

- (IBAction)stepControllerBathrooms:(UIStepper *)sender;

@property (weak, nonatomic) IBOutlet UILabel *numberOfBathrooms;

@property (nonatomic,strong)NSString *bathroomsString;


//SaveFunction


- (IBAction)saveToParse:(id)sender;


//PFObject from segue

@property (nonatomic, strong)NSArray *arrayFromSegue;   

@property (nonatomic, strong)PFObject *currentPFObject;




//TableView


@property (weak, nonatomic) IBOutlet UITableView *tableView;




@end
