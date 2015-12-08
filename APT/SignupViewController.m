//
//  SignupViewController.m
//  Travel Buddy
//


#import "SignupViewController.h"
#import <Parse/Parse.h>

@interface SignupViewController ()

@end

@implementation SignupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
#pragma mark - LaTiesha's Code
    
    // changing the color of the placeholder text
    
    
    
    UIColor *color = [UIColor whiteColor];
    self.userName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"username" attributes:@{NSForegroundColorAttributeName: color}];
    self.passwordField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"password" attributes:@{NSForegroundColorAttributeName: color}];
    
    self.emailField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"email" attributes:@{NSForegroundColorAttributeName: color}];
    
    
    // rounding the corners of the sign up and login buttons
    
    
    
    self.signUpButton.layer.cornerRadius = 15;
    self.signUpButton.clipsToBounds = YES;
    
    
    
    
}


-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.tabBarController.tabBar.hidden=YES;
    self.navigationController.navigationBar.hidden = NO;

    
    
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.tabBarController.tabBar.hidden=NO;
    
    
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/






- (IBAction)endEdit:(id)sender {
    [self.view endEditing:YES]; 
    
    
}

- (IBAction)signup:(id)sender {
    
    // white space methods trims any excess white space
    NSString *username = [self.userName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *passWord  = [self.passwordField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *email = [self.emailField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if ([username length] ==0 || [passWord length] == 0 || [email length] == 0) {
        UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"Oh No!" message:@"Make sure you enter a username, password and email!" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [alertView addAction:defaultAction];
        [self presentViewController:alertView animated:YES completion:nil];

    } else {
        PFUser *newUser = [PFUser user];
        newUser.username = username;
        newUser.password = passWord;
        newUser.email = email;
        
        [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
            if (error) {
                UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"Oh Boy!" message:[error.userInfo objectForKey:@"error"] preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                      handler:^(UIAlertAction * action) {}];
                
                [alertView addAction:defaultAction];
                [self presentViewController:alertView animated:YES completion:nil];

            }else {
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
        }];
        
    }
    
    
    
}
@end
