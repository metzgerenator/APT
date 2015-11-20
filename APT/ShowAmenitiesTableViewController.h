//
//  ShowAmenitiesTableViewController.h
//  APT
//
//  Created by Aileen Taboy on 11/18/15.
//  Copyright © 2015 Mike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ParseUI/PFQueryTableViewController.h>
#import <Parse/Parse.h>

@interface ShowAmenitiesTableViewController : UITableViewController

//PFobject from segue

@property (nonatomic, strong)PFObject *currentPFObject;

@property (nonatomic, strong)NSArray *arrayFromSegue;  

@end
