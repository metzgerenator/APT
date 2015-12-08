//
//  SignupViewController.h
//  Travel Buddy


#import <UIKit/UIKit.h>

@interface SignupViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;

@property (weak, nonatomic) IBOutlet UIButton *signUpButton;



- (IBAction)endEdit:(id)sender;


- (IBAction)signup:(id)sender;

@end
