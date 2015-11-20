//
//  CreateAptViewController.m
//  APT
//
//  Created by Aileen Taboy on 11/14/15.
//  Copyright © 2015 Mike. All rights reserved.
//

#import "CreateAptViewController.h"
#import "NSDate+FSExtension.h"
#import "ApartmentInfoViewController.h"


@interface CreateAptViewController ()<FSCalendarDataSource, FSCalendarDelegate>

@end

@implementation CreateAptViewController

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



#pragma mark - FSCalendar date select

- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date
{
//    NSLog(@"did select %@",[date fs_stringWithFormat:@"yyyy/MM/dd"]);
    self.selectedDate = date;
}

- (void)calendarCurrentPageDidChange:(FSCalendar *)calendar
{
//    NSLog(@"did change page %@",[calendar.currentPage fs_stringWithFormat:@"yyyy-MM"]);
}






- (IBAction)saveButton:(id)sender {
    
    
    NSDate *currentTime = [self.dateInstance date];
    
            NSDateFormatter *timeFormatter = [[NSDateFormatter alloc]init];
            timeFormatter.dateFormat = @"HH:mm";
            NSString *timeSelected = [timeFormatter stringFromDate:currentTime];
    
            //    NSLog(@"time is %@",timeSelected);
    
            //Set the date
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
            dateFormatter.dateFormat = @"MM/dd/yy";
            NSString *dateSelected = [dateFormatter stringFromDate:self.selectedDate];
    
            //    NSLog(@"date is %@", dateSelected);
    
            self.combinedDateAndTime = [NSString stringWithFormat:@"%@ on %@", timeSelected,dateSelected];
    
            //    NSLog(@"final time is %@", combinedDateAndTime);
    

    
    [self performSegueWithIdentifier:@"apartment" sender:self];
}





@end
