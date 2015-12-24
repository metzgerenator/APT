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
#import "PageViewController.h"


@interface ApartmentTableViewController (){
    NSArray *pfobjectStorage;
}

@end

@implementation ApartmentTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    check for walkthrough
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL hasViedWalkthrough = [defaults boolForKey:@"hasViewedWalkthrough"];
    
    
    if (!hasViedWalkthrough) {
        
        PageViewController *pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
        [self presentViewController:pageViewController animated:YES completion:nil];
        
    }
    
    
    
    //Check for logged in user
    PFUser *currentUser = [PFUser currentUser];
    
    if (currentUser) {
        
        NSLog(@"The Current User is %@",currentUser.username);
        
    }else {
        
        [self performSegueWithIdentifier:@"showLogin" sender:self];
    }
//
    [self viewWillAppear:YES];
//


    
}


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadObjects];
    
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



//Take off of local memory


-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    for (PFObject *d in self.objects) {
        [d unpinInBackground];
    }
    
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
    
    //take off local memory 
    
   
    
    
 
   
    
    cell.apartmentName.text = [object objectForKey:@"ApartmentName"];
    
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //apartmentInfo
    
  

    
    
    if ([[segue identifier] isEqualToString:@"apartmentInfo"]) {
        
        //Make sure to initialize tabbar controller
        UITabBarController *tabar = segue.destinationViewController;
        UINavigationController *navBar = [[tabar viewControllers]objectAtIndex:0];
        
        ApartmentInfoViewController *apartmentInfo = [[navBar viewControllers]objectAtIndex:0];
        
       
        
        NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
        PFObject *objet = pfobjectStorage [selectedIndexPath.row];
        apartmentInfo.fromSegue = objet;


        
    }
    
    
    
}

#pragma mark - Log Out
- (IBAction)logOutButton:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:false forKey:@"hasViewedWalkthrough"];
    
    [PFUser logOutInBackground];
    
    // Take the user back to the login segue
    
    [self performSegueWithIdentifier:@"showLogin" sender:self];
}
@end
