//
//  CalendarViewController.m
//  SCDC
//
//  Created by Leen  on 4/11/14.
//  Copyright (c) 2014 GAI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PDTSimpleCalendar.h"
#import "CalendarClassInfoTableViewController.h"

@interface CalendarViewController : UIViewController<ClassesInfoViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIView *calView;

@end
