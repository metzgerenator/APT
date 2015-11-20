//
//  ApartmentTableViewController.m
//  APT
//
//  Created by Aileen Taboy on 11/14/15.
//  Copyright © 2015 Mike. All rights reserved.
//

#import "ApartmentTableViewController.h"
#import "ApartmentTableViewCell.h"
#import "ApartmentInfoViewController.h"


@interface ApartmentTableViewController (){
    NSArray *pfobjectStorage;
}

@end

@implementation ApartmentTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    PFUser *currentUser = [PFUser currentUser];
    
    if (currentUser) {
        
        NSLog(@"The Current User is %@",currentUser.username);
        
    }else {
        
        [self performSegueWithIdentifier:@"showLogin" sender:self];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(refreshTable:)
                                                 name:@"refreshTable"
                                               object:nil];

    
}

-(void)refreshTable: (NSNotification*) notification
{
    [self loadObjects];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


-(id)initWithCoder:(NSCoder *)aCoder
{
    self = [super initWithCoder:aCoder];
    
    if (self) {
        //The className to query on
        self.parseClassName = @"apartments";
        
        //the key of the PFObject to display in the label of the default cell style
        self.textKey = @"ApartmentName";
        
        //Whether the built-in pull-to-refresh is enabled
        self.pullToRefreshEnabled = YES;
        
        //Whether the built-in pagination is enabled
        self.paginationEnabled = NO;
    }
    return self;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:
(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Remove the row from data model
    PFObject *object = [self.objects objectAtIndex:indexPath.row];
    [object deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        [self refreshTable:nil];
    }];
    [self.tableView reloadData];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(nullable PFObject *)object {
    
    static NSString *CellIdentifier = @"Cell";
    
    ApartmentTableViewCell *cell = (ApartmentTableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    pfobjectStorage = self.objects;
  
    
    cell.apartmentName.text = [object objectForKey:@"ApartmentName"];
    
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //apartmentInfo
    ApartmentInfoViewController *apartmentInfo = segue.destinationViewController;
    
    if ([[segue identifier] isEqualToString:@"apartmentInfo"]) {
        NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
        PFObject *objet = pfobjectStorage [selectedIndexPath.row];
        apartmentInfo.fromSegue = objet;


        
    }
    
    
    
}

#pragma mark - Log Out
- (IBAction)logOutButton:(id)sender {
    
    
    [PFUser logOut];
    
    // Take the user back to the login segue
    
    [self performSegueWithIdentifier:@"showLogin" sender:self];
}
@end
