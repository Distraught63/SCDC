//
//  CalendarViewController.m
//  SCDC
//
//  Created by Leen  on 4/11/14.
//  Copyright (c) 2014 GAI. All rights reserved.
//

#import "CalendarViewController.h"
#import "MainMenuViewController.h"
#import <EventKit/EventKit.h>


@interface CalendarViewController () <PDTSimpleCalendarViewDelegate>

@property (nonatomic, strong) NSArray *customDates;

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

-(void)loadView
{
    
    self.window = [[UIWindow alloc] initWithFrame:CGRectMake(0, 64, 320, 367)];
//    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"dd/MM/yyyy";
    _customDates = @[[dateFormatter dateFromString:@"01/05/2014"], [dateFormatter dateFromString:@"01/06/2014"], [dateFormatter dateFromString:@"01/07/2014"]];
    
    PDTSimpleCalendarViewController *calendarViewController = [[PDTSimpleCalendarViewController alloc] init];
    //This is the default behavior, will display a full year starting the first of the current month
    [calendarViewController setDelegate:self];
    
    PDTSimpleCalendarViewController *hebrewCalendarViewController = [[PDTSimpleCalendarViewController alloc] init];
    //Example of how you can change the default calendar
    //Other options you can try NSPersianCalendar, NSIslamicCalendar, NSIndianCalendar, NSJapaneseCalendar, NSRepublicOfChinaCalendar
    NSCalendar *hebrewCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSHebrewCalendar];
    hebrewCalendar.locale = [NSLocale currentLocale];
    [hebrewCalendarViewController setCalendar:hebrewCalendar];
    
    PDTSimpleCalendarViewController *dateRangeCalendarViewController = [[PDTSimpleCalendarViewController alloc] init];
    //For this calendar we're gonna allow only a selection between today and today + 3months.
    dateRangeCalendarViewController.firstDate = [NSDate date];
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    offsetComponents.month = 3;
    NSDate *lastDate =[dateRangeCalendarViewController.calendar dateByAddingComponents:offsetComponents toDate:[NSDate date] options:0];
    dateRangeCalendarViewController.lastDate = lastDate;
    
    //Set the edgesForExtendedLayout to UIRectEdgeNone
    if ([UIViewController instancesRespondToSelector:@selector(edgesForExtendedLayout)]) {
        [calendarViewController setEdgesForExtendedLayout:UIRectEdgeNone];
        [hebrewCalendarViewController setEdgesForExtendedLayout:UIRectEdgeNone];
        [dateRangeCalendarViewController setEdgesForExtendedLayout:UIRectEdgeNone];
    }
    
    //Create Navigation Controller
    UINavigationController *defaultNavController = [[UINavigationController alloc] initWithRootViewController:calendarViewController];
    [calendarViewController setTitle:@"SimpleCalendar"];
    
    UINavigationController *hebrewNavController = [[UINavigationController alloc] initWithRootViewController:hebrewCalendarViewController];
    [hebrewCalendarViewController setTitle:@"Hebrew Calendar"];
    
    UINavigationController *dateRangeNavController = [[UINavigationController alloc] initWithRootViewController:dateRangeCalendarViewController];
    [dateRangeCalendarViewController setTitle:@"Custom Range"];
    
    //Create the Tab Bar Controller
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    [tabBarController setViewControllers:@[defaultNavController, hebrewNavController, dateRangeNavController]];
    
    
    //Example of how you can now customize the calendar colors
    //    [[PDTSimpleCalendarViewCell appearance] setCircleDefaultColor:[UIColor whiteColor]];
    //    [[PDTSimpleCalendarViewCell appearance] setCircleSelectedColor:[UIColor orangeColor]];
    //    [[PDTSimpleCalendarViewCell appearance] setCircleTodayColor:[UIColor blueColor]];
    //    [[PDTSimpleCalendarViewCell appearance] setTextDefaultColor:[UIColor redColor]];
    //    [[PDTSimpleCalendarViewCell appearance] setTextSelectedColor:[UIColor purpleColor]];
    //    [[PDTSimpleCalendarViewCell appearance] setTextTodayColor:[UIColor magentaColor]];
    //    [[PDTSimpleCalendarViewCell appearance] setTextDisabledColor:[UIColor purpleColor]];
    //
    //    [[PDTSimpleCalendarViewHeader appearance] setTextColor:[UIColor redColor]];
    //    [[PDTSimpleCalendarViewHeader appearance] setSeparatorColor:[UIColor orangeColor]];
    
    [self.window setRootViewController:tabBarController];
    [self.window makeKeyAndVisible];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    
//    [self addEvent];
    // Do any additional setup after loading the view.
}

/*
-(void)addEvent
{
    EKEventStore *eventStore = [[EKEventStore alloc] init];
    
    EKEvent *event = [EKEvent eventWithEventStore:eventStore];
    event.title = @"Test Event";
    event.startDate = [NSDate date];
    event.endDate = [NSDate date];
    
    if ([eventStore respondsToSelector:@selector(requestAccessToEntityType:completion:)])
    {
        // the selector is available, so we must be on iOS 6 or newer
        [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (error)
                {
                    // display error message here
                }
                else if (!granted)
                {
                    // display access denied error message here
                }
                else
                {
                    [event setCalendar:[eventStore defaultCalendarForNewEvents]];
                    NSError *err;
                    [eventStore saveEvent:event span:EKSpanThisEvent error:&err];
                    // access granted
                    // ***** do the important stuff here *****
                }
            });
        }];
    }
    else
    {
        // this code runs in iOS 4 or iOS 5
        // ***** do the important stuff here *****
    }
}*/

-(IBAction)backButton:(id)sender
{
   [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - PDTSimpleCalendarViewDelegate

- (void)simpleCalendarViewController:(PDTSimpleCalendarViewController *)controller didSelectDate:(NSDate *)date
{
    NSLog(@"Date Selected : %@",date);
}

- (BOOL)simpleCalendarViewController:(PDTSimpleCalendarViewController *)controller shouldUseCustomColorsForDate:(NSDate *)date
{
    if ([self.customDates containsObject:date]) {
        return YES;
    }
    
    return NO;
}

- (UIColor *)simpleCalendarViewController:(PDTSimpleCalendarViewController *)controller circleColorForDate:(NSDate *)date
{
    return [UIColor whiteColor];
}

- (UIColor *)simpleCalendarViewController:(PDTSimpleCalendarViewController *)controller textColorForDate:(NSDate *)date
{
    return [UIColor orangeColor];
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

@end
