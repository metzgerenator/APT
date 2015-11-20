//
//  ShowAmenitiesViewController.h
//  APT
//
//  Created by Michael Metzger  on 11/20/15.
//  Copyright © 2015 Mike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ParseUI/PFQueryTableViewController.h>
#import <Parse/Parse.h>

@interface ShowAmenitiesViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)PFObject *currentPFObject;

@property (nonatomic, strong)NSArray *arrayFromSegue;

@property (weak, nonatomic) IBOutlet UILabel *bedroomsLabel;
@property (weak, nonatomic) IBOutlet UILabel *bathroomsLabel;


@property(weak, nonatomic) IBOutlet UITableView *tableView;


@end
