//
//  PasswordRecoverViewController.h
//  Travel Buddy
//
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface PasswordRecoverViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;


- (IBAction)resetButton:(id)sender;

- (IBAction)backButton:(id)sender;

@end
