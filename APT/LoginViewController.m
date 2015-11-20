//
//  LoginViewController.m
//  Travel Buddy
//
//

#import "LoginViewController.h"
#import <Parse/Parse.h>

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Hide the Back Button
    
    self.navigationItem.hidesBackButton = YES;   
  
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)login:(id)sender {
    
    NSString *username = [self.usernameField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *passWord  = [self.passwordField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

    
    if ([username length] ==0 || [passWord length] == 0) {
        UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"Oh NO!" message:@"Make sure you enter a username and password!" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [alertView addAction:defaultAction];
        [self presentViewController:alertView animated:YES completion:nil];
    } else {
        
        [PFUser logInWithUsernameInBackground:username password:passWord block:^(PFUser * _Nullable user, NSError * _Nullable error) {
            
            if (error) {
                UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"Oh Boy!" message:[error.userInfo objectForKey:@"error"] preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                      handler:^(UIAlertAction * action) {}];
                
                [alertView addAction:defaultAction];
                [self presentViewController:alertView animated:YES completion:nil];
            
            } else {
                [self.navigationController popToRootViewControllerAnimated:YES];  
            }
            
        }];
        
        
    }
    
    
    
}

    
    
@end
