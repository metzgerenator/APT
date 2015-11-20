//
//  PasswordRecoverViewController.m
//  Travel Buddy
//

//

#import "PasswordRecoverViewController.h"
#import "LoginViewController.h"

@interface PasswordRecoverViewController ()

@end

@implementation PasswordRecoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)resetButton:(id)sender {
    
    NSString *email  = [self.emailTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    
    if (email.length == 0) {
        UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"oops!"
                                                                           message:@"make sure you enter an email"
                                                                    preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK"
                                                                style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction *action) {}];
        
        [alertView addAction:defaultAction];
        [self presentViewController:alertView animated:YES completion:nil];
                                        
    }
    else {
        
        [PFUser requestPasswordResetForEmailInBackground:email block:^(BOOL succeeded, NSError * _Nullable error) {
            if (error){
                UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"Oh No!" message:[error.userInfo objectForKey:@"error"] preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){}];
                
                [alertView addAction:defaultAction];
                [self presentViewController:alertView animated:YES
                                 completion:nil];
            } else {
                [self.navigationController popViewControllerAnimated:YES];
            }
        }];
    }
    
    
    
    
}

- (IBAction)backButton:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end
