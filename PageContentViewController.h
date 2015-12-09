//
//  PageContentViewController.h
//  PageViewDemo
//
//  Created by Michael Metzger  on 12/9/15.
//  Copyright © 2015 Michael Metzger . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageContentViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (nonatomic) int index;
@property (strong, nonatomic) NSString *pageTitle;
@property (strong, nonatomic) NSString *pageImage;





- (IBAction)dismissWalkthrough:(id)sender;

@end
