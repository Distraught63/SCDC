//
//  CalendarViewController.m
//  SCDC
//
//  Created by Leen  on 4/11/14.
//  Copyright (c) 2014 GAI. All rights reserved.
//

#import "CalendarViewController.h"

@interface CalendarViewController () <PDTSimpleCalendarViewDelegate>
{
    PDTSimpleCalendarViewController * calViewContainer;
}


@end

@implementation CalendarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //create Calendar child view
    calViewContainer = self.childViewControllers.lastObject;
    calViewContainer.delegate = self;
    
    //Nav bar customization
    UIImage *image = [UIImage imageNamed: @"UpperBarNewColor.png"];
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController.navigationBar setBackgroundImage:Nil forBarMetrics:UIBarMetricsDefault];
}


- (UIColor *)simpleCalendarViewController:(PDTSimpleCalendarViewController *)controller circleColorForDate:(NSDate *)date
{
    return [UIColor whiteColor];
}

- (UIColor *)simpleCalendarViewController:(PDTSimpleCalendarViewController *)controller textColorForDate:(NSDate *)date
{
    return [UIColor orangeColor];
}


- (void)simpleCalendarViewController:(PDTSimpleCalendarViewController *)controller didSelectDate:(NSDate *)clickedDate
{
    
    NSDate *todayDate = [[NSUserDefaults standardUserDefaults] objectForKey:@"date"];
    todayDate = clickedDate;
    [[NSUserDefaults standardUserDefaults] setObject:clickedDate forKey:@"date"];
    NSDate *today = [NSDate date];
//    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
//    [dateFormat setDateFormat:@"yyyy-MM-dd"];
//    NSString *theDate = [dateFormat stringFromDate:todayDate];
//    NSString *theToday = [dateFormat stringFromDate:today];
    
    
}

@end
