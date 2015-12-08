//
//  LoginViewController.m
//  Travel Buddy
//
//

#import "LoginViewController.h"
#import <Parse/Parse.h>
#import <QuartzCore/QuartzCore.h>

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Hide the Back Button
    
    
    
    
#pragma mark - LaTiesha's Code
    
    // changing the color of the placeholder text
    
    UIColor *color = [UIColor whiteColor];
    self.usernameField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"username" attributes:@{NSForegroundColorAttributeName: color}];
    self.passwordField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"password" attributes:@{NSForegroundColorAttributeName: color}];
    
    
    // rounding the corners of the sign up and login buttons
    
   self.logInButton.layer.cornerRadius = 15;
   self.logInButton.clipsToBounds = YES;
    
    self.signUpButton.layer.cornerRadius = 15;
    self.signUpButton.clipsToBounds = YES;
    
    
    
    
//    self.navigationItem.hidesBackButton = YES;   
  
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
        self.navigationItem.hidesBackButton = YES;
    self.navigationController.navigationBar.hidden = YES;  
    self.tabBarController.tabBar.hidden=YES;
    

}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.tabBarController.tabBar.hidden=NO;
    self.navigationController.navigationBar.hidden = NO;

    
    
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
                
//                [self dismissViewControllerAnimated:YES completion:nil];
                 [self.navigationController popToRootViewControllerAnimated:YES];
            
            }
            
        }];
        
        
    }
    
    
    
}

    
    
@end
