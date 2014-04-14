//
//  CalendarViewController.h
//  SCDC
//
//  Created by Leen  on 4/11/14.
//  Copyright (c) 2014 GAI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TSQCalendarView.h"

@interface CalendarViewController : UIViewController <TSQCalendarViewDelegate>
@property (weak, nonatomic) IBOutlet TSQCalendarView *calendarView;

@end
