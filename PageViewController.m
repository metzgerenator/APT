//
//  PageViewController.m
//  PageViewDemo
//
//  Created by Michael Metzger  on 12/9/15.
//  Copyright © 2015 Michael Metzger . All rights reserved.
//

#import "PageViewController.h"

@interface PageViewController ()

@end

@implementation PageViewController {
    NSArray *pageTitles;
    NSArray *pageImages;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    pageTitles = @[@"View and change the lease price, location and more", @"Store all your apartments in one place", @"Easily add amenities and bedrooms"];
  
    pageImages = @[@"Property_Screen_1.jpg", @"Properties_Screen_1.jpg", @"Amenities_Screen_1.jpg"];
    
    //Set the page view data source to self
    self.dataSource = self;
    
    // Create the first walkthrough screen
    PageContentViewController *startingViewController = [self viewControllerAtIndex:0];
    
    if (startingViewController != nil) {
        [self setViewControllers:@[startingViewController] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];  
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





-(UIViewController *) pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    int index = ((PageContentViewController *) viewController).index;
    index--;
    
    return [self viewControllerAtIndex:index];
}


-(UIViewController *) pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    
    int index = ((PageContentViewController *) viewController).index;
    index ++;
    return [self viewControllerAtIndex:index];
    
    
    
}


#pragma mark - Helper Method 
-(PageContentViewController *) viewControllerAtIndex:(int)index {
    
    if (index < 0 || index >= pageTitles.count) {
        return nil;
    }
    
    PageContentViewController *pageContentViewController = (PageContentViewController *)
    [self.storyboard instantiateViewControllerWithIdentifier:@"PageContentController"];
    pageContentViewController.pageTitle = pageTitles[index];
    pageContentViewController.pageImage = pageImages[index];
    pageContentViewController.index = index;
    
    return pageContentViewController;
    
}


#pragma mark - page counter

-(NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    return  pageTitles.count;

}


-(NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    PageContentViewController *pageContentViewController = (PageContentViewController*)
    [self.storyboard instantiateViewControllerWithIdentifier:@"PageContentController"];
    
    return pageContentViewController.index;
    
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
