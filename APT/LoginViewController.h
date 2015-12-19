//
//  LoginViewController.h
//  Travel Buddy
//


#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController  
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;


@property (weak, nonatomic) IBOutlet UIButton *logInButton;

@property (weak, nonatomic) IBOutlet UIButton *signUpButton;


- (IBAction)endEdit:(id)sender;


- (IBAction)login:(id)sender;

@end
