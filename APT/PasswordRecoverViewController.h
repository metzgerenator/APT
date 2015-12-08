//
//  PasswordRecoverViewController.h
//  Travel Buddy
//
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface PasswordRecoverViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;

@property (weak, nonatomic) IBOutlet UIButton *backButton;

@property (weak, nonatomic) IBOutlet UIButton *resetButton;

- (IBAction)endEdit:(id)sender;



- (IBAction)resetButton:(id)sender;

- (IBAction)backButton:(id)sender;

@end
