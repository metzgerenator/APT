//
//  LargePhotoViewController.m
//  APT
//
//  Created by Michael Metzger  on 12/9/15.
//  Copyright © 2015 Mike. All rights reserved.
//

#import "LargePhotoViewController.h"

@interface LargePhotoViewController ()

@end

@implementation LargePhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.fileFromSegue getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
        if (!error) {
            
            self.largePhoto.image = [UIImage imageWithData:data];
            
        }
        
        
    }];
    
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

@end
