//
//  CalendarViewController.m
//  SCDC
//
//  Created by Leen  on 4/11/14.
//  Copyright (c) 2014 GAI. All rights reserved.
//

#import "CalendarViewController.h"
#import "DatabaseAccess.h"
#import "CalChildViewController.h"
#import "UIViewController+CWPopup.h"

@interface CalendarViewController () <PDTSimpleCalendarViewDelegate>
{
//    PDTSimpleCalendarViewController * calViewContainer;
}

@property (nonatomic) CalChildViewController * calViewContainer;
@property (strong, nonatomic) NSMutableArray *classDates;


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
    self.calViewContainer = self.childViewControllers.lastObject;
    self.calViewContainer.delegate = self;
    
    //Nav bar customization
    UIImage *image = [UIImage imageNamed: @"UpperBarNewColor.png"];
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
    
    
    //Get the classes
    self.classDates = [self getClassDates];
    
    //Reload view
    [self.calViewContainer reloadCollectionView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}


- (IBAction)dismissPopop:(id)sender {
    
    //Dismiss popup
    if (self.popupViewController != nil) {
        [self dismissPopupViewControllerAnimated:YES completion:^{
            NSLog(@"popup view dismissed");
        }];
    }
    
}

-(NSMutableArray *) getClassDates
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/dd/yyyy"];
    
    DatabaseAccess *db = [[DatabaseAccess alloc]init];
    NSMutableArray *classes= [db getClasses];
    NSMutableArray *result = [[NSMutableArray alloc]init];
    
    for (ClassInfo *clas in classes) {
        if (![result containsObject:clas.startDate]) {
            [result addObject:[formatter dateFromString:clas.startDate]];
        }
        else if (![result containsObject:clas.endDate])
        {
             [result addObject:[formatter dateFromString:clas.endDate]];
        }
    }
    
    return result;
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


-(BOOL)simpleCalendarViewController:(PDTSimpleCalendarViewController *)controller shouldUseCustomColorsForDate:(NSDate *)date
{
    return YES;
}


- (UIColor *)simpleCalendarViewController:(PDTSimpleCalendarViewController *)controller circleColorForDate:(NSDate *)date
{
     NSLog(@"Coloring Date");
    NSDate *today = [NSDate date];
    NSComparisonResult result;
    //has three possible values: NSOrderedSame,NSOrderedDescending, NSOrderedAscending
    result = [today compare:date]; // comparing two dates
    
    
    // create the date formatter with the correct format
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/dd/yyyy"];
    
    NSString *dateString = [formatter stringFromDate:date];
    
    NSDateFormatter* day = [[NSDateFormatter alloc] init];
    [day setDateFormat: @"EEEE"];
    NSLog(@"the day is: %@", [day stringFromDate:date]);
    
    
//    NSPredicate *pred = [NSPredicate predicateWithFormat:@"startDate <= %@ AND endDate > %@", dateString, dateString];
    
    if (result == NSOrderedAscending) {
        
        if(![@"Saturday" isEqualToString:[day stringFromDate:date]] && ![@"Sunday" isEqualToString:[day stringFromDate:date]] )
        {
            NSLog(@"green");
            
            

//            NSLog(@"Class with date %@ is %@ which has a start date of %@ and an end Date of %@", dateString,c.name, c.startDate, c.endDate );
            //Color circle green
            return [UIColor colorWithRed:0.0/255.0 green:204.0/255.0 blue:0.0/255.0 alpha:1];
        }
        else
        {
            NSLog(@"white");
            return [UIColor whiteColor];
        }
    }
    else if(result == NSOrderedDescending)
    {
         NSLog(@"whiteD");
        return [UIColor whiteColor];
    }
    else
    {
        if(![@"Saturday" isEqualToString:[day stringFromDate:date]] && ![@"Sunday" isEqualToString:[day stringFromDate:date]] )
        {
            NSLog(@"green");
            
            
            
            //            NSLog(@"Class with date %@ is %@ which has a start date of %@ and an end Date of %@", dateString,c.name, c.startDate, c.endDate );
            //Color circle green
            return [UIColor colorWithRed:0.0/255.0 green:204.0/255.0 blue:0.0/255.0 alpha:1];
        }
        else
        {
            NSLog(@"white");
            return [UIColor whiteColor];
        }    }
    
    
    return [UIColor whiteColor];
}

- (UIColor *)simpleCalendarViewController:(PDTSimpleCalendarViewController *)controller textColorForDate:(NSDate *)date
{
    return [UIColor blackColor];
}


- (void)simpleCalendarViewController:(PDTSimpleCalendarViewController *)controller didSelectDate:(NSDate *)clickedDate
{
    
    NSDate *todayDate = [[NSUserDefaults standardUserDefaults] objectForKey:@"date"];
    todayDate = clickedDate;
    [[NSUserDefaults standardUserDefaults] setObject:clickedDate forKey:@"date"];
    
    
    //Get view that we want to pop up
   CalendarClassInfoTableViewController *classesVC = [[CalendarClassInfoTableViewController alloc] init];
    
    
    //Create the classes table view with a nav bar
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:classesVC];
    
    //Create a delgate to communicate that the user is done
    classesVC.delegate = self;
    
    //Pass date
    classesVC.date = clickedDate;
    
    
    
    //Set the frame for our popup view
    navController.view.frame = CGRectMake(0, 0, 250, 350);
    
    

    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController.navigationBar setBackgroundImage:Nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor]}];
}

@end
