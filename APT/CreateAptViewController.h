//
//  CreateAptViewController.h
//  APT
//
//  Created by Aileen Taboy on 11/14/15.
//  Copyright © 2015 Mike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FSCalendar/FSCalendar.h>

@protocol sendDataProtocol <NSObject>

-(void)sendDatatoA:(NSString *)newDate;

@end

@interface CreateAptViewController : UIViewController

@property(nonatomic,assign)id delegate;

@property (weak, nonatomic) IBOutlet UIDatePicker *dateInstance;

@property (nonatomic,strong)NSDate *selectedDate;


@property (nonatomic,strong)NSString *combinedDateAndTime;  




@end
